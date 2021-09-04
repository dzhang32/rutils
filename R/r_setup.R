#' Set of functions to setup default R and git configuration files
#'
#' @description These functions are used to setup default
#'   `.Rprofile`/`.Renviron`/`.gitconfig`/`.gitignore_global`/`.rstudio-prefs.json`
#'    configurations. This settings are based on my preference and some files,
#'   e.g. `.gitconfig` contain info that will be specific to me personally. By
#'   default, all functions will overwrite the existing files, though this can
#'   be modified through the `append` argument.
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
#' \dontrun{
#' setup_Rprofile()
#' setup_Renviron()
#' setup_gitconfig()
#' setup_gitignore_global()
#' setup_rstudio_pref()
#' }
setup_r_git <- function(append = FALSE) {
    setup_Rprofile(append = append)
    setup_Renviron(append = append)
    setup_gitconfig(append = append)
    setup_gitignore_global(append = append)
    setup_rstudio_pref(append = append)
}

#' @describeIn setup_r_git Set up a default ~/.Rprofile
#'
#' @export
setup_Rprofile <- function(path = "~/.Rprofile",
    template = "template_Rprofile",
    append = FALSE) {
    .setup_file(
        path = path,
        template = template,
        append = append
    )
}

#' @describeIn setup_r_git Set up a default ~/.Renviron
#'
#' @export
setup_Renviron <- function(path = "~/.Renviron",
    template = "template_Renviron",
    append = FALSE) {
    .setup_file(
        path = path,
        template = template,
        append = append
    )
}

#' @describeIn setup_r_git Set up a default ~/.gitconfig
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

#' @describeIn setup_r_git Set up a default ~/.gitignore_global
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

#' @describeIn setup_r_git Set up a default ~/.config/rstudio/rstudio-prefs.json
#'
#' @export
setup_rstudio_pref <- function(path = "~/.config/rstudio/rstudio-prefs.json",
    template = "template_rstudio-prefs",
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
