% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/r_setup.R
\name{setup_r_git}
\alias{setup_r_git}
\alias{setup_Rprofile}
\alias{setup_Renviron}
\alias{setup_gitconfig}
\alias{setup_gitignore_global}
\alias{setup_rstudio_prefs}
\title{Set of functions to setup default R and git configuration files}
\usage{
setup_r_git(append = FALSE)

setup_Rprofile(
  path = "~/.Rprofile",
  template = "template_Rprofile",
  append = FALSE
)

setup_Renviron(
  path = "~/.Renviron",
  template = "template_Renviron",
  append = FALSE
)

setup_gitconfig(
  path = "~/.gitconfig",
  template = "template_gitconfig",
  append = FALSE
)

setup_gitignore_global(
  path = "~/.gitignore_global",
  template = "template_gitignore_global",
  append = FALSE
)

setup_rstudio_prefs(
  path = "~/.config/rstudio/rstudio-prefs.json",
  template = "template_rstudio-prefs",
  append = FALSE
)
}
\arguments{
\item{append}{\code{logical(1)} whether to append to or overwrite the \code{path} with
the \code{template}.}

\item{path}{\code{character(1)} path to the configuration file.}

\item{template}{\code{character(1)} name of the template configuration files
stored in \code{inst/extdata}}
}
\description{
These functions are used to setup default
\code{.Rprofile}/\code{.Renviron}/\code{.gitconfig}/\code{.gitignore_global}/\code{.rstudio-prefs.json}
configurations. This settings are based on my preference and some files,
e.g. \code{.gitconfig} contain info that will be specific to me personally. By
default, all functions will overwrite the existing files, though this can
be modified through the \code{append} argument.
}
\section{Functions}{
\itemize{
\item \code{setup_Rprofile}: Set up a default ~/.Rprofile

\item \code{setup_Renviron}: Set up a default ~/.Renviron

\item \code{setup_gitconfig}: Set up a default ~/.gitconfig

\item \code{setup_gitignore_global}: Set up a default ~/.gitignore_global

\item \code{setup_rstudio_prefs}: Set up a default ~/.config/rstudio/rstudio-prefs.json
}}

\examples{
\dontrun{
setup_Rprofile()
setup_Renviron()
setup_gitconfig()
setup_gitignore_global()
setup_rstudio_prefs()
}
}
\seealso{
https://docs.rstudio.com/ide/server-pro/session-user-settings.html#
lists all available rstudio preferences.
}
