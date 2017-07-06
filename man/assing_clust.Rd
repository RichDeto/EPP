\name{assing_clust}
\alias{assing_clust}
\encode{UTF-8}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Function to assign population to centers of services
}
\description{
Function to process the results from EPP::clust_it
}
\usage{
assing_clust(clustered)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
         \item{clustered}{
                List of the population assigned to each centre by EPP::clust_it
	}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
Return a LIST with:
 \item{centres_clusters}{Centres of the clusters with the number of individuals covered for each service distance and mean distances}
 \item{assigned_clusters}{Population with the center assigned to}
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
assing_clust(clustered)
{
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }% use one of  RShowDoc("KEYWORDS")
\keyword{ cluster }
