% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/group_over.R
\name{group_over}
\alias{group_over}
\title{group_over}
\usage{
group_over(x)
}
\arguments{
\item{x}{A data.frame with unless four variables: x, y, id, capacity}
}
\value{
A data.frame without geographic duplicates, aggregating ids and capacity
}
\description{
grouping of id and capacity of centers who overlapping geometries
}
\examples{
group_over(rbind(centers_epp, centers_epp[ 1:3,]))
}
