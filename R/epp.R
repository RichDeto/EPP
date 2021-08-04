#' \code{epp} package
#'
#' Evaluation of Proximity Programs
#'
#' See the README on
#' \href{https://github.com/RichDeto/EPP/blob/master/README.md}{Github}
#'
#' @docType package
#' @name epp
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1") utils::globalVariables(c(".hasSlot", "x", "y", "weight",
                                                        "medianx", "mediany", "p_dist",
                                                        "cubre", "dist", "median", "crds", 
                                                        "capacity", "pop", "id", "centers"))