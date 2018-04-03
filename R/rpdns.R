#' Query CIRCL.LU Passive DNS API
#'
#' Given a domain name this will return a data frame consisting of passive DNS entries.
#'
#' It is highly suggested that your CIRCL username and password be stored in
#' `CIRCL_USER` and `CIRCL_PASSWORD` (respectively) for the most efficient and secure
#' use of this package.
#'
#' @section TODO:
#' - Expiring cache
#' - Domain age
#'
#' @md
#' @param domain host/domain name to query
#' @param circl_user,circl_password circl.lu service username/password. Highly suggested
#'        that these be stored in environment variables (see parameters for which ones).
#' @param use_proxy switch proxy on, has to be an `httr::use_proxy` object, e.g.
#'        `use_proxy(url, port, username = "", password = "")`
#' @param circl_pdns_service_url <circl.lu> passive DNS service URL
#' @param enable_cache switch API result caching on / off
#' @param timeout request timeout (seconds); Default: 10s
#' @references CIRCL.LU's [PyPDNS Python module](https://github.com/CIRCL/PyPDNS);
#'             [CIRCL Passive DNS API](https://www.circl.lu/services/passive-dns/).
#' @export
#' @examples \dontrun{
#' pdns_query("www.microsoft.com")
#' pdns_query("www.circl.lu")
#' }
pdns_query <- function(
  domain,
  circl_user = Sys.getenv("CIRCL_USER"),
  circl_password = Sys.getenv("CIRCL_PASSWORD"),
  use_proxy,
  circl_pdns_service_url = "https://www.circl.lu/pdns/query",
  enable_cache = FALSE,
  timeout = 10) {

  options(httpcache.on = enable_cache)

  if (missing(domain)) stop("Missing domain parameter", call.=FALSE)
  if (circl_user == "") stop("Missing CIRCL credentials", call.=FALSE)
  if (circl_password == "") stop("Missing CIRCL credentials", call.=FALSE)

  if (!missing(use_proxy)) {

    httpcache::GET(
      url = sprintf("%s/%s", circl_pdns_service_url, domain),
      httr::authenticate(circl_user, circl_password),
      httr::user_agent(RPDNS_USER_AGENT),
      httr::timeout(timeout),
      use_proxy
    ) -> resp

  } else {

    httpcache::GET(
      url = sprintf("%s/%s", circl_pdns_service_url, domain),
      httr::authenticate(circl_user, circl_password),
      httr::user_agent(RPDNS_USER_AGENT),
      httr::timeout(timeout)
    ) -> resp

  }

  res <- httr::content(resp, as="text")
  res <- ndjson::flatten(strsplit(res, "\n")[[1]], cls = "tbl")

  res$count <- as.integer(res$count)
  res$time_first <- as.POSIXct(res$time_first, origin="1970-01-01 00:00:00", tz="GMT")
  res$time_last <- as.POSIXct(res$time_last, origin="1970-01-01 00:00:00", tz="GMT")

  res

}

#' @rdname pdns_query
#' @export
pdns.query <- pdns_query
