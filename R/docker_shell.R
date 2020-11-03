#' Run an RStudio instance on the bioconductor docker image
#'
#' A wrapper for the docker function used to run a RStudio container on a
#' specified docker image. This will be available at the `port` specified on the
#' host.
#'
#' @param image `character(1)` name of the image to use
#' @param port `integer(1)` port of the host which will be used to access
#'   RStudio server via `localhost::port`
#' @param user a UN for the docker image - by default this will be part of the
#'   group ID 1024. The group is what permits `volumes` to be write-able.
#'   Volumes will inherit permissions from the host and therefore, must have
#'   group write permissions on the host.
#' @param password `character(1)` password to used for RStudio server
#' @param name `character(1)` name for the container.
#' @param rm `logical(1)` whether to use the `-rm` flag when running the
#'   container. Should the container be removed when stopped?
#' @param volumes_ro `character(1)` paths for the hosts files that you want
#'   accessible in the container. These will be mounted using the identical
#'   paths on the host and with `read-only` permissions.
#' @param volumes `character(1)` paths for the hosts files that you want
#'   accessible in the container. These will NOT be mounted with `read-only`
#'   permissions. Use this option with care, recommended only for directories
#'   that you want to output results into.
#'
#' @return NULL
#' @export
#'
#' @references `docker_run_rserver` is based on
#'   `https://github.com/LieberInstitute/megadepth/blob/master/R/megadepth.R`.
#'
#' @examples
#'
#' \dontrun{
#' docker_run_rserver()
#' }
docker_run_rserver <- function(image = "bioconductor/bioconductor_docker:devel",
    port = 8888,
    user = "rstudio",
    password = "bioc",
    name = "dz_bioc",
    rm = FALSE,
    volumes_ro = NULL,
    volumes = NULL) {

    # set up the args for password and port
    docker_flags <- list(
        user = paste0(user, ":1024"),
        env = paste0("PASSWORD=", password),
        publish = paste0(port, ":8787"),
        rm = rm,
        name = name
    ) %>%
        cmdfun::cmd_list_interp() %>%
        cmdfun::cmd_list_to_flags(prefix = "--")

    if (!is.null(volumes_ro)) {
        volumes_ro <-
            volumes_ro %>%
            .volumes_to_flag(read_only = TRUE)
    }

    if (!is.null(volumes)) {
        volumes <-
            volumes %>%
            .volumes_to_flag(read_only = FALSE)
    }

    .docker_cmd(c("run", docker_flags, volumes_ro, volumes, image))
}

#' @noRd
.volumes_to_flag <- function(volumes, read_only = FALSE) {
    volumes_flag <-
        volumes %>%
        stringr::str_c(., ":", .) %>%
        stringr::str_c("-v ", .)

    if (read_only) {
        volumes_flag <-
            volumes_flag %>%
            stringr::str_c(., ":ro")
    }

    volumes_flag <-
        volumes_flag %>%
        stringr::str_c(collapse = " ")

    return(volumes_flag)
}

#' @noRd
.docker_cmd <- function(...) {
    system2("docker", ...)
}
