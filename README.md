
[![Travis-CI Build Status](https://travis-ci.org/hypertidy/rangl.svg?branch=master)](https://travis-ci.org/hypertidy/rangl) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/hypertidy/rangl?branch=master&svg=true)](https://ci.appveyor.com/project/hypertidy/rangl) [![Coverage Status](https://img.shields.io/codecov/c/github/hypertidy/rangl/master.svg)](https://codecov.io/github/hypertidy/rangl?branch=master)

<!-- README.md is generated from README.Rmd. Please edit that file -->
    ## Warning in rgl.init(initValue, onlyNULL): RGL: unable to open X11 display

    ## Warning: 'rgl_init' failed, running with rgl.useNULL = TRUE

Tabular storage for spatial data
--------------------------------

The 'rangl' package illustrates some generalizations of GIS-y tasks in R with "tables".

The basic idea is to create "toplogical" objects from a variety of sources:

-   SpatialPolygons, SpatialLines, SpatialMultipoints
-   rgl 3D objects
-   trip objects (animal tracking data)
-   --others to come-- see <https://github.com/mdsumner/spbabel>

Multiple multi-part objects are decomposed to a set of related, linked tables. Object identity is maintained with attribute metadata and this is carried through to colour and other aesthetics in 3D plots.

Plot methods take those tables and generate the "indexed array" structures needed for 'rgl'. In this way we get the best of both worlds of "GIS" and "3D models".

Ongoing design
--------------

The core work for translating "Spatial" classes is done by the unspecialized 'spbabel::map\_table' function.

This is likely to be replaced by a 'primitives()' function that takes any lines or polygons data and returns just the linked edges. Crucially, polygons and lines are described by the same 1D primitives, and this is easy to do. Harder is to generate 2D primitives and for that we rely on [Jonathan Richard Shewchuk's Triangle](https://www.cs.cmu.edu/~quake/triangle.html).

Triangulation is with `RTriangle` package using "constrained mostly-Delaunay Triangulation" from the Triangle library, but could alternatively use `rgl` with its ear clipping algorithm.

(With RTriangle we can set a max area for the triangles, so it can wrap around curves like globes and hills.)

Installation
------------

This package is in active development and will see a number of breaking changes before release.

Also required are packages 'rgl' and 'RTriangle', so first make sure you can install and use these.

``` r
install.packages("rgl")
install.packages("RTriangle")
```

In examples below I use 'graticule' as well, so you might as well install that too.

``` r
install.packages("graticule")
```

If you are still feeling adventurous, 'rangl' can be installed from Github. This will also ensure that the latest version of 'spbabel' is installed, until I get around to updating that on CRAN.

``` r
devtools::install_github("hypertidy/rangl")
```

Get involved!
-------------

Let me know if you have problems, or are interested in this work. See the issues tab to make suggestions or report bugs.

<https://github.com/hypertidy/rangl/issues>

Examples
--------

See the vignettes: <https://hypertidy.github.io/rangl/articles/index.html>

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
