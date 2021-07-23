#' \code{epp} package
#'
#' Evaluation of Proximity Programs
#'
#' See the README on
#' \href{https://gitlab.mides.gub.uy/rdetomasi/epp/blob/master/README.md}{Gitlab}
#'
#' @docType package
#' @name epp
pop <- NULL
centers <- NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if (getRversion() >= "2.15.1") utils::globalVariables(c(".hasSlot", "x", "y", "weight",
                                                        "medianx", "mediany", "p_dist",
                                                        "cubre", "dist", "median", "crds", 
                                                        "capacity", "pop", "id", "centers"))