
setClass("slotA", contains = "character")
setClass("testclass", slots = c("slotA" = "slotA"))
x <- new("testclass")
class(x@slotA)


setClass("metaclass", contains = "testclass")
x <- new("metaclass")
class(x@slotA)



setClass("testclassB", slots = c("slotA" = "slotA", "slotB" = "character"))
x <- new("testclassB", slotB = "stuff")
class(x@slotA)


setClass("testclassC", slots = c("slotA" = "testclassB", "slotB" = "character"))
x <- new("testclassC", slotB = "stuff")
class(x@slotA)

setClass("listof", contains = list(), prototype = list( list(new("slotA"))))

setClass("testclass2", slots = c("slotA" = "slotA"), prototype = list(slotA = new("slotA")))
y <- new("testclass2")
class(y@slotA)
