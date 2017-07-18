library(jsonlite)
library(httpcache)

#' R port of CIRCL.LU's PyPDNS Python module https://github.com/CIRCL/PyPDNS
#'
#' Given a domain name this will return a data.frame consisting of passive dns entries.
#'
#' TODO
#' Expiring cache
#' Domain age
#'
#' @param domain name to query
#' @param circl_user circl.lu service username
#' @param circl_password circl.lu service password
#' @param use_proxy switch proxy on, has to be a use_proxy object, e.g. use_proxy(url, port, username = "", password = "")
#' @param circl_pdns_service_url circl.lu pdns service url
#' @param enable_cache switch caching on / off
pdns.query <- function(domain, circl_user, circl_password, use_proxy,
                       circl_pdns_service_url = "https://www.circl.lu/pdns/query/",
                       enable_cache = FALSE) {
  if (enable_cache) {
    options(httpcache.on = TRUE)
  } else {
    options(httpcache.on = FALSE)
  }

  if (missing(domain) ) {
    stop("Missing domain parameter")
  }

  if (missing(circl_user) || missing(circl_password)) {
    stop("Missing CIRCL credentials")
  }

  if (!missing(use_proxy)) {
    resp <- GET(paste(sep = "", circl_pdns_service_url, domain),
              authenticate(circl_user, circl_password),
              use_proxy)
  } else {
    resp <- GET(paste(sep = "", circl_pdns_service_url, domain),
              authenticate(circl_user, circl_password))
  }

  result <- data.frame()
  for ( entry in unlist(strsplit(content(resp, as = "text"), "\n")) ) {
    result <- rbind(as.data.frame(fromJSON(entry)), result)
  }
  result
}
