attributes_ui <- function() {
  ui <- shiny::fluidPage(
    shinyjs::useShinyjs(),
    shiny::br(),
    shiny::tags$button(
      id = "quit",
      type = "button",
      class = "btn action-button btn-danger btn-lg",
      onclick = "setTimeout(function(){window.close();},100);", "Quit App"
    ),
    shiny::tags$button(
      id = "help",
      type = "button",
      class = "btn action-button btn-info btn-lg",
      "Help"
    ),
    shiny::br(),
    shiny::br(),
    shiny::mainPanel(
      width = 12,
      shiny::tabsetPanel(
        id = "tabs",
        shiny::tabPanel(
          "Attributes Table",
          shiny::br(),
          shiny::downloadButton("download_att",
            label = "Download Attributes",
            class = "btn btn-primary"
          ),
          shiny::br(),
          shiny::br(),
          htmlwidgets_attributes_output("att_table")
        ),
        shiny::tabPanel(
          "Units Table",
          shiny::br(),
          shiny::downloadButton("download_units",
            label = "Download Custom Units",
            class = "btn btn-primary"
          ),
          shiny::br(),
          shiny::br(),
          htmlwidgets_attributes_output("units_table")
        ),
        shiny::tabPanel(
          "Factors Table",
          shiny::br(),
          shiny::downloadButton("download_factors",
            label = "Download Factors",
            class = "btn btn-primary"
          ),
          shiny::br(),
          shiny::br(),
          htmlwidgets_attributes_output("factors_table")
        )
      )
    )
  )
}

