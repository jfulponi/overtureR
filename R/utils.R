#' Retrieve Record Batch Reader
#'
#' @param overture_type A string indicating the type of Overture data.
#' @param bbox An optional bounding box (`st_bbox` or numeric vector
#'   c(xmin, ymin, xmax, ymax)).
#' @return A `RecordBatchReader` object for the filtered data.
record_batch_reader <- function(overture_type, bbox = NULL) {
  path <- get_dataset_path(overture_type)

  # Adjust filter for bbox (supports st_bbox directly)
  filter <- NULL
  if (!is.null(bbox)) {
    if (inherits(bbox, "bbox")) {
      bbox <- as.numeric(bbox) # Convert to xmin, ymin, xmax, ymax
    }
    xmin <- bbox[1]
    ymin <- bbox[2]
    xmax <- bbox[3]
    ymax <- bbox[4]

  }

  # Create dataset
  dataset <- arrow::open_dataset(source = arrow::s3_bucket(path, anonymous = TRUE),
                                 format = "parquet", filesystem = "s3")

  scan_builder <- dataset$NewScan()

  scan_builder$Filter(
        arrow::Expression$field_ref("bbox")$xmin < xmax &
        arrow::Expression$field_ref("bbox")$xmax > xmin &
        arrow::Expression$field_ref("bbox")$ymin < ymax &
        arrow::Expression$field_ref("bbox")$ymax > ymin
    )

  scanner <- scan_builder$Finish()

  reader <- scanner$ToRecordBatchReader()

  return(reader)
}

# Mapping of types to themes
type_theme_map <- list(
  address = "addresses",
  bathymetry = "base",
  building = "buildings",
  building_part = "buildings",
  division = "divisions",
  division_area = "divisions",
  division_boundary = "divisions",
  place = "places",
  segment = "transportation",
  connector = "transportation",
  infrastructure = "base",
  land = "base",
  land_cover = "base",
  land_use = "base",
  water = "base"
)
