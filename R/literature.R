setClass("citation", 
         slots = c(article = "character")) ## FIXME flush this out
setAs("XMLInternalElementNode", "creator", function(from) emlToS4(from))
setAs("creator", "XMLInternalElementNode", function(from) S4Toeml(from))

