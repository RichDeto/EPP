#' group_over
#'
#' @description grouping of id and capacity of centers who overlapping geometries
#' @param x A data.frame with unless four variables: x, y, id, capacity
#'
#' @return A data.frame without geographic duplcates, aggregating ids and capacity
#' @export
#' @importFrom dplyr mutate group_by ungroup filter select '%>%'
#' @examples
#' group_over(rbind(centers_epp, centers_epp[ 1:3,]))

group_over <- function(x) {
        x %>% 
                mutate(crds = paste(x, y)) %>% 
                group_by(crds) %>%                       
                mutate(capacity = sum(capacity),
                       id = paste(id, collapse = "_")) %>% 
                ungroup() %>% 
                filter(!duplicated(crds)) %>% 
                select(-crds)
}        
