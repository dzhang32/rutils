#' Save a plot as a .png
#'
#' A wrapper for calling `grDevices::png()` then `grDevices::dev.off()`. Allows
#' users to save a plot to a specified path. The preferred method for
#' `ggplot2::ggplot` objects remains `ggplot::ggsave()`. However if you wish to
#' use this function to save `ggplot2::ggplot` objects, print the plot as the
#' last step of `plot_code`.
#'
#' @inheritParams grDevices::png
#' @param plot_code code required to generate the plot, sandwiched in curly
#'   braces.
#' @param path `character(1)` specifying path for where to save your plot,
#'   including file name.
#' @param ... additional arguments are passed to `grDevices::png()`.
#'
#' @return Invisibly, the path to saved plot.
#' @export
#'
#' @examples
#'
#' save_png(
#'   {
#'     plot(x = 1:5)
#'   },
#'   path = file.path(tempdir(), "test_plot.png"),
#' )
save_png <- function(plot_code,
                     path,
                     width = 8,
                     height = 6,
                     units = "in",
                     res = 600,
                     ...) {
  on.exit(expr = {
    grDevices::dev.off()
  }, add = TRUE)

  grDevices::png(
    filename = path,
    width = width,
    height = height,
    units = units,
    res = res,
    ...
  )

  force(plot_code)

  return(invisible(path))
}
