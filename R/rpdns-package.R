#' Query 'CIRCL' Passive 'DNS' 'API'
#'
#' 'CIRCL' 'Passive DNS' <https://www.circl.lu/services/passive-dns/> is a
#' database storing historical 'DNS' records from various resources including malware
#' analysis or partners. The 'DNS' historical data is indexed, which makes it searchable
#' for incident handlers, security analysts or researchers.
#'
#' It is highly suggested that your CIRCL username and password be stored in
#' `CIRCL_USER` and `CIRCL_PASSWORD` (respectively) for the most efficient and secure
#' use of this package.
#'
#' Output follows the [Passive DNS - Common Output Format](https://datatracker.ietf.org/doc/draft-dulaunoy-dnsop-passive-dns-cof/).
#'
#'
#' @md
#' @name rpdns
#' @docType package
#' @author Bob Rudis (bob@@rud.is)
#' @import httpcache
#' @importFrom ndjson flatten
#' @importFrom httr user_agent use_proxy authenticate timeout
NULL
