
#' Create a file path and/or check if it exists
#'
#' Creates a file path and also can check/force it to exists in one step. Used
#' mostly in conjunction with `here::here`, for checking whether a file exists
#' (you've typed the path correctly).
#'
#' @param ... passed to `base::file.path`.
#' @param check_exists `logical(1)` specifying whether to print the path and if
#'   it exists locally.
#' @param force_exists `logical(1)` specifying whether to return an error if the
#'   path does not exist.
#'
#' @return file path
#' @export
#'
#' @examples
#'
#' file_path("/")
file_path <- function(..., check_exists = TRUE, force_exists = FALSE) {
  path <- file.path(...)

  if (check_exists) {
    message(paste0(
      path,
      ifelse(file.exists(path), " exists", " does not exist")
    ))
  }

  if (force_exists) {
    if (!file.exists(path)) {
      stop(paste0(
        path,
        " does not exist"
      ))
    }
  }

  return(path)
}
