01\_explore-libraries\_jenny.R
================
bscheich
Wed Jan 31 17:06:33 2018

``` r
## how jenny might do this in a first exploration
## purposely leaving a few things to change later!
```

Which libraries does R search for packages?

``` r
.libPaths()
```

    ## [1] "C:/Program Files/R/R-3.4.0/library"

``` r
## let's confirm the second element is, in fact, the default library
.Library
```

    ## [1] "C:/PROGRA~1/R/R-34~1.0/library"

``` r
library(fs)  # find actual, real file paths
```

    ## Warning: package 'fs' was built under R version 3.4.3

``` r
path_real(.Library)  #actual, real file path
```

    ## C:/Program Files/R/R-3.4.0/library

Installed packages

``` r
library(tidyverse)
```

    ## Loading tidyverse: ggplot2
    ## Loading tidyverse: tibble
    ## Loading tidyverse: tidyr
    ## Loading tidyverse: readr
    ## Loading tidyverse: purrr
    ## Loading tidyverse: dplyr

    ## Warning: package 'tibble' was built under R version 3.4.2

    ## Warning: package 'readr' was built under R version 3.4.1

    ## Warning: package 'dplyr' was built under R version 3.4.2

    ## Conflicts with tidy packages ----------------------------------------------

    ## filter(): dplyr, stats
    ## lag():    dplyr, stats

``` r
ipt <- installed.packages() %>%
  as_tibble()

## how many packages?
nrow(ipt)
```

    ## [1] 223

Exploring the packages

``` r
## count some things! inspiration
##   * tabulate by LibPath, Priority, or both
ipt %>%
  count(LibPath, Priority)
```

    ## # A tibble: 3 x 3
    ##                              LibPath    Priority     n
    ##                                <chr>       <chr> <int>
    ## 1 C:/Program Files/R/R-3.4.0/library        base    14
    ## 2 C:/Program Files/R/R-3.4.0/library recommended    15
    ## 3 C:/Program Files/R/R-3.4.0/library        <NA>   194

``` r
##   * what proportion need compilation?
ipt %>%
  count(NeedsCompilation) %>%
  mutate(prop = n / sum(n))
```

    ## Warning: package 'bindrcpp' was built under R version 3.4.2

    ## # A tibble: 3 x 3
    ##   NeedsCompilation     n       prop
    ##              <chr> <int>      <dbl>
    ## 1               no   109 0.48878924
    ## 2              yes   101 0.45291480
    ## 3             <NA>    13 0.05829596

``` r
##   * how break down re: version of R they were built on
ipt %>%
  count(Built) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 4 x 3
    ##   Built     n       prop
    ##   <chr> <int>      <dbl>
    ## 1 3.4.0   148 0.66367713
    ## 2 3.4.1    40 0.17937220
    ## 3 3.4.2    14 0.06278027
    ## 4 3.4.3    21 0.09417040

Reflections

``` r
## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?
```

Going further

``` r
## if you have time to do more ...

## is every package in .Library either base or recommended?
all_default_pkgs <- list.files(.Library)
all_br_pkgs <- ipt %>%
  filter(Priority %in% c("base", "recommended")) %>%
  pull(Package)
