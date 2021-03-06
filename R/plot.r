#' Plot objects in OpenGL
#' 
#' Plot using the \code{\link[rgl]{rgl-package}}. 
#'
#' The data structures from \code{\link{rangl}} are converted to their analogous forms
#' used by the \code{\link[rgl]{rgl}} package and plotted. These plot methods return
#' the rgl form invisibly. 
#' @param x object from \code{\link{rangl}}
#' @param ... args for underlying plotting
#' @param add add to existing plot if exists
#' @return the rgl mesh3d object, invisibly
#' @export
#' @importFrom rgl shade3d
#' @name plot-rangl
#' @aliases plot
plot.trimesh <- function(x,  ..., add = FALSE) {
  if (!"color_" %in% names(x$o)) {
    x$o$color_ <- trimesh_cols(nrow(x$o))
  }
  
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("rgl required")
  haveZ <- "z_" %in% names(x$v)
  tt <- th3d()
  
  if (haveZ) {
    tt$vb <- t(cbind(x$v$x_, x$v$y_, x$v$z_, 1))
  } else {
    
    tt$vb <- t(cbind(x$v$x_, x$v$y_, 0, 1))
  }
  vv <- x$v[, "vertex_"]; vv$row_n <- seq(nrow(vv))
  pindex <- dplyr::inner_join(dplyr::inner_join(x$o[, c("object_", "color_")], x$t), 
                              x$tXv)
  
  vindex <- dplyr::inner_join(x$tXv, vv, "vertex_")
  tt$it <- t(matrix(vindex$row_n, ncol = 3, byrow = TRUE))
  if (!add & length(rgl::rgl.dev.list()) < 1L) rgl::rgl.clear()
  rgl::shade3d(tt, col = pindex$color_, ...)
  
  if ( rgl::rgl.useNULL()) rgl::rglwidget()  
  invisible(tt)

}

#' @name plot-rangl
#' @export
plot.linemesh <- function(x,  ..., add = FALSE) {
  if (!"color_" %in% names(x$o)) {
    x$o$color_ <- trimesh_cols(nrow(x$o))
  }
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("rgl required")
  haveZ <- "z_" %in% names(x$v)
  #tt <- th3d()
  
  if (haveZ) {
    vb <- t(cbind(x$v$x_, x$v$y_, x$v$z_))
  } else {
    
    vb <- t(cbind(x$v$x_, x$v$y_, 0))
  }
  vv <- x$v[, "vertex_"]; vv$row_n <- seq(nrow(vv))
  pindex <- dplyr::inner_join(dplyr::inner_join(x$o[, c("object_", "color_")], x$l), 
                              x$lXv)
  
  vindex <- dplyr::inner_join(x$lXv, vv, "vertex_")
  itex <- t(matrix(vindex$row_n, ncol = 2, byrow = TRUE))
  if (!add & length(rgl::rgl.dev.list()) < 1L) rgl::rgl.clear()
  
  rgl::segments3d(t(vb)[itex,], col = pindex$color_, ...)
  
  if ( rgl::rgl.useNULL()) rgl::rglwidget() 
  
  invisible(list(v = vb, it = itex))

}

#' @name plot-rangl
#' @export
plot.pointmesh <- function(x,  ..., add = FALSE) {
  if (!"color_" %in% names(x$o)) {
    x$o$color_ <- viridis::viridis(nrow(x$o))
  }
  if (!requireNamespace("rgl", quietly = TRUE))
    stop("rgl required")
  haveZ <- "z_" %in% names(x$v)
  #tt <- th3d()
  
  if (haveZ) {
    vb <- t(cbind(x$v$x_, x$v$y_, x$v$z_))
  } else {
    
    vb <- t(cbind(x$v$x_, x$v$y_, 0))
  }
  vv <- x$v[, "vertex_"]; vv$row_n <- seq(nrow(vv))
  
  pindex <- dplyr::inner_join(dplyr::inner_join(x$o[, c("object_", "color_")], x$b), 
                              x$bXv)
  
  # vindex <- dplyr::inner_join(x$bXv, vv, "vertex_")
  #itex <- t(matrix(vindex$row_n, ncol = 2, byrow = TRUE))
  if (!add & length(rgl::rgl.dev.list()) < 1L) rgl::rgl.clear()
  
  rgl::rgl.points(t(vb), col = pindex$color_, ...)
  
  if ( rgl::rgl.useNULL()) rgl::rglwidget()
  invisible(list(v = vb, material = list(col = pindex$color_)))
}
