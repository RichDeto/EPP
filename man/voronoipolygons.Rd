\name{voronoipolygons}
\alias{voronoi}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to generate Voronoi polygons.
}
\description{
Generate Voroni Polygons, according to a distance/s of radium. The output of the function is a List with the SpatialPolygonDataFrame with the id of the initial DataFrame
}
\usage{
voronoipolygons <- function(x, crs)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
        \item{x}{
                DataFrame with unless three variables: x, y, and id)
        }
        \item{[crs]}{
                Coordinate Reference Systems (CRS).
        }
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Return a SpatialPolygon of the Voronoi polygons of the initial DataFrame
}
\references{
Bivand, R., Keitt, T., Rowlingson, B., Pebesma, E., Sumner, M., Hijmans, R. y Rouault, E. (2015), Bindings for the Geospatial Data Abstraction Library. URL https://cran.r-project.org/web/packages/rgdal/rgdal.pdf
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
Farmer, Carson (2009) "http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/"
Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
Leisch, F. y Dimitriadou, E. (2013), Flexible ClusterAlgorithms. URL https://cran.r-project.org/web/packages/flexclust/flexclust.pdf
Pebesma, E., Bivand, R., Rowlingson, B., Gomez-Rubio, V., Hijmans, R., Sumner, M., MacQueen, D. et al. (2015), Classes and Methods for Spatial Data. URL https://cran.r-project.org/web/packages/sp/sp.pdf
R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
Turner, R. (2015), Delaunay Triangulation and Dirichlet (Voronoi) Tessellation. URL https://cran.r-project.org/web/packages/deldir/deldir.pdf
}
\author{Detomasi, Richard 
        Botto, German 
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
centers<- data.frame(x = sample(560000:585000,10),
                             y = sample(6136000:6160000,10),
                             id = 1:10)

## The function is currently defined as
voronoi_polygons(centers, crs = CRS("+init=epsg:32721")) 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ Voronoi Polygons }
