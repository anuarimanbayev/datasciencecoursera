w2q2q4 <- function(){
        # Loading Data
        library(XML)
        con = url("http://biostat.jhsph.edu/~jleek/contact.html")
        htmlCode = readLines(con)
        close(con)
        
        # Finding the number of characters for 10th, 20th, 30th, 100th lines of the HTML
        a <- nchar(htmlCode[10])
        b <- nchar(htmlCode[20])
        c <- nchar(htmlCode[30])
        d <- nchar(htmlCode[100])
        output <- c(a, b, c, d)
        output
}