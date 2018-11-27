HTMLWidgets.widget({

    name: 'htmlwidget_attributes_table',

    type: 'output',

    initialize: function(el, width, height) {

        return {
        };

    },

    renderValue: function(el, x, instance) {

        // Set options
        x.contextMenu = ['row_above', 'row_below', 'remove_row'];
        x.viewportRowRenderingOffset = 0;
        x.fixedColumnsLeft = 1;

        // If instance already exists update old instance
        if (instance.hot) {
            instance.hot.updateSettings(x);

        // Create new handsontable
        } else {
            instance.hot = new Handsontable(el, x);
        }

        var colHeaders =  instance.hot.getColHeader(),
        changes = null;

        if (HTMLWidgets.shinyMode) {
            Shiny.onInputChange(el.id, {data: instance.hot.getData(), colnames: colHeaders, changes: changes});
        }

        // Attributes settings
        if (x.rType == "attributes") {

            // Set source information and get column names
            var allDomains = ["dateTimeDomain", "enumeratedDomain", "numericDomain", "textDomain"],
            allMeasurementScales = ["dateTime", "interval", "nominal", "ordinal", "ratio"],
            allNumberTypes = ["integer", "natural", "real", "whole"];

            var n_measurementScale = colHeaders.findIndex(n => n == "measurementScale"),
            n_domain = colHeaders.findIndex(n => n == "domain"),
            n_definition = colHeaders.findIndex(n => n == "definition"),
            n_formatString = colHeaders.findIndex(n => n == "formatString"),
            n_numberType = colHeaders.findIndex(n => n == "numberType"),
            n_unit = colHeaders.findIndex(n => n == "unit"),
            n_mVC = colHeaders.findIndex(n => n == "missingValueCode"),
            n_mVCE = colHeaders.findIndex(n => n == "missingValueCodeExplanation");

            // Set sources
            instance.hot.updateSettings({
                cells: function (row, col, prop) {

                    var cellProperties = {};

                    if (col == n_domain) {
                        cellProperties.source = getDomain(instance.hot.getDataAtCell(row, n_measurementScale));
                        return cellProperties;
                    }

                    if (col == n_measurementScale) {
                        cellProperties.source = getMeasurementScale(instance.hot.getDataAtCell(row, n_domain));
                        return cellProperties;
                    }

                    if (col == n_numberType) {
                        cellProperties.source = allNumberTypes;
                        return cellProperties;
                    }


                }
            });

            // Create dynamic updates
            instance.hot.addHook('beforeChange', function(changes, src) {

                updateAttCells(changes);

            });

        }

        // Record change
        instance.hot.addHook('afterChange', function(changes, src) {

            if (HTMLWidgets.shinyMode) {

                Shiny.onInputChange(el.id, {data: instance.hot.getData(), colnames: colHeaders, changes: changes});
            }

        });

        instance.hot.addHook('afterRemoveRow', function(changes, src) {

            if (HTMLWidgets.shinyMode) {
                Shiny.onInputChange(el.id, {data: instance.hot.getData(), colnames: colHeaders, changes: null});
            }

        });

        // Get domain based on measurementScale
        function getDomain(measurementScale) {

            if (measurementScale === 'dateTime') {
                return [allDomains[0]];

            } else if (measurementScale === 'ratio' || measurementScale === 'interval') {
                return [allDomains[2]];

            } else if (measurementScale === 'ordinal' || measurementScale === 'nominal') {
                return [allDomains[1], allDomains[3]];

            } else if (measurementScale === null || measurementScale === '') {
                return allDomains;
            }

        }

        // Get measurementScale based on domain
        function getMeasurementScale(domain) {

            if (domain === 'dateTimeDomain') {
                return [allMeasurementScales[0]];

            } else if (domain === 'numericDomain') {
                return [allMeasurementScales[1], allMeasurementScales[4]];

            } else if (domain === 'enumeratedDomain' || domain === 'textDomain') {
                return [allMeasurementScales[2], allMeasurementScales[3]];

            } else if (domain === null || domain === '') {
                return allMeasurementScales;
            }
        }

        // opinionated update
        function updateAttCells(changes) {

            for (i = 0; i < changes.length; i++) {
                row = changes[i][0],
                col = changes[i][1],
                newVal = changes[i][3];

                if (col == n_measurementScale) {

                    if (newVal === null || newVal === "") {
                        x.data[row][n_domain] = "",
                        x.data[row][n_unit] = "",
                        x.data[row][n_numberType] = "";

                    } else if (newVal == "dateTime") {
                        x.data[row][n_domain] = allDomains[0];

                    } else if (newVal == "interval" || newVal == "ratio") {
                        x.data[row][n_domain] = allDomains[2];
                    }

                }

                if (col == n_domain) {

                    if (newVal != "textDomain") {
                        x.data[row][n_definition] = "";
                    }

                    if (newVal != "dateTimeDomain") {
                        x.data[row][n_formatString] = "";
                    }

                    if (newVal != "numericDomain") {
                        x.data[row][n_unit] = "";
                        x.data[row][n_numberType] = "";
                    }

                }

                if (col == n_mVC) {
                    if (newVal === null || newVal  ===  "") {
                        x.data[row][n_mVCE] = "";
                    }
                }
            }

        }

    }

});

