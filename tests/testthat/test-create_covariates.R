test_that("create_covariates fails with invalid input", {
  skip_if_no_saga()

  outdir <- withr::local_tempdir()
  aoi_snapped <- make_test_aoi(outdir)
  aoi_rast <- create_template_raster(aoi_snapped, res = 50, out_dir = outdir)

  expect_error(create_covariates(dtm = 1, layers = "all", out_dir = outdir))
  expect_error(create_covariates(dtm =  aoi_rast , saga_path = NULL, layers = "all", out_dir = outdir))
  expect_error(create_covariates(dtm =  aoi_rast, layers = "madeupcovar", out_dir = outdir))

})

test_that("create_covariates() works", {
  skip_if_no_saga()
  
  outdir <- withr::local_tempdir()
  aoi_snapped <- make_test_aoi(outdir)
  aoi_rast <- create_template_raster(aoi_snapped, res = 50, write_output = FALSE)
  dem <- get_cded_dem(aoi_rast, write_output = FALSE, ask = FALSE)
  
  create_covariates(dtm = dem, layers = "flowaccumulation", out_dir = outdir)
  expect_snapshot(list.files(outdir, recursive = TRUE))
})

test_that("create_landscape_covariates fails with invalid input", {
  skip_if_no_saga()

  outdir <- withr::local_tempdir()
  aoi_snapped <- make_test_aoi(outdir)
  aoi_rast <- create_template_raster(aoi_snapped, res = 50, out_dir = outdir)

  expect_error(create_landscape_covariates(dtm = 1, out_dir = outdir))
  expect_error(create_landscape_covariates(dtm =  aoi_rast , saga_path = NULL, out_dir = outdir))
  expect_error(create_landscape_covariates(dtm =  aoi_rast, layers = "madeupcovar", out_dir = outdir))
})

test_that("create_landscape_covariates() works", {
  skip_if_no_saga()

  outdir <- withr::local_tempdir()
  aoi_snapped <- make_test_aoi(outdir)
  aoi_rast <- create_template_raster(aoi_snapped, res = 50, write_output = FALSE)
  dem <- get_cded_dem(aoi_rast, write_output = FALSE, ask = FALSE)

  create_landscape_covariates(dem, out_dir = outdir)
  expect_snapshot(list.files(outdir, recursive = TRUE))
})
