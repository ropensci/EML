### Methods ### 
setClass("methodStep", 
         representation(description = "character")) # software, 
setAs("XMLInternalElementNode", "methodStep",  function(from) emlToS4(from))
setAs("methodStep", "XMLInternalElementNode",   function(from) S4Toeml(from))

setClass("methods", 
         representation(methodsStep = "methodStep"))
setAs("XMLInternalElementNode", "methods",  function(from) emlToS4(from))
setAs("methods", "XMLInternalElementNode",   function(from) S4Toeml(from))

