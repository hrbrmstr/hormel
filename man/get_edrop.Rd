% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/drops.R
\name{get_edrop}
\alias{get_edrop}
\title{Spamhaus Extended DROP List (EDROP)}
\usage{
get_edrop()
}
\description{
Retrieves the Spamhaus Extended DROP List (EDROP)
}
\details{
EDROP is an extension of the DROP list that includes suballocated netblocks
controlled by spammers or cyber criminals. EDROP is meant to be used in addition
to the direct allocations on the DROP list.
}
\note{
This function is "memoised" because the DROP list changes quite slowly.
There is \emph{no need} to update cached data \strong{more than once per hour},
in fact once per day is more than enough in most cases. Automated downloads
must be at least one hour apart. Excessive downloads may result in your IP
being firewalled from the Spamhaus website.\cr\cr
If you are using this from
a long-running R session and need to fetch the list, use the \code{\link[=clear_drops]{clear_drops()}}
function to clear the cache of all "DROP" get functions.
}
\references{
\url{https://www.spamhaus.org/drop/}; \url{https://www.spamhaus.org/faq/section/}
}
