% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_sum_stats.R
\name{get_sum_stats}
\alias{get_sum_stats}
\title{Calculate summary statistics}
\usage{
get_sum_stats(
  df,
  sum_vars,
  group_vars = NULL,
  sum_funcs = list(mean = base::mean, sd = stats::sd, median = stats::median, iqr =
    stats::IQR)
)
}
\arguments{
\item{df}{a \code{data.frame} object.}

\item{sum_vars}{\code{character()} vector with name of columns to \code{summarize}.}

\item{group_vars}{\code{character()} vector with name of columns to \code{group_by()}}

\item{sum_funcs}{either function or list of functions. By default, uses
\code{base::mean()}, \code{stats::sd()}, \code{stats::median()}, \code{stats::IQR()}.}
}
\value{
\link[tibble:tbl_df-class]{tibble} object containing summarized data.
}
\description{
Calculate summary statistics
}
\examples{

iris_summary <-
    get_sum_stats(
        iris,
        sum_vars = "Sepal.Length",
        group_vars = "Species"
    )
}
