# tests/testthat/test_plots.R

library(testthat)
library(ggplot2)

# Source the student's solution file.
test_that("solution.R can be sourced", {
  expect_silent(source("solution.R"))
})

test_that("plot objects exist", {
  expect_true(exists("plot1"), info = "plot1 is missing")
  expect_true(exists("plot2"), info = "plot2 is missing")
  expect_true(exists("plot3"), info = "plot3 is missing")
  expect_true(exists("plot4"), info = "plot4 is missing")
})

test_that("plot1: geom_point + geom_smooth without se", {
  p <- get("plot1")

  # Check geoms
  geoms <- vapply(p$layers, function(l) class(l$geom)[1], character(1))
  expect_true("GeomPoint" %in% geoms, info = "plot1 must contain geom_point")
  expect_true("GeomSmooth" %in% geoms, info = "plot1 must contain geom_smooth")

  # Check main aesthetics
  aes_all <- p$mapping
  expect_identical(as.character(aes_all$x), "displ")
  expect_identical(as.character(aes_all$y), "hwy")

  # Check se = FALSE for smooth
  smooth_layers <- p$layers[vapply(p$layers, function(l) class(l$geom)[1] == "GeomSmooth", logical(1))]
  expect_true(length(smooth_layers) >= 1, info = "plot1 must contain at least one geom_smooth layer")
  for (layer in smooth_layers) {
    expect_false(layer$stat_params$se %||% layer$geom_params$se %||% TRUE,
                 info = "geom_smooth in plot1 must use se = FALSE")
  }
})

test_that("plot2: geom_smooth grouped by drv", {
  p <- get("plot2")

  geoms <- vapply(p$layers, function(l) class(l$geom)[1], character(1))
  expect_true("GeomPoint" %in% geoms, info = "plot2 must contain geom_point")
  expect_true("GeomSmooth" %in% geoms, info = "plot2 must contain geom_smooth")

  smooth_layers <- p$layers[vapply(p$layers, function(l) class(l$geom)[1] == "GeomSmooth", logical(1))]
  expect_true(length(smooth_layers) >= 1, info = "plot2 must contain at least one geom_smooth layer")

  # Check group aesthetic uses drv
  found_drv_group <- any(vapply(smooth_layers, function(l) {
    !is.null(l$mapping$group) && as.character(l$mapping$group) == "drv"
  }, logical(1)))
  expect_true(found_drv_group, info = "geom_smooth in plot2 must use aes(group = drv)")
})

test_that("plot3: color mapped to drv in global aes", {
  p <- get("plot3")

  geoms <- vapply(p$layers, function(l) class(l$geom)[1], character(1))
  expect_true("GeomPoint" %in% geoms, info = "plot3 must contain geom_point")
  expect_true("GeomSmooth" %in% geoms, info = "plot3 must contain geom_smooth")

  # Global mapping should have color = drv
  aes_all <- p$mapping
  expect_identical(as.character(aes_all$x), "displ")
  expect_identical(as.character(aes_all$y), "hwy")
  expect_identical(as.character(aes_all$colour), "drv")
})

test_that("plot4: color mapped to drv only in points", {
  p <- get("plot4")

  geoms <- vapply(p$layers, function(l) class(l$geom)[1], character(1))
  expect_true("GeomPoint" %in% geoms, info = "plot4 must contain geom_point")
  expect_true("GeomSmooth" %in% geoms, info = "plot4 must contain geom_smooth")

  # Global mapping: only x and y
  aes_all <- p$mapping
  expect_identical(as.character(aes_all$x), "displ")
  expect_identical(as.character(aes_all$y), "hwy")
  expect_null(aes_all$colour)

  # Point layer should map color = drv
  point_layers <- p$layers[vapply(p$layers, function(l) class(l$geom)[1] == "GeomPoint", logical(1))]
  expect_true(length(point_layers) >= 1, info = "plot4 must contain at least one geom_point layer")

  has_color_drv <- any(vapply(point_layers, function(l) {
    !is.null(l$mapping$colour) && as.character(l$mapping$colour) == "drv"
  }, logical(1)))
  expect_true(has_color_drv, info = "geom_point in plot4 must use aes(color = drv)")
})