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
#'   accessible in the container. These will be mounted using the identical
#'   paths on the host and with `read-only` permissions.
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
#' docker_run_rserver(volumes = "/home/dzhang/projects/dasper_analysis/raw_data;/home/dzhang/projects/dasper_analysis/scripts")
#' }
docker_run_rserver <- function(image = "bioconductor/bioconductor_docker:devel",
    port = 8888,
    password = "bioc",
    name = "dz_bioc",
    rm = FALSE,
    volumes = NULL) {

    # set up the args for password and port
    docker_flags <- list(
        env = paste0("PASSWORD=", password),
        publish = paste0(port, ":8787"),
        rm = rm,
        name = name
    ) %>%
        cmdfun::cmd_list_interp() %>%
        cmdfun::cmd_list_to_flags(prefix = "--")

    volume_flags <-
        volumes %>%
        stringr::str_split(";") %>%
        unlist() %>%
        stringr::str_c(., ":", .) %>%
        stringr::str_c("-v ", ., ":ro") %>%
        stringr::str_c(collapse = " ")

    docker_cmd(c("run", docker_flags, volume_flags, image))
}

#' @noRd
docker_cmd <- function(...) {
    system2("docker", ...)
}
