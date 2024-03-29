# EPP <img align="right" src="man/figures/epp_logo_b.png" alt="logo" width="160"> <img align="right" src="man/figures/epp_logo.png" alt="logo" width="160">

<!-- badges: start -->
  [![CRAN status](https://www.r-pkg.org/badges/version/EPP)](https://CRAN.R-project.org/package=EPP)
  [![CRAN/METACRAN Total downloads](http://cranlogs.r-pkg.org/badges/grand-total/EPP?color=blue)](https://CRAN.R-project.org/package=EPP) 
  [![CRAN/METACRAN downloads per month](https://cranlogs.r-pkg.org/badges/EPP?color=blue)](https://CRAN.R-project.org/package=EPP)
  [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5138170.svg)](https://doi.org/10.5281/zenodo.5138170)
  [![R build status](https://github.com/RichDeto/EPP/workflows/R-CMD-check/badge.svg)](https://github.com/RichDeto/EPP/actions)
  [![codecov](https://codecov.io/gh/RichDeto/EPP/branch/master/graph/badge.svg)](https://app.codecov.io/gh/RichDeto/EPP)
  [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/RichDeto/EPP?branch=master&svg=true)](https://ci.appveyor.com/project/RichDeto/EPP)
<!-- badges: end -->

## Evaluation of Proximity Programs

**EPP** is a library oriented to the evaluation of population coverage of diverse programs. 
It was originally developed to assess the coverage of an initial education program in Uruguay, which gave us interesting results, and we wanted to share the methodology used, in a R package format. 
All contributions are welcome, even though we are still in the process of improvement.

## Installation

```R
# From CRAN

  install.packages("EPP")
  library(EPP)
```

```R
# Use the development version with latest features

  utils::remove.packages('EPP')
  devtools::install_github("RichDeto/EPP")
  library(EPP)
```

If you use **Linux**, you need to install a couple dependencies before installing the libraries `{sf}` and `{EPP}`. [More info here](https://github.com/r-spatial/sf#linux). 

## Basic Usage

### Main functions

A first task is to estimate the population covered with the existing infrastructure, and therefore we refer to the `eppexist()` function. An important detail to take into account is that our centers cannot overlap, since this prevents the correct computation of the Voronoi polygons. For this particular case, the `group_over()` function was implemented that combines the records for this specific application case.

Using the datasets `pop_epp` and `centers_epp` of the own library, this is it use. 

```R
centers_epp <- group_over(rbind(centers_epp, centers_epp[ 1:3,]))
exist <- eppexist(pop = pop_epp, centers = centers_epp, crs = sp::CRS("+init=epsg:32721"))
```

:warning: If you need to process a large number of cases with the parameter "route" = TRUE, it is recommended to install OSRM on a local server. For more information take a look [here](https://github.com/riatelab/osrm/issues/4) and [here](https://github.com/Project-OSRM/osrm-backend/issues/5463).

Normally the population is not completely covered by existing infrastructure, and that's when `eppproy()` appears, a function to find optimal locations to create new centers to cover the remaining population.  

Continuing with the example:

```R
proy <- eppproy(pop = exist$pop_uncover)
```

This was just an example using the default values of all the parameters. Please play around with them and report any bug [here](https://github.com/RichDeto/EPP/issues/new/choose).

### Report template

The library also has templates in English and Spanish to quickly produce report of the results of the processing.
In RStudio when you create a new RMarkdown document you can select the template like image show and start to personalize it. 

<img src="man/figures/template_epp.PNG" width="50%" style="display: block; margin: auto;" />

### Visualizations

For a quick visualization of the results of the `eppexist` or `eppproy` functions, the `leafepp` function was provided, which generates a `{leaflet}` viewer, with all the sublayers of the process. It also has a version in English and Spanish.

Continuing with the example:

```R
## In case of eppexist (In English)
l_epp_exist <- leafepp(exist, t = "exist", crs = sp::CRS("+init=epsg:32721"), leng = "en")
l_epp_exist
```

```R
## In case of eppproy (and in Spanish)
l_epp_proy <- leafepp(proy, t = "proy", crs = sp::CRS("+init=epsg:32721"), leng = "es")
l_epp_proy
```

### General functions

The syntax of all `{EPP}` functions are focused on executing two main processes, `eppexist()` and `eppproy()`, both aimed at evaluating the distribution of a certain population and the centers planned to cover it. Under the hood, there are some other tools that can be useful for other processes. Among them, we can mention those that allow making voronoi polygons (`voro_polygon()`), buffer-voronoi (`buff_voronoi()`) and iterative clusters (`clust_it()`).

## References

Detomasi, R. 2018. "Abordaje espacial de políticas públicas: cuidados y primera infancia”. En: [Las políticas públicas dirigidas a la infancia en Uruguay](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=2&cad=rja&uact=8&ved=2ahUKEwiu_uH64vHjAhXsJ7kGHRHOCo4QFjABegQIABAC&url=https%3A%2F%2Frepositorio.cepal.org%2Fbitstream%2Fhandle%2F11362%2F44155%2F1%2FS1800463_es.pdf&usg=AOvVaw3EPJkSZSWIDsQ-dpwcHuUO). Coords. Verónica Amarante  y Juan Pablo Labat. Ed. CEPAL - UNICEF, Santiago de Chile.

Detomasi, R., G. Mathieu y G. Botto 2018. ["EPP v.0.2: Evaluation of Proximity Programs with OSRM routing"](https://47jaiio.sadio.org.ar/sites/default/files/LatinR_10.pdf). LatinR - Conferencia Latinoamericana sobre Uso de R en Investigación + Desarrollo. 3 al 7 de Setiembre. 

Detomasi, R. y G. Botto. 2017. ["Evaluación espacial de servicios de educación inicial: la densificación de la oferta para tres años en la Administración Nacional de Educación Pública (ANEP)"](https://www.researchgate.net/publication/322149061_EVALUACION_ESPACIAL_DE_SERVICIOS_DE_EDUCACION_INICIAL_LA_DENSIFICACION_DE_LA_OFERTA_PARA_NINOS_DE_TRES_ANOS_EN_LA_ADMINISTRACION_NACIONAL_DE_EDUCACION_PUBLICA_ANEP). GeoFocus (ISSN 1578-5157).
<!-- https://www.geofocus.org/index.php/geofocus/article/view/508). -->

Botto, G. y Detomasi, R. 2015. ["Bases metodológicas para la planificación espacial de servicios de educación inicial en Uruguay"](https://dinem.mides.gub.uy/innovaportal/file/61794/1/tecnologias-de-la-informacion-para-nuevas-formas-de-gestion-del-territorio.-2015.pdf) Jornadas Argentinas de Geo-tecnologías: Trabajos completos. Universidad Nacional de Luján - Sociedad de Especialistas Latinoamericanos en Percepción Remota - Universidad Nacional de San Luis, pp. 121-128.

Detomasi, R., Botto, G. y Hahn, M. 2015. ["CAIF: Análisis de demanda"](https://dinem.mides.gub.uy/innovaportal/file/61792/1/caif.-analisis-de-demanda.-2015.pdf) Documento de trabajo, Mayo 2015. Departamento de Geografía. Dirección Nacional de Evaluación y Monitoreo. Ministerio de Desarrollo Social.  

R Development Core Team 2015. ["R: A language and environment for statistical computing"](https://www.R-project.org/) R Foundation for Statistical Computing, Vienna, Austria.ISBN 3-900051-07-0.
