\name{eppexist}
\alias{eppexist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Evaluation of proximity coverage by a program and estimate new services to attend the uncover population.}
\description{
        Assigns the elements from pob to the centers by n+m iterations, according to the capacity and distance/s of radium of each center. The output is a list that contains four data.frames: pop have the unassigned population, centers has the centers that still have capacity available, used_capacity have the center's occupped capacity and assigned has the population assigned to the centers. The assignation of points to centers is based in proximity and and optimality criteria (maximum distance and center's capacity). 
}
\usage{eppxist(pob, centers, n = 3, m = 0, d1 = 1000, d2 = a * 2, crs = CRS("+init=epsg:32721")])}
%- maybe also 'usage' for other objects documented here.
\arguments{
        \item{pob}{
                Population to attend (dataframe with three variables: x, y, and weight). Each element represents the position and identity of a population's member. x and y represents plain coordinates in the selected Coordinate Reference System. 
        }
        \item{centers}{
                Existing centers of the program (dataframe with four variables: x, y, id, capacity). Each element represents the position, identity and capacity of a center. x and y represents plain coordinates in the selected Coordinate Reference System.
        }
        \item{n}{
                Total number of iterations with the distance "d1". Default n = 3
        }
        \item{[m]}{
                Number of iteration in wich change the distance of radium. If m>n only the first distance is usede. Default m = 0 
        }
        \item{d1}{
                Radius in meters that each center covers in the firsts "n" iterations. Default d1 = 1000
        }
        \item{[d2]}{
                Radius in meters that each center covers, the last "m" iterations. Default = d1 * 2
        }
        \item{[crs]}{
                Coordinate Reference Systems (CRS).
        }
}

\details{
        %%  ~~ If necessary, more details than the description above ~~
}
\value{
     Return a LIST with:
       \item{pop_uncover }{DataFrame of the population still out of coverage; with its "x", "y" and "weigth".}
       \item{pop_assigned }{DataFrame with the population assigned and the corresponding center; with its "x", "y","weigth", "id" of the centerand the "iteration" of assing.}
       \item{remaining_capacity }{DataFrame of the centers and its unused capacity; with "x" and "y" of the center, the "id", and the unused "capacity".}       
       \item{used_capacity }{List of DataFrames with the centers and the info of population covered in each itaration. Each DataFrames have the name of the iteration, and contains the "id", "x" and "y" of the center; and the remaining "capacity" and "used_cap" after the iteration.}
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
        centers<- data.frame(x = sample(560000:585000,10),
                             y = sample(6136000:6160000,10),
                             id = 1:10,
                             capacity = sample(5:10,10,replace = T))

        pop <- data.frame(x = sample(560000:585000,500),
                          y = sample(6136000:6160000,500),
                          weight = runif(500, min=0, max=1))
           
        ## The function is currently defined as
        eppexist (pop, centers, crs = CRS("+init=epsg:32721"))
        {
        }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ spatial }
\keyword{ Voronoi polygons}
\keyword{ Buffers}        

