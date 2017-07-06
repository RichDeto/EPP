\name{clust_it}
\alias{clust_it}
\encode{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function for iterative clusterization
}
\description{
The function clusterizes population to create service's centers. Iterates EPP::clust_pop for the remaining population in each step. It allows to define two distances of service and two group sizes for several rounds of iteration.  
}
\usage{
clust_it(pop, m = 5, l = 4, o = 3, g1 = 50, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
         \item{pop}{
                Population to attend (dataframe with three variables: x, y, and weight). x and y are plain coordinates in the defined CRS
        }
        \item{m}{
                Number of iteration rounds
        }
        \item{l}{
                Number of iteration rounds with the first group size (g1) 
        }
        \item{o}{
                
        }
	\item{g1}{
                Size of the groups for the first l iterations
        }
	\item{g2}{
                Size of the groups for the last m-l iterations
        }
	\item{d1}{
                Distance range of service for the first iterations
        }
	\item{d2}{
                Second distance range of service 
        }

}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Return a LIST with:
 \item{Clustered}{Population assigned to created centers by clusterization}
 \item{pop}{Remaining non-assigned population}
 %% ...
}
\references{
Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
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

## The function is currently defined as
clust_it(pop, m = 5, l = 4, o = 3, g1 = 50, g2 = g1 * 0.5, d1 = 1000, d2 = d1 * 2)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ cluster }
