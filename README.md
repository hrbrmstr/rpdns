
# rpdns

Query ‘CIRCL’ Passive ‘DNS’ ‘API’

## Description

‘CIRCL’ ‘Passive DNS’ <https://www.circl.lu/services/passive-dns/> is a
database storing historical ‘DNS’ records from various resources
including malware analysis or partners. The ‘DNS’ historical data is
indexed, which makes it searchable for incident handlers, security
analysts or researchers.

It is highly suggested that your CIRCL username and password be stored
in `CIRCL_USER` and `CIRCL_PASSWORD` (respectively) for the most
efficient and secure use of this package.

Output follows the [Passive DNS - Common Output
Format](https://datatracker.ietf.org/doc/draft-dulaunoy-dnsop-passive-dns-cof/).

This is a “package”-ized version of @michaelschratt’s
[script](https://github.com/michaelschratt/rpdns).

## What’s Inside The Tin

  - `pdns.query`: Query CIRCL.LU Passive DNS API
  - `pdns_query`: Query CIRCL.LU Passive DNS API

The following functions are implemented:

## Installation

``` r
devtools::install_github("hrbrmstr/rpdns")
```

## Usage

``` r
library(rpdns)

# current verison
packageVersion("rpdns")
```

    ## [1] '0.1.0'

``` r
pdns_query("www.microsoft.com")
```

    ## # A tibble: 3 x 7
    ##   count origin                     rdata                   rrname        rrtype time_first          time_last          
    ##   <int> <chr>                      <chr>                   <chr>         <chr>  <dttm>              <dttm>             
    ## 1 15524 https://www.circl.lu/pdns/ www.microsoft.com-c-2.… www.microsof… CNAME  2016-10-07 07:26:47 2018-01-25 01:36:00
    ## 2  2155 https://www.circl.lu/pdns/ www.microsoft.com-c-3.… www.microsof… CNAME  2018-01-25 02:45:55 2018-04-03 04:33:44
    ## 3 55367 https://www.circl.lu/pdns/ toggle.www.ms.akadns.n… www.microsof… CNAME  2011-02-22 18:06:42 2012-02-14 09:40:19

``` r
pdns_query("www.circl.lu")
```

    ## # A tibble: 3 x 7
    ##    count origin                     rdata          rrname       rrtype time_first          time_last          
    ##    <int> <chr>                      <chr>          <chr>        <chr>  <dttm>              <dttm>             
    ## 1 982014 https://www.circl.lu/pdns/ cpab.circl.lu  www.circl.lu CNAME  2016-10-07 07:26:02 2018-03-31 14:17:17
    ## 2  20426 https://www.circl.lu/pdns/ 194.154.205.24 www.circl.lu A      2011-02-22 18:13:37 2011-03-04 18:41:17
    ## 3  23479 https://www.circl.lu/pdns/ cpa.circl.lu   www.circl.lu CNAME  2011-02-22 18:06:42 2012-02-14 09:31:34
