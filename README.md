
# hormel

Retrieve and Process ‘Spamhaus’ Zone/Host Metadata

## Description

The ‘Spamhaus Project’ is an international nonprofit organization that
tracks spam and related cyber threats such as phishing, malware and
botnets, provides realtime actionable and highly accurate threat
intelligence to the Internet’s major networks, corporations and security
vendors, and works with law enforcement agencies to identify and pursue
spam and malware sources worldwide. Methods are provided to retreive and
process ‘Spamhaus’ data.

## What’s Inside The Tin

The following functions are implemented:

  - `clear_drops`: Clear cache of all “DROP” functions
  - `get_asndrop`: Spamhaus ASN DROP List (ASN-DROP)
  - `get_drop`: Spamhaus Don’t Route Or Peer List
  - `get_dropv6`: Spamhaus IPv6 DROP List (DROPv6)
  - `get_edrop`: Spamhaus Extended DROP List (EDROP)

## Installation

``` r
devtools::install_github("hrbrmstr/hormel")
```

## Usage

``` r
library(hormel)
library(tidyverse)

# current verison
packageVersion("hormel")
```

    ## [1] '0.1.0'

``` r
get_asndrop()
```

    ## # A tibble: 367 x 4
    ##    asn    asn_org                                             last_mod            expires            
    ##    <chr>  <chr>                                               <dttm>              <dttm>             
    ##  1 AS612  US | PRECISIONTECH - PRECISION TECHNOLOGY Inc,US    2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  2 AS3266 US | POISONIX-, DE                                  2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  3 AS3396 US | EGG - T G & A                                  2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  4 AS3502 US | INTNET - Intelligence Network Online, Inc., US 2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  5 AS3563 US | PILOT-ASN - Pilot Network Services, Inc,US     2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  6 AS3791 US | VCHS-AS - Via Christi Health System, Inc., US  2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  7 AS3904 US | ASTHOUGHTPRT - ThoughtPort inc., US            2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  8 AS4640 AT | The Internetworking Corporation, Hong Kong     2018-05-13 10:47:10 2018-05-14 10:47:10
    ##  9 AS5784 US | GETNET - Getnet International, US              2018-05-13 10:47:10 2018-05-14 10:47:10
    ## 10 AS6218 US | MIBX - MIBX, Inc., US                          2018-05-13 10:47:10 2018-05-14 10:47:10
    ## # ... with 357 more rows

``` r
get_drop()
```

    ## # A tibble: 814 x 4
    ##    netblock       sbl_id    last_mod            expires            
    ##    <chr>          <chr>     <dttm>              <dttm>             
    ##  1 1.10.16.0/20   SBL256894 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  2 1.32.128.0/18  SBL286275 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  3 5.8.37.0/24    SBL284078 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  4 5.34.242.0/23  SBL194796 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  5 5.101.218.0/24 SBL284076 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  6 5.101.221.0/24 SBL284077 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  7 5.134.128.0/19 SBL270738 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  8 5.157.0.0/18   SBL207485 2018-05-12 21:54:15 2018-05-13 11:58:43
    ##  9 5.188.10.0/23  SBL402741 2018-05-12 21:54:15 2018-05-13 11:58:43
    ## 10 14.4.0.0/14    SBL187947 2018-05-12 21:54:15 2018-05-13 11:58:43
    ## # ... with 804 more rows

``` r
get_dropv6()
```

    ## # A tibble: 46 x 4
    ##    netblock       sbl_id    last_mod            expires            
    ##    <chr>          <chr>     <dttm>              <dttm>             
    ##  1 2a00:dfe0::/29 SBL211615 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  2 2a0a:a200::/29 SBL369605 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  3 2a00:4c80::/29 SBL303520 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  4 2a0c:c600::/32 SBL382543 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  5 2a0b:d900::/29 SBL390720 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  6 2a0b:dc0::/29  SBL371619 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  7 2a0a:ed40::/29 SBL371617 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  8 2a0c:d980::/29 SBL390707 2018-04-07 03:14:00 2018-05-13 11:47:10
    ##  9 2a0c:da80::/29 SBL390705 2018-04-07 03:14:00 2018-05-13 11:47:10
    ## 10 2a0a:a6c0::/29 SBL390700 2018-04-07 03:14:00 2018-05-13 11:47:10
    ## # ... with 36 more rows

``` r
get_edrop()
```

    ## # A tibble: 132 x 4
    ##    netblock        sbl_id    last_mod            expires            
    ##    <chr>           <chr>     <dttm>              <dttm>             
    ##  1 5.188.216.0/24  SBL394632 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  2 14.118.252.0/22 SBL390722 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  3 24.233.0.0/21   SBL356227 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  4 27.112.32.0/19  SBL237955 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  5 37.9.42.0/24    SBL394633 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  6 37.9.53.0/24    SBL273113 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  7 41.71.171.0/24  SBL260492 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  8 41.71.176.0/23  SBL260482 2018-05-09 02:49:23 2018-05-13 14:24:00
    ##  9 41.71.178.0/24  SBL260491 2018-05-09 02:49:23 2018-05-13 14:24:00
    ## 10 41.71.184.0/22  SBL260485 2018-05-09 02:49:23 2018-05-13 14:24:00
    ## # ... with 122 more rows
