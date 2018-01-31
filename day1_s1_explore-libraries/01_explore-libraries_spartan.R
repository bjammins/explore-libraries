#' Which libraries does R search for packages?

#  .Library
#[1] "C:/PROGRA~1/R/R-34~1.0/library"

#' Installed packages

## use installed.packages() to get all installed packages

## how many packages? dim(installed.packages())
# 222 installed packages



#' Exploring the packages

## count some things! inspiration
##   * tabulate by LibPath, Priority, or both

inst_package <- as.data.frame(installed.packages())

inst_package %>% group_by(LibPath) %>% summarise(n=n()) #222
inst_package %>% group_by(Priority) %>% summarise(n=n())
inst_package %>% group_by(LibPath, Priority) %>% summarise(n=n())

##   * what proportion need compilation?

inst_package %>% filter(NeedsCompilation == "yes") %>% summarise(n=n())/dim(inst_package)[1]


##   * how break down re: version of R they were built on




#proportion needing compilation

#' Reflections

## reflect on ^^ and make a few notes to yourself; inspiration
##   * does the number of base + recommended packages make sense to you?
##   * how does the result of .libPaths() relate to the result of .Library?


#' Going further

## if you have time to do more ...

## is every package in .Library either base or recommended?
## study package naming style (all lower case, contains '.', etc
## use `fields` argument to installed.packages() to get more info and use it!
