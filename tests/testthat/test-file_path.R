test_that("file_path has correct output", {
  expect_equal(
    file_path("/", check_exists = FALSE),
    "/"
  )
  expect_equal(
    file_path("~", check_exists = FALSE),
    "~"
  )
  expect_message(file_path("/"), "exists")
  expect_message(file_path("/non/existant/path"), "does not exist")
  expect_error(file_path("/non/existant/path", force_exists = TRUE))
})
