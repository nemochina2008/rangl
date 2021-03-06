% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/globe.r
\name{globe}
\alias{globe}
\alias{globe.default}
\title{Convert map coordinates to Geocentric (XYZ) coordinates.}
\usage{
globe(x, ...)

\method{globe}{default}(x, gproj = "+proj=geocent +ellps=WGS84", ...)
}
\arguments{
\item{x}{list of tibbles, in \code{\link{rangl}} form}

\item{...}{arguments to methods (none used)}

\item{gproj}{Geocentric PROJ.4 string, defaults to WGS84}
}
\value{
rangl object with vertices table modified
}
\description{
Convert map coordinates to Geocentric (XYZ) coordinates.
}
\examples{
library(maptools)
data(wrld_simpl)
g <- globe(rangl(as(wrld_simpl, "SpatialLinesDataFrame")))
if (interactive()) {
 plot(g, lwd = 3)
 }
}
