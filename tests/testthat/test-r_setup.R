context("testing r_setup functions")

test_config_path <- file.path(tempdir(), "test_config.txt")

test_setup_files <- function(test_config_path, setup_func, template) {
    setup_func(path = test_config_path, append = FALSE)

    test_config <- readr::read_lines(test_config_path)

    template <- system.file("extdata", paste0(template),
        package = "rutils",
        mustWork = TRUE
    )
    template_config <- readr::read_lines(test_config_path)

    config_template_match <- identical(test_config, template_config)

    return(config_template_match)
}

test_that("setup_Rprofile has correct output", {
    expect_true(test_setup_files(
        test_config_path = test_config_path,
        setup_func = setup_Rprofile,
        template = "template_Rprofile"
    ))

    expect_true(test_setup_files(
        test_config_path = test_config_path,
        setup_func = setup_Rprofile,
        template = "template_Rprofile"
    ))

    expect_true(test_setup_files(
        test_config_path = test_config_path,
        setup_func = setup_Rprofile,
        template = "template_Rprofile"
    ))
})