setdiff(all_default_pkgs, all_br_pkgs)
```

    ##   [1] "acepack"         "acs"             "assertthat"     
    ##   [4] "backports"       "base64enc"       "BH"             
    ##   [7] "bindr"           "bindrcpp"        "bit"            
    ##  [10] "bit64"           "bitops"          "blob"           
    ##  [13] "blogdown"        "bookdown"        "broom"          
    ##  [16] "caTools"         "cellranger"      "checkmate"      
    ##  [19] "choroplethr"     "choroplethrMaps" "chron"          
    ##  [22] "cli"             "clipr"           "clisymbols"     
    ##  [25] "colorspace"      "config"          "crayon"         
    ##  [28] "crosstalk"       "curl"            "d3heatmap"      
    ##  [31] "data.table"      "DBI"             "dbplyr"         
    ##  [34] "dendextend"      "DEoptimR"        "desc"           
    ##  [37] "devtools"        "dichromat"       "digest"         
    ##  [40] "diptest"         "directlabels"    "dplyr"          
    ##  [43] "DT"              "dygraphs"        "enc"            
    ##  [46] "evaluate"        "flexdashboard"   "flexmix"        
    ##  [49] "forcats"         "foreach"         "formatR"        
    ##  [52] "Formula"         "fpc"             "fs"             
    ##  [55] "fuzzyjoin"       "gdalUtils"       "geojson"        
    ##  [58] "geojsonio"       "geojsonlint"     "geosphere"      
    ##  [61] "ggmap"           "ggplot2"         "ggthemes"       
    ##  [64] "gh"              "git2r"           "glue"           
    ##  [67] "gridExtra"       "gsubfn"          "gtable"         
    ##  [70] "haven"           "hexbin"          "highr"          
    ##  [73] "Hmisc"           "hms"             "htmlTable"      
    ##  [76] "htmltools"       "htmlwidgets"     "httpuv"         
    ##  [79] "httr"            "ini"             "installr"       
    ##  [82] "iterators"       "jpeg"            "jqr"            
    ##  [85] "jsonlite"        "jsonvalidate"    "kernlab"        
    ##  [88] "knitr"           "labeling"        "latticeExtra"   
    ##  [91] "lazyeval"        "leaflet"         "lettercase"     
    ##  [94] "lubridate"       "magrittr"        "mapdata"        
    ##  [97] "mapproj"         "maps"            "maptools"       
    ## [100] "markdown"        "mclust"          "memoise"        
    ## [103] "mime"            "miniUI"          "mnormt"         
    ## [106] "modelr"          "modeltools"      "munsell"        
    ## [109] "mvtnorm"         "noncensus"       "odbc"           
    ## [112] "openssl"         "packrat"         "pkgconfig"      
    ## [115] "PKI"             "plogr"           "plotly"         
    ## [118] "plyr"            "png"             "prabclus"       
    ## [121] "proto"           "protolite"       "psych"          
    ## [124] "purrr"           "pwr"             "quadprog"       
    ## [127] "R.methodsS3"     "R.oo"            "R.utils"        
    ## [130] "R6"              "rappdirs"        "raster"         
    ## [133] "RColorBrewer"    "Rcpp"            "RCurl"          
    ## [136] "RDSTK"           "readr"           "readxl"         
    ## [139] "rematch"         "rematch2"        "reshape2"       
    ## [142] "rgdal"           "rgeos"           "RgoogleMaps"    
    ## [145] "rjson"           "RJSONIO"         "rlang"          
    ## [148] "rmapshaper"      "rmarkdown"       "robustbase"     
    ## [151] "RODBC"           "rprojroot"       "rsconnect"      
    ## [154] "RSocrata"        "RSQLite"         "rstudioapi"     
    ## [157] "rvest"           "sas7bdat"        "scales"         
    ## [160] "selectr"         "servr"           "shiny"          
    ## [163] "sourcetools"     "sp"              "sparklyr"       
    ## [166] "spbabel"         "spdplyr"         "sqldf"          
    ## [169] "stringdist"      "stringi"         "stringr"        
    ## [172] "styler"          "taskscheduleR"   "tibble"         
    ## [175] "tidyr"           "tidyverse"       "tigris"         
    ## [178] "translations"    "trimcluster"     "usethis"        
    ## [181] "uuid"            "V8"              "viridis"        
    ## [184] "viridisLite"     "WDI"             "wesanderson"    
    ## [187] "whisker"         "withr"           "XML"            
    ## [190] "xml2"            "xtable"          "xts"            
    ## [193] "yaml"            "zoo"

``` r
## study package naming style (all lower case, contains '.', etc

## use `fields` argument to installed.packages() to get more info and use it!
ipt2 <- installed.packages(fields = "URL") %>%
  as_tibble()
ipt2 %>%
  mutate(github = grepl("github", URL)) %>%
  count(github) %>%
  mutate(prop = n / sum(n))
```

    ## # A tibble: 2 x 3
    ##   github     n      prop
    ##    <lgl> <int>     <dbl>
    ## 1  FALSE   115 0.5156951
    ## 2   TRUE   108 0.4843049
