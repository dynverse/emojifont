##' search fontawesome
##'
##'
##' @title search_fontawesome
##' @param str string text
##' @param approximate logical
##' @return corresponding aliases
##' @export
##' @author ygc
search_fontawesome <- function(str, approximate=FALSE) {
    efproto$search(str=str, type='aliases', approximate=approximate, font_data=fontawesome_data)
}


##' random fontawesome
##'
##'
##' @title sample_fontawesome
##' @param size a non-negative integer giving the number of items to choose
##' @param replace Should sampling be with replacement?
##' @return random fontawesome
##' @export
##' @examples
##' sample_fontawesome(3)
##' @author guangchuang yu
sample_fontawesome <- function(size, replace=FALSE) {
    sample(unlist(fontawesome_data$aliases), size, replace)
}

##' convert fontawesome aliases to text
##'
##'
##' @title fontawesome
##' @param aliases aliases
##' @return text
##' @export
##' @examples
##' fontawesome('fa-twitter')
##' @author ygc
fontawesome <- function(aliases) {
    mapper_(aliases, fontawesome_data)
}

##' load fontawesome
##'
##'
##' @title load.fontawesome
##' @param font font
##' @return NULL
##' @export
##' @author ygc
load.fontawesome <- function(font = c("fa-regular-400.ttf", "fa-brands-400.ttf", "fa-solid-900.ttf")) {
    for (fo in font) {
      efproto$load_font(font=fo, type='fontawesome')
    }
}




## example
## library(emojifont)
## load.fontawesome()
## set.seed(123)
## d = data.frame(x=rnorm(20),
##                y=rnorm(20),
##                z=sample(fontawesome(c('fa-weibo','fa-github', 'fa-twitter', 'fa-apple')), replace=T, 10))

## library(ggplot2)
## ggplot(d, aes(x, y, color=z)) + geom_text(aes(label=z), family='fontawesome-webfont', size=8)
