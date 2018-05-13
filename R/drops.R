#; Spamhaus DROP List 2018/05/13 - (c) 2018 The Spamhaus Project
#; https://www.spamhaus.org/drop/drop.txt
#; Last-Modified: Sat, 12 May 2018 21:54:15 GMT
#; Expires: Sun, 13 May 2018 01:58:05 GMT
#1.10.16.0/20 ; SBL256894
#1.32.128.0/18 ; SBL286275
#5.8.37.0/24 ; SBL284078
#5.34.242.0/23 ; SBL194796
#5.101.218.0/24 ; SBL284076
#5.101.221.0/24 ; SBL284077

.get_drop_gen <- function(drop_url) {

  res <- httr::GET(drop_url)

  httr::stop_for_status(res)

  res <- httr::content(res, as="text")

  res <- strsplit(res, "\n")[[1]]

  hdr <- res[1:10]

  exp <- hdr[grepl("; Expires:", hdr)]
  exptz <- sub(".* ([[:alnum:]]+)$", "\\1", exp)
  expires <- as.POSIXct(sub("; Expires: (.*)$", "\\1", exp), "%a, %d %B %Y %H:%M:%S", tz = exptz)

  lmod <- hdr[grepl("; Last-Modified:", hdr)]
  lmodtz <- sub(".* ([[:alnum:]]+)$", "\\1", lmod)
  lmod <- as.POSIXct(sub("; Last-Modified: (.*)$", "\\1", lmod), "%a, %d %B %Y %H:%M:%S", tz = lmodtz)

  out <- res[!grepl("^;", res)]
  out <- gsub("[[:space:]]*;[[:space:]]*", ";", out)
  out <- read.csv(text=out, sep=";", header = FALSE, stringsAsFactors = FALSE)
  out <- stats::setNames(out, c("netblock", "sbl_id"))

  out$last_mod <- lmod
  out$expires <- expires

  class(out) <- c("tbl_df", "tbl", "data.frame")

  out

}

.get_drop <- function() {
  .get_drop_gen("https://www.spamhaus.org/drop/drop.txt")
}

.get_edrop <- function() {
  .get_drop_gen("https://www.spamhaus.org/drop/edrop.txt")
}

.get_dropv6 <- function() {
  .get_drop_gen("https://www.spamhaus.org/drop/dropv6.txt")
}

.get_asndrop <- function() {
  out <- .get_drop_gen("https://www.spamhaus.org/drop/asndrop.txt")
  out <- stats::setNames(out, c("asn", "asn_org", "last_mod", "expires"))
  out
}

#' Spamhaus Don't Route Or Peer List
#'
#' Retrieves the Spamhaus Don't Route Or Peer List
#'
#' The DROP list will not include any IP address space under the control of any
#' legitimate network - even if being used by "the spammers from hell". DROP
#' will only include netblocks allocated directly by an established Regional
#' Internet Registry (RIR) or National Internet Registry (NIR) such as ARIN, RIPE,
#' AFRINIC, APNIC, LACNIC or KRNIC or direct RIR allocations.
#'
#' @md
#' @note This function is "memoised" because the DROP list changes quite slowly.
#'       There is _no need_ to update cached data **more than once per hour**,
#'       in fact once per day is more than enough in most cases. Automated downloads
#'       must be at least one hour apart. Excessive downloads may result in your IP
#'       being firewalled from the Spamhaus website.\cr\cr
#'       If you are using this from
#'       a long-running R session and need to fetch the list, use the [clear_drops()]
#'       function to clear the cache of all "DROP" get functions.
#' @references <https://www.spamhaus.org/drop/>; <https://www.spamhaus.org/faq/section/>
#' @export
get_drop <- memoise::memoise(.get_drop)

#' Spamhaus Extended DROP List (EDROP)
#'
#' Retrieves the Spamhaus Extended DROP List (EDROP)
#'
#' EDROP is an extension of the DROP list that includes suballocated netblocks
#' controlled by spammers or cyber criminals. EDROP is meant to be used in addition
#' to the direct allocations on the DROP list.
#'
#' @md
#' @note This function is "memoised" because the DROP list changes quite slowly.
#'       There is _no need_ to update cached data **more than once per hour**,
#'       in fact once per day is more than enough in most cases. Automated downloads
#'       must be at least one hour apart. Excessive downloads may result in your IP
#'       being firewalled from the Spamhaus website.\cr\cr
#'       If you are using this from
#'       a long-running R session and need to fetch the list, use the [clear_drops()]
#'       function to clear the cache of all "DROP" get functions.
#' @references <https://www.spamhaus.org/drop/>; <https://www.spamhaus.org/faq/section/>
#' @export
get_edrop <- memoise::memoise(.get_edrop)

#' Spamhaus IPv6 DROP List (DROPv6)
#'
#' Retrieves the Spamhaus IPv6 DROP List (DROPv6)
#'
#' The DROPv6 list includes IPv6 ranges allocated to spammers or cyber criminals.
#' DROPv6 will only include IPv6 netblocks allocated directly by an established
#' Regional Internet Registry (RIR) or National Internet Registry (NIR) such as
#' ARIN, RIPE, AFRINIC, APNIC, LACNIC or KRNIC or direct RIR allocations.
#'
#' @md
#' @note This function is "memoised" because the DROP list changes quite slowly.
#'       There is _no need_ to update cached data **more than once per hour**,
#'       in fact once per day is more than enough in most cases. Automated downloads
#'       must be at least one hour apart. Excessive downloads may result in your IP
#'       being firewalled from the Spamhaus website.\cr\cr
#'       If you are using this from
#'       a long-running R session and need to fetch the list, use the [clear_drops()]
#'       function to clear the cache of all "DROP" get functions.
#' @references <https://www.spamhaus.org/drop/>; <https://www.spamhaus.org/faq/section/>
#' @export
get_dropv6 <- memoise::memoise(.get_dropv6)

#' Spamhaus ASN DROP List (ASN-DROP)
#'
#' Retrieves the Spamhaus ASN DROP List (ASN-DROP)
#'
#' ASN-DROP contains a list of Autonomous System Numbers controlled by spammers
#' or cyber criminals, as well as "hijacked" ASNs. ASN-DROP can be used to filter
#' BGP routes which are being used for malicious purposes.
#'
#' @md
#' @note This function is "memoised" because the DROP list changes quite slowly.
#'       There is _no need_ to update cached data **more than once per hour**,
#'       in fact once per day is more than enough in most cases. Automated downloads
#'       must be at least one hour apart. Excessive downloads may result in your IP
#'       being firewalled from the Spamhaus website.\cr\cr
#'       If you are using this from
#'       a long-running R session and need to fetch the list, use the [clear_drops()]
#'       function to clear the cache of all "DROP" get functions.
#' @references <https://www.spamhaus.org/drop/>; <https://www.spamhaus.org/faq/section/>
#' @export
get_asndrop <- memoise::memoise(.get_asndrop)

#' Clear cache of all "DROP" functions
#'
#' The "DROP" functions are "memoised" because the DROP list changes quite slowly.
#' There is _no need_ to update cached data **more than once per hour**,
#' in fact once per day is more than enough in most cases. Automated downloads
#' must be at least one hour apart. Excessive downloads may result in your IP
#' being firewalled from the Spamhaus website.\cr\cr
#' If you are using them from
#' a long-running R session and need to fetch the list, use the this function
#' to clear the cache of all "DROP" get functions.
#'
#' @md
#' @export
clear_drops <- function() {
  memoise::forget(get_asndrop)
  memoise::forget(get_dropv6)
  memoise::forget(get_edrop)
  memoise::forget(get_drop)
}
