## using a simple character string
a <- set_TextType(text = "This is the abstract")
as(a, "abstract")

## Using an external markdown file
f <- system.file("examples/hf205-abstract.md", package = "EML")
a <- set_TextType(f)
as(a, "abstract")

## Can also import from methods written in a .docx MS Word file.
f <- system.file("examples/hf205-abstract.docx", package = "EML")
a <- set_TextType(f)
as(a, "abstract")

## Documents can have richer formatting.  Documents with title headings use `section` instead of `para` notation
f <- system.file("examples/hf205-methods.docx", package = "EML")
d <- set_TextType(f)
as(d, "description")
 
