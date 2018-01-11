\name{osrm_matrixby100}
\alias{osrm_matrixby100}
\encode{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Generate a distance matrix for dataframes of more than 100 rows, using osrm functions by nrow(dataframe)/100 of rows, avoiding the record limit of the original osrm function
}
\description{
Generate a distance matrix for dataframes of more than 100 rows, using osrm functions by nrow(dataframe)/100 of rows. Its use the osrmRoute and osrmTable functions of osrm library, that build and send an OSRM API query to get the travel geometry between two points. 
This function interfaces the route OSRM service. The principal contribution to this function it´s to consider avoiding the record limit of the original osrm function.  }
\usage{
osrm_matrixby100(df)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
         \item{df}{
                Dataframe with three variables: id, lat and long. lat and long are plain coordinates in the CRS("+init=epsg:4326"))
        }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Return a DataFrame with:
 \item{matriz}{The distance matrix of all the rows of tha dataframe}
%% ...
}
\references{
Timothée Giraud [cre, aut], Robin Cura [ctb], Matthieu Viry [ctb] 2017 osrm: Interface Between R and the OpenStreetMap-Based Routing Service OSRM. https://CRAN.R-project.org/package=osrm
}
\author{
Detomasi, Richard
}
\note{
%%  ~~further notes~~
}
%% ~Make other sections like Warning with \section{Warning }{....} ~
\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
## The function is currently defined as
osrm_matrixby100(df)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ matrix }
\keyword{ osrm }
