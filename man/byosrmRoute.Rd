\name{byosrmRoute}
\alias{byosrmRoute}
\encode{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Add the Shortest Path Between Two Points
}
\description{
This function add de distance and duration of the Shortest Path Between Two Points. Its use the osrmRoute function of osrm library, that build and send an OSRM API query to get the travel geometry between two points. 
This function interfaces the route OSRM service. The principal contribution to this function it´s yo consider the CRS of the input coordinates, and only output the distance and time variables of the procedure.  }
\usage{
byosrmRoute(src_dst, crs)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
         \item{src_dst}{
                Dataframe with four variables: x of source, y of source, x of destination, y of destination. x and y are plain coordinates in the defined CRS
        }
        \item{crs}{
                Coordinate Reference Systems (CRS).
        }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Return a DataFrame with:
 \item{src_dst}{The input DataFrame with 2 new variables "distance" in Kms and "duration" in minutes}
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
byosrmRoute(src_dst, crs)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ route }
