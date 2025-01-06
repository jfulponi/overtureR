#' Adapt Schema to GeoArrow-Compatible Format
#'
#' @param schema A `Schema` object from the Arrow package.
#' @return A modified `Schema` object with GeoArrow metadata.
geoarrow_schema_adapter <- function(schema) {
  geometry_field <- schema$metadata$geometry
  schema$metadata$geometry <- c(schema$metadata, "geoarrow.wkb" = "geoarrow.wkb")
  return(schema)
}
