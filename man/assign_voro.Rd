\name{assing_voro}
\alias{assing_voro}
\encode{UTF-8}
\title{
Function to assign population to centers of services by Voronois
}
\description{
Function to process the results from EPP::assignation_exist
}
\usage{
assing_voro(pop, centers, crs)
}
\arguments{
         \item{pop}{
                DataFrame of the population, with x and y as first two variables, to assign to each centre by Voronois Polygons. (x and y are plain coordinates in the defined CRS)                
	}
           \item{centers}{
                DataFrame of the centers, with x and y as first two variables, to assign the population by Voronois Polygons. (x and y are plain coordinates in the defined CRS)
	}
           \item{crs}{
                Coordinate Reference Systems (CRS). Default = CRS("+init=epsg:32721")
	}
}
\details{

}
\value{Return a DataFrame with the variables of the pop DataFrame and all the variables of the center who corresponds by its Voronois Polygons
}
\references{
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf

Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 

R Development Core Team (2015), R: A language and environment for statistical computing. R Foundation forStatistical Computing, Vienna, Austria.ISBN 3-900051-07-0, URL http://www.R-project.org/
}
\author{Detomasi, Richard &
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
assing_voro(pop, centers, crs = CRS("+init=epsg:32721"))
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ cluster }