//Custom renderers
function customText_att( instance, td, row, col, prop, value, cellProperties) {
    Handsontable.renderers.TextRenderer.apply(this, arguments);

    var colHeaders = instance.getColHeader(),
    n_domain = colHeaders.findIndex(n => n == "domain");
    n_mVC = colHeaders.findIndex(n => n == "missingValueCode");

    if (value === null || value === "") {

        if ((colHeaders[col] == "attributeName" || colHeaders[col] == "attributeDefinition" || colHeaders[col] == "measurementScale")) {
            td.className = "needData";
        }

        if (colHeaders[col] == "definition") {

            if (instance.getData()[row][n_domain] == "textDomain") {
                td.className = "needData";
                cellProperties.readOnly = false;

            } else {
                td.className = "notNeeded";
                cellProperties.readOnly = true;
            }
        }

        if (colHeaders[col] == "formatString") {

            if (instance.getData()[row][n_domain] == "dateTimeDomain") {
                td.className = "needData";
                cellProperties.readOnly = false;

            } else {
                td.className = "notNeeded";
                cellProperties.readOnly = true;
            }
        }

        if (colHeaders[col] == "unit") {

            if (instance.getData()[row][n_domain] == "numericDomain") {
                td.className = "needData";
                cellProperties.readOnly = false;

            } else {
                td.className = "notNeeded";
                cellProperties.readOnly = true;
            }
        }

        if (colHeaders[col] == "missingValueCodeExplanation") {

            if (instance.getData()[row][n_mVC] !== null && instance.getData()[row][n_mVC] !== "") {
                td.className = "needData";
                cellProperties.readOnly = false;

            } else {
                td.className = "notNeeded";
                cellProperties.readOnly = true;
            }
        }

    } else {
        td.style.color = "#7f7f7f";
    }

    return td;
}

function customDropdown_att( instance, td, row, col, prop, value, cellProperties) {
    Handsontable.renderers.DropdownRenderer.apply(this, arguments);

    var colHeaders = instance.getColHeader(),
    n_measurementScale = colHeaders.findIndex(n => n == "measurementScale"),
    n_domain = colHeaders.findIndex(n => n == "domain");

    if (value === null || value === "") {

        if (colHeaders[col] == "measurementScale") {
            td.className = "needData";
        }

        if (colHeaders[col] == "domain") {

            if (instance.getData()[row][n_measurementScale] === null || instance.getData()[row][n_measurementScale] === "") {
                td.className = "notNeeded";
                cellProperties.readOnly = true;

            } else {
                td.className = "needData";
                cellProperties.readOnly = false;
            }
        }

        if (colHeaders[col] == "numberType") {

            if ( instance.getData()[row][n_domain] == "numericDomain") {
                td.className = "needData";
                cellProperties.readOnly = false;

            } else {
                td.className = "notNeeded";
                cellProperties.readOnly = true;
            }
        }

    } else {
        td.style.color = "#7f7f7f";
    }

    return td;
}

function customText_units( instance, td, row, col, prop, value, cellProperties) {
    Handsontable.renderers.TextRenderer.apply(this, arguments);

    var colHeaders = instance.getColHeader(),
    n_isSU = colHeaders.findIndex(n => n == "standard");

    if (instance.getData()[row][n_isSU] === "TRUE") {
        td.className = "standardUnit";
        td.style.color = "#7f7f7f";
    }

    if (instance.getData()[row][n_isSU] === "FALSE") {

        if (value === null || value === "") {
            td.className = "needData";

        } else {
            td.style.color = "#7f7f7f";
        }
    }


    return td;
}

function customText( instance, td, row, col, prop, value, cellProperties) {
    Handsontable.renderers.TextRenderer.apply(this, arguments);

    if (value === null || value === "") {
        td.className = "needData";

    } else {
        td.style.color = "#7f7f7f";
    }

    return td;
}


