\name{eppxist}
\alias{eppxist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Evaluation of proximity coverage by a program and estimate new services to attend the uncover population.}
\description{
        Assigns the elements from pob to the centers by n iterations, according to the capacity and distance/s of radium of each center. The output contains four DataFrames:that list the capacity of each center that remains unused (unused_capacity); the uncovered population (pop_uncovered); the population assigned to the existent centers (pop_assigned); and the center's used capacity (centers_covered). The assignation of points to centers is based in proximity and and optimality criteria (maximum distance and center's capacity). Two radiums for the centers may be used. The Voronoi polygons creation is modified from Farmer - see REFERENCES.
}
\usage{eppxist(pob, centers, n, a, [m = n + 1, b = a * 2, crs = CRS("+init=epsg:32721")])}
%- maybe also 'usage' for other objects documented here.
\arguments{
        \item{pob}{
                Population to attend (dataframe with three variables: x, y, and weight). Each element represents the position and identity of a population's member. x and y represents plain coordinates in the selected Coordinate Reference System. 
        }
        \item{centers}{
                Existing centers of the program (dataframe with four variables: x, y, id, capacity). Each element represents the position, identity and capacity of a center. x and y represents plain coordinates in the selected Coordinate Reference System.
        }
        \item{n}{
                Total number of iterations
        }
        \item{a}{
                Radius in meters that each center covers in the firsts m-1 iterations
        }
        \item{[m]}{
                Number of iteration in wich change the distance of radium. If m>n only the first distance is usede. Default = n + 1 
        }
        \item{[b]}{
                Radius in meters that each center covers, starting at the m iteration. Default = a * 2
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
       \item{unused_capacity }{DataFrame with the centers and its unused capacity}
       \item{pop_uncovered }{DataFrame with the population still out of coverage}
       \item{pop_assigned }{DataFrame with the population assigned and the corresponding center}
       \item{centers_covered }{DataFrame with the centers and the info of population covered}
}
\references{
        Bivand, R., Keitt, T., Rowlingson, B., Pebesma, E., Sumner, M., Hijmans, R. y Rouault, E. (2015), Bindings for the Geospatial Data Abstraction Library. URL https://cran.r-project.org/web/packages/rgdal/rgdal.pdf
        Botto, G. y Detomasi, R. (2015), Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay. Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.http://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf
        Detomasi, R., Botto, G. y Hahn, M. (2015) CAIF: Análisis de demanda. Do-cumento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social. http://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf 
        Farmer, carson (2009) Voronoi polygons with R. URL http://carsonfarmer.com/2009/09/voronoi-polygons-with-r/ 
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
\keyword{ spatial }
\keyword{ Voronoi polygons}
\keyword{ Buffers}        

