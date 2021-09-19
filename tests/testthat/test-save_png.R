test_that("save_png has correct output", {
    expect_snapshot_file(
        save_png(
            plot_code = {
                plot(x = 1:5)
            },
            path = file.path(tempdir(), "test_plot_1.png"),
        ),
        "test_plot_1.png"
    )

    # works with pipe
    expect_snapshot_file(
        {
            plot(x = 1:5)
        } %>%
            save_png(
                path = file.path(tempdir(), "test_plot_2.png"),
                width = 5,
                height = 5,
                res = 300,
            ),
        "test_plot_2.png"
    )

    # works with ggplots
    expect_snapshot_file(
        save_png(
            plot_code = {
                test_ggplot <- dplyr::tibble(x = 1:5, y = 1:5) %>%
                    ggplot2::ggplot(ggplot2::aes(x, y)) +
                    ggplot2::geom_point()
                print(test_ggplot)
            },
            path = file.path(tempdir(), "test_plot_3.png"),
        ),
        "test_plot_3.png"
    )

    expect_true(file.exists(file.path(tempdir(), "test_plot_1.png")))
    expect_true(file.exists(file.path(tempdir(), "test_plot_2.png")))
    expect_true(file.exists(file.path(tempdir(), "test_plot_3.png")))
})
