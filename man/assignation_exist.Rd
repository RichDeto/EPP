\name{assignation_exist}
\alias{assignation_exist}
\encode{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to assign population to centers of services
}
\description{
Function to assign population to centers of services, based in proximity, maximum radius and nominal capactiy of the centers. The capacity and maximum radius are defined a priori based on policies' objectives
}
\usage{
assignation_exist(pop, centers, d, crs, route = F)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
         \item{pop}{
                Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS
        }
        \item{centers}{
                Centers of services (dataframe with four variables: x, y, id, and capacity) x and y are plain coordinates in the defined CRS
        }
        \item{d}{
                Maximum distance at wich the center may provide service in meters
        }
        \item{crs}{
                Coordinate Reference Systems (CRS).
        }
         \item{[route]}{
                If FALSE the distance is calculated by pithagorean formula, if TRUE the distance is calculated by "osrmRoute" function of "osrm" Package.
                Default = FALSE
        }
}
\details{
The TRUE option in the route parameter, have a dialy limit of calculation per OSM API, be careful.
}
\value{
Return a LIST with:
 \item{new_centers }{Centers to cover the population}
 \item{new_assign }{Population with the center assigned}
 %% ...
}
\references{
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Documento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
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
                     id = 1:10,
                     capacity = sample(5:10,10,replace = T))
pop <- data.frame(x = sample(560000:585000,500),
                  y = sample(6136000:6160000,500),
                  weight = runif(500, min=0, max=1))

## The function is currently defined as
assignation_exist(pop, centers, d = 1000, crs = CRS("+init=epsg:32721"), route = FALSE)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ cluster }
