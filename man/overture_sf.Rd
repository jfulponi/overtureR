% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dataset.R
\name{overture_sf}
\alias{overture_sf}
\title{Read Data into a `sf` Object}
\usage{
overture_sf(overture_type, bbox = NULL)
}
\arguments{
\item{overture_type}{A string indicating the type of Overture data.}

\item{bbox}{An optional bounding box (`st_bbox` or numeric vector
c(xmin, ymin, xmax, ymax)).}
}
\value{
An `sf` object containing the filtered spatial data.
}
\description{
Read Data into a `sf` Object
}
