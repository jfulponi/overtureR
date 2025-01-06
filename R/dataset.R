#' Retrieve Dataset Path for Overture Data
#'
#' @param overture_type A string indicating the type of Overture data.
#' @return A string representing the S3 path for the specified dataset.
#' @export
get_dataset_path <- function(overture_type) {
  theme <- type_theme_map[[overture_type]]
  if (is.null(theme)) {
    stop("Invalid overture_type provided.")
  }
  paste0("overturemaps-us-west-2/release/2024-12-18.0/theme=", theme,
         "/type=", overture_type, "/")
}

#' Read Data into a `sf` Object
#'
#' @param overture_type A string indicating the type of Overture data.
#' @param bbox An optional bounding box (`st_bbox` or numeric vector
#'   c(xmin, ymin, xmax, ymax)).
#' @return An `sf` object containing the filtered spatial data.
#' @export
overture_sf <- function(overture_type, bbox = NULL) {
  reader <- record_batch_reader(overture_type, bbox)
  if (is.null(reader)) {
    stop("No data found for the specified bbox or overture_type.")
  }
  data <- reader$read_table()
  data <- as.data.frame(data)
  sf_data <- sf::st_as_sf(data, crs = 4326)
  return(sf_data)
}

#' List All Available Overture Types
#'
#' @return A character vector with all available types.
#' @export
get_all_overture_types <- function() {
  return(names(type_theme_map))
}
