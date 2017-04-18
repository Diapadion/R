#'  Apply the Exploratory Graph Analysis technique
#'
#' \code{EGA} Estimates the number of dimensions of a given dataset/instrument using graphical lasso and a random walk algorithm. The glasso regularization parameter
#' is set via EBIC.
#'
#' @param data A dataframe with the variables to be used in the analysis.
#' @param plot.EGA Logical. If true, returns a plot of the network of partial correlations estimated via graphical lasso and its estimated dimensions.
#' @author Hudson F. Golino <hfgolino at gmail.com>
#' @examples
#' ega.wmt <- EGA(data = wmt2[,7:24], plot.EGA = TRUE)
#' ega.intel <- EGA(data = intelligenceBattery[,8:66])
#'
#' \dontrun{
#' EGA(a)
#' }
#' @seealso \code{\link{bootEGA}} to investigate the stability of EGA's estimation via bootstrap and \code{\link{CFA}} to
#' verify the fit of the structure suggested by EGA using confirmatory factor analysis.
#' @export


# EGA default function - 01/18/2017


EGA <- function(data, plot.EGA = TRUE) {
  if(!require(qgraph)) {
    message("installing the 'qgraph' package")
    install.packages("qgraph")
  }

  if(!require(igraph)) {
    message("installing the 'igraph' package")
    install.packages("igraph")
  }

    data <- as.data.frame(data)
    cor.data <- cor_auto(data)
    glasso.ebic <- EBICglasso(S = cor.data, n = nrow(data), lambda.min.ratio = 0.1)
    graph.glasso <- as.igraph(qgraph(glasso.ebic, layout = "spring", vsize = 3, DoNotPlot = TRUE))
    wc <- walktrap.community(graph.glasso)
    n.dim <- max(wc$membership)

    if (plot.EGA == TRUE) {
        plot.ega <- qgraph(glasso.ebic, layout = "spring", vsize = 5, groups = as.factor(wc$membership))
    }

    a <- list()
    a$n.dim <- n.dim
    a$correlation <- cor.data
    a$glasso <- glasso.ebic
    a$wc <- wc$membership
    dim.variables <- data.frame(items = names(data), dimension = a$wc)
    dim.variables <- dim.variables[order(dim.variables[, 2]), ]
    a$dim.variables <- dim.variables
    class(a) <- c("EGA", "list")
    return(a)
}

print.EGA <- function(x, ...) {
    cat("EGA Results:\n")
    cat("\nNumber of Dimensions:\n")
    print(x$n.dim)
    cat("\nItems per Dimension:\n")
    print(x$dim.variables)
}

plot.EGA <- function(object, layout = "spring", vsize = 4, ...) {
    groups = as.factor(object$wc)
    variable = object$glasso
    qgraph(variable, layout = layout, vsize = vsize, groups = groups, ...)
}