attributes_server <- function(attributes, data) {
  server <- function(input, output, session) {
    #################### Attributes Table Inputs ####################
    ## Intialize units in attributes
    eml_units <- get_unitList()$units
    eml_units$standard <- TRUE
    attributes$unit <- unlist(lapply(attributes$unit, function(x) {
      if (x != "") {
        out <- get_unit_id(x)
      } else {
        out <- ""
      }

      if (out == "") {
        out <- x
      }

      return(out)
    }))

    ## Intialize attributes reactive
    react_att <- shiny::reactiveVal(attributes)

    ## Disable/Enable download button based on whether download will work
    shiny::observeEvent(input$attributes, {
      tryCatch({
        out_att()
        shinyjs::enable("download_att")
      }, error = function(err) {
        shinyjs::disable("download_att")
      })
    })

    #################### Units Table Inputs ####################
    ## Initiallize units reactive
    react_units <- shiny::reactiveVal(build_units_table(attributes$unit,
                                                        eml_units))

    ## Get new units from att_table (update attributes and units tables)
    shiny::observeEvent(input$att_table$changes, {
      react_att(table_to_r(input$att_table))

      changes <- input$att_table$changes

      for (i in seq(length(changes))) {
        if (colnames(react_att())[changes[[i]][[2]] + 1] == "unit") {

          ## Get units
          new <- build_units_table(changes[[i]][[4]], eml_units)
          id <- new$id

          ## Update Attributes Table
          if (length(id) > 0) {
            att_out <- react_att()
            att_out$unit[(changes[[i]][[1]] + 1)] <- id
            react_att(att_out)
          }

          ## Update Units Table
          out <- rbind(react_units(), new, stringsAsFactors = FALSE)
          out <- out[!duplicated(out$id), ]
          out <- out[which(out$id %in% react_att()$unit), ]

          react_units(out)
        }

        # Clean up units when removed by deleting measurementScale
        out <- react_units()
        out <- out[which(out$id %in% react_att()$unit), ]
        react_units(out)
      }
    })

    ## Save changes to units_table
    shiny::observeEvent(input$units_table$changes, {
      out <- table_to_r(input$units_table)
      react_units(out)
    })

    ## Disable/Enable download button
    shiny::observeEvent(input$units_table, {
      tryCatch({
        out_units()
        shinyjs::enable("download_units")
      }, error = function(err) {
        shinyjs::disable("download_units")
      })
    })

    #################### Factors Inputs ####################
    ## Initiallize factors
    df_factors <- shiny::reactiveVal(build_factors(attributes, data))

    ## Get new factors from att_table
    shiny::observeEvent(input$att_table$changes, {
      changes <- input$att_table$changes

      for (i in seq(length(changes))) {
        if (colnames(react_att())[changes[[i]][[2]] + 1] == "domain") {
          if (!is.null(changes[[i]][[4]]) && changes[[i]][[4]] == "enumeratedDomain") {
            change <- react_att()[changes[[i]][[1]] + 1, ]
            new <- build_factors(change, data)
            out <- rbind(df_factors(), new)
            df_factors(out)
          } else if (!is.null(changes[[i]][[3]]) && changes[[i]][[3]] ==
            "enumeratedDomain" && changes[[i]][[4]] != "enumeratedDomain") {
            out <- df_factors()[df_factors()$attributeName != react_att()$attributeName[changes[[i]][[1]] + 1], ]
            df_factors(out)
          }
        }
      }
    })

    ## Save changes to factors_table
    shiny::observeEvent(input$factors_table$changes, {
      df_factors(table_to_r(input$factors_table))
    })

    ## Disable/Enable download button
    shiny::observeEvent(input$factors_table, {
      tryCatch({
        out_factors()
        shinyjs::enable("download_factors")
      }, error = function(err) {
        shinyjs::disable("download_factors")
      })
    })


    #################### Attributes Table Outputs ####################
    ## Attributes output table
    out_att <- shiny::reactive({
      table_to_r(input$att_table)
    })

    ## Attributes handsontable
    output$att_table <- render_htmlwidgets_attributes({
      htmlwidgets_attributes(react_att(), type = "attributes")
    })

    output$download_att <- shiny::downloadHandler(filename = "Attributes_Table.csv", content = function(file) {
      data <- out_att()
      utils::write.csv(data, file, row.names = FALSE)
    })

    #################### Units Table Outputs ####################
    ## Units output table
    out_units <- shiny::reactive({
      out <- table_to_r(input$units_table)
      out <- out[!(out$id %in% eml_units$id), ]
      out[, !(colnames(out) %in% c("standard"))]
    })

    ## Units hot table
    output$units_table <- render_htmlwidgets_attributes({
      out <- react_units()
      htmlwidgets_attributes(out, type = "units")
    })

    output$download_units <- shiny::downloadHandler(filename = "Custom_Units.csv", content = function(file) {
      data <- out_units()
      utils::write.csv(data, file, row.names = FALSE)
    })

    #################### Factors Outputs ####################
    # Factors hot table
    output$factors_table <- render_htmlwidgets_attributes({
      htmlwidgets_attributes(df_factors(), type = "factors")
    })

    # Factors output table
    out_factors <- shiny::reactive({
      out <- table_to_r(input$factors_table)
    })

    output$download_factors <- shiny::downloadHandler(filename = "Factors.csv", content = function(file) {
      data <- out_factors()
      utils::write.csv(data, file, row.names = FALSE)
    })

    #################### Quit ####################
    shiny::observeEvent(input$quit, {
      attributes <- out_att()

      units <- tryCatch({
        out_units()
      }, error = function(err) {
        NA
      })

      factors <- tryCatch({
        out_factors()
      }, error = function(err) {
        NA
      })

      out <- list(attributes = attributes, units = units, factors = factors)
      shiny::stopApp(out)
    })

    #################### Help ####################
    shiny::observeEvent(input$help, {
      shiny::showModal(shiny::modalDialog(
        size = "l",
        title = "Help",
        shiny::HTML("Use the <b>Attributes Table</b> tab to build attribute information.<br>
                    <font color='#ff6666'>Pink</font> cells indicate an incomplete cell that needs information.<br>
                    <font color='#999999'>Grey</font> cells indicate no information is needed for that cell.<br><br>

                    Units will automatically update to an EML format.<br>
                    To prevent automatic generation of EML format, input unit in quotes (e.g. 'pH').<br><br>

                    Use the <b>Units Table</b> tab to build units information.<br>
                    <font color='#99cc33'>Green</font> cells indicate the id corresponds to an EML standard unit.<br>
                    <font color='#99cc33'>Green</font> cells will not be exported when exporting the <b>Units Table</b>.<br><br>

                    Use the <b>Factors Table</b> tab to build factors information.<br>
                    Factors are needed for attributes with enumeratedDomains.<br>
                    Factor codes will automatically generate for each enumeratedDomain when data is present.<br><br>

                    After quitting the app, the tables will be returned as a list.<br>
                    Additionally, you can use the button above each table to export to a csv file.")
      ))
    })
  }
}
