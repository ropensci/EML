# Add example from ropenfisheries showing how factor definitions can come from two columns, rather than long entry...
# Date should support R format strings (%Y, %m, %d) as well as EML strings (YYYY, MM, DD)


# The weird thing about this is that it defines a loose object for unit.defs.  perhaps we should define as an explicit class(?!) 

# numeric: 
#   required: unit
#   optional: 
#     - type (natural, integer, real). If not given will be inferred from the column
#     - precision (numeric)
#     - bounds 
#     - interval? (logical)  Otherwwise assumed to be aratio

# dateTime
#   required: format format string
#   optional:
#     - precision


