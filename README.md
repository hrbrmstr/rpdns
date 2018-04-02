
# rpdns

Query ‘CIRCL’ Passive ‘DNS’ ‘API’

## Description

‘CIRCL’ ‘Passive DNS’ <https://www.circl.lu/services/passive-dns/> is a
database storing historical ‘DNS’ records from various resources
including malware analysis or partners. The ‘DNS’ historical data is
indexed, which makes it searchable for incident handlers, security
analysts or researchers.

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
