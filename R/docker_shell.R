#' Run an RStudio instance on the bioconductor docker image
#'
#' A wrapper for the docker function used to run a RStudio container on a
#' specified docker image. This will be available at the `port` specified on the
#' host.
#'
#' @param image `character(1)` name of the image to use
#' @param port `integer(1)` port of the host which will be used to access
#'   RStudio server via `localhost::port`
#' @param password `character(1)` password to used for RStudio server
#' @param name `character(1)` name for the container.
#' @param rm `logical(1)` whether to use the `-rm` flag when running the
#'   container. Should the container be removed when stopped?
#' @param volumes `character(1)` paths for the hosts files that you want
#'   accessible in the container. See argument `permissions` for read/write
#'   access to these.
#' @param permissions `character(1)` if set to "match" (be careful!), then the
#'   permissions of the mounted volumes on the container, will match that of the
#'   host. I.e. the user executing the docker command will have permissions to
#'   read/write/execute in the container as they did on the host.
#' @param verbose `logical(1)` whether to display the command to be run (for
#'   debugging purposes).
#'
#' @return NULL
#' @export
#'
#' @references `docker_run_rserver` is based on
#'   `https://github.com/LieberInstitute/megadepth/blob/master/R/megadepth.R`.
#'   The solution for the `permissions` of the `volumes` was taken from
#'   https://github.com/rocker-org/rocker/wiki/Sharing-files-with-host-machine.
#'
#' @examples
#'
#' \dontrun{
#' docker_run_rserver()
#' }
docker_run_rserver <- function(
    image = "bioconductor/bioconductor_docker:devel",
    port = 8888,
    password = "bioc",
    name = "dz_bioc",
    rm = FALSE,
    volumes = NULL,
    permissions = NULL,
    verbose = TRUE) {

    # set up the args for password and port
    docker_flags <- list(
        env = paste0("PASSWORD=", password),
        publish = paste0(port, ":8787"),
        rm = rm,
        name = name
    ) %>%
        cmdfun::cmd_list_interp() %>%
        cmdfun::cmd_list_to_flags(prefix = "--")

    # set up UID to match the host user
    # so volume permissions also match the host
    if (!is.null(permissions)) {
        if (permissions == "match") {
            permissions <- "--env USERID=$UID"
        } else {
            stop("permissions must be `match` or NULL")
        }
    }

    if (!is.null(volumes)) {
        volumes <-
            volumes %>%
            .volumes_to_flag(read_only = FALSE)
    }

    docker_flags <- c("run", docker_flags, permissions, volumes, image)

    if (verbose) {
        message(
            "Running docker with flags: ",
            stringr::str_c(docker_flags, collapse = " ")
        )
    }

    .docker_cmd(docker_flags)
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
