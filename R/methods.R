### Methods ### 
setClass("methodStep", 
         representation(description = "character")) # software, 
setClass("methods", 
         representation(methodsStep = "methodStep"))

setAs("XMLInternalElementNode", "methodStep",  function(from) emlToS4(from))
setAs("XMLInternalElementNode", "methods",  function(from) emlToS4(from))

