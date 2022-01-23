# log history of EPP package development

-------------------------------------------------------

## EPP v0.3.6 (2022-01-23)

  * Add methods::is function in assign_nn function to stop failling in Fedora

## EPP v0.3.5 (2021-12-10)

  * Delete 'as.vector()' in three functions to stop failling in latest  R-devel

## EPP v0.3.4 (2021-11-04)

  * added a osrm_ok function to fail gratefully if osrm server is down
  * fixed 'F' abreviation in eppexist
  * added a return to osrm_ok
  * replace '\dontrun{}' with '\donttest{}' in osrm functions.

## EPP v0.3.3 (2021-09-22) 

  * leafepp debuged in t = "exist" about center$capacity popup
  * debuged assign_clust line 15
  * categorization of centers by coverage in leafepp(t = "proy")
  * added assign_nn() function
  * added addSearchOSM() in leafepp
  * added labels_es dataset to translate leafepp maps 
  * adaptation to osrm update
  * added site by pkgdown
  * added assertthat to check internet availability
  * debuged typo in assign_clust of p_weight

## EPP v0.3.2 (2021-08-03)

Launch of **EPP** v0.3.2 on [GitHUb](https://github.com/RichDeto/EPP) with the following functions:  
  * `assign_clust()`    
  * `assign_voro()`    
  * `assignation_exist()`
  * `buff_voronoi()`
  * `byosrmRoute()`
  * `clust_it()`
  * `clust_pop()`
  * `eppexist()`
  * `eppproy()`
  * `group_over()`
  * `leafepp()`
  * `osrm_matrixby100()`
  * `voro_polygon()`
  
  
And the following data sets:    
  * centers_epp    
  * pop_epp    
