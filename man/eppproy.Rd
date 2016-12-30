\name{eppproy}
\alias{eppproy}
\encode{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to generate centers by proximity and coverage of a program using clusters.
}
\description{
Assign the population in a number of iterations, according to the distance/s of radium and capacity´s of a program projected centers. The output of the function is a List with the SpatialPointsDataFrame of cover population with its filiation, and other SpatialPointsDataFrame of centers with a summary of cover population.
}
\usage{
eppproy(pob, m = 5, l = 4, o = 3, g1 = 50, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2, crs = c('CRS("+init=epsg:32721")'))
}
%- maybe also 'usage' for other objects documented here.
\arguments{
         \item{pob}{
                Population to attend (dataframe with three variables: x, y, and weight)
        }
        \item{m}{
                Total number of iterations. Default = 5
        }
        \item{l}{
                Iteration in which the value of the distance changes. Default = 4
        }
        \item{o}{
                Iteration in which the value of the capacity changes. Default = 3
        }
        \item{[g1]}{
                Firsts iterations capacity for the groups. Default = 50
        }
        \item{[g2]}{
                Rest of iterations capacity for the groups. Default = g1 * 0.5
        }
        \item{d1}{
                Firsts iterations distance of radium in meters (n > m). Default = 1000
        }
        \item{[d2]}{
                Rest of iterations distance of radium in meters (n <= m). Default = d1 * 2
        }
        \item{[crs]}{
                Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721")
        }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Return a LIST with:
 \item{new_centers }{Centers to cover the population}
 \item{new_assign }{Population with the center assigned}
 %% ...
}
\references{
Bivand, R., Keitt, T., Rowlingson, B., Pebesma, E., Sumner, M., Hijmans, R. y Rouault, E. (2015), Bindings for the Geospatial Data Abstraction Library. URL https://cran.r-project.org/web/packages/rgdal/rgdal.pdf
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
Farmer, Carson (2009) "http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/"
Leisch, F. y Dimitriadou, E. (2013), Flexible ClusterAlgorithms. URL https://cran.r-project.org/web/packages/flexclust/flexclust.pdf
Pebesma, E., Bivand, R., Rowlingson, B., Gomez-Rubio, V., Hijmans, R., Sumner, M., MacQueen, D. et al. (2015), Classes and Methods for Spatial Data. URL https://cran.r-project.org/web/packages/sp/sp.pdf
R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
Turner, R. (2015), Delaunay Triangulation and Dirichlet (Voronoi) Tessellation. URL https://cran.r-project.org/web/packages/deldir/deldir.pdf
}
\author{Detomasi, Richard
        Botto, German 
        Mathieu, Gabriela
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.

## The function is currently defined as
function (x) 
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ cluster }
