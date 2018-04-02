#' Query CIRCL.LU Passive DNS API
#'
#' Given a domain name this will return a data frame consisting of passive DNS entries.
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
#' @references CIRCL.LU's [PyPDNS Python module](https://github.com/CIRCL/PyPDNS)
#' @export
pdns_query <- function(domain,
                       circl_user = Sys.getenv("CIRCL_USER"),
                       circl_password = Sys.getenv("CIRCL_PASSWORD"),
                       use_proxy,
                       circl_pdns_service_url = "https://www.circl.lu/pdns/query/",
                       enable_cache = FALSE) {

  options(httpcache.on = enable_cache)

  if (missing(domain)) stop("Missing domain parameter", call.=FALSE)

  if (missing(circl_user) || missing(circl_password)) {
    stop("Missing CIRCL credentials", call.=FALSE)
  }

  if (!missing(use_proxy)) {

    httpcache::GET(
      url = paste(sep = "", circl_pdns_service_url, domain),
      httr::authenticate(circl_user, circl_password),
      httr::user_agent(RPDNS_USER_AGENT),
      use_proxy
    ) -> resp

  } else {

    httpcache::GET(
      url = paste(sep = "", circl_pdns_service_url, domain),
      httr::authenticate(circl_user, circl_password),
      httr::user_agent(RPDNS_USER_AGENT)
    ) -> resp

  }

  do.call(
    rbind,
    lapply(
      unlist(strsplit(httpcache::content(resp, as = "text"), "\n")),
      function(entry) rbind(jsonlite::fromJSON(entry))
    )
  ) -> res

  class(res) <- c("tbl_df", "tbl", "data.frame")

}

#' @rdname pdns_query
#' @export
pdns.query <- pdns_query
