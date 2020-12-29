#' Set of functions to setup default R and git configuration files
#'
#' @description These are used to setup default Rprofile/gitconfig/gitignore_global
#' configurations. They may be useful if you consistently need to set up new
#' instances e.g. via `docker_run_rserver`.
#'
#' @param path `character(1)` path to the configuration file.
#' @param template `character(1)` name of the template configuration files
#'   stored in `inst/extdata`
#' @param append `logical(1)` whether to append to or overwrite the `path` with
#'   the `template`.
#'
#' @return NULL
#' @export
#'
#' @examples
#'
#' \dontrun{
#' setup_Rprofile()
#' setup_Renviron()
#' setup_gitconfig()
#' setup_gitignore_global()
#' }
setup_Rprofile <- function(path = "~/.Rprofile",
                           template = "template_Rprofile",
                           append = TRUE) {
    .setup_file(
        path = path,
        template = template,
        append = append
    )
}

#' @describeIn setup_Rprofile Set up a default ~/.Renviron
#'
#' @export
setup_Renviron <- function(path = "~/.Renviron",
                           template = "template_Renviron",
                           append = TRUE) {
    .setup_file(
        path = path,
        template = template,
        append = append
    )
}

#' @describeIn setup_Rprofile Set up a default ~/.gitconfig
#'
#' @export
setup_gitconfig <- function(path = "~/.gitconfig",
    template = "template_gitconfig",
    append = FALSE) {
    .setup_file(
        path = path,
        template = template,
        append = append
    )
}

#' @describeIn setup_Rprofile Set up a default ~/.gitconfig
#'
#' @export
setup_gitignore_global <- function(path = "~/.gitignore_global",
    template = "template_gitignore_global",
    append = FALSE) {
    .setup_file(
        path = path,
        template = template,
        append = append
    )
}

#' @noRd
.setup_file <- function(path, template, append) {
    template <- system.file("extdata", paste0(template),
        package = "rutils",
        mustWork = TRUE
    )

    template <- readr::read_lines(template)

    readr::write_lines(template, file = path, append = append)
}
