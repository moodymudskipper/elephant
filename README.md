
<!-- README.md is generated from README.Rmd. Please edit that file -->

# elephant <img src='man/figures/logo.png' align="right" height="139" />

> Elephants never forget\!

*elephant* is a quick experiment on how to make variables remember their
history.

Use `:=` to record a call.

## Installation

Install with:

``` r
remotes::install_github("moodymudskipper/elephant")
```

## Example

``` r
library(elephant)
## basic example code
```

We build an elephant object by using `:=`

``` r
x := 1
y := 3
z := x + y
x := x * 2
bar <- x + y + z
foo := x + sqrt(z) + bar

x
#> [1] 2
#>  x <- x * 2 
#>    x <- 1
y
#> [1] 3
#>  y <- 3
z
#> [1] 4
#>  z <- x + y 
#>    x <- 1 
#>    y <- 3
bar
#> [1] 9
foo
#> [1] 13
#>  foo <- x + sqrt(z) + bar 
#>    x <- x * 2 
#>      x <- 1 
#>    z <- x + y 
#>      x <- 1 
#>      y <- 3
```

Here we see `bar` is not an elephant object because it doesn’t use `:=`
and `+.elephant` doesn’t preserve class and attributes.

However `baz <- x` would just copy the object, so in this case it’s
advised to do either `baz := x` or `baz <- forget(x)`

``` r
# not good
baz <- x
baz
#> [1] 2
#>  x <- x * 2 
#>    x <- 1

# good
baz := x
baz
#> [1] 2
#>  baz <- x 
#>    x <- x * 2 
#>      x <- 1

# good
baz <- forget(x)
baz
#> [1] 2
```
