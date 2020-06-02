
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
#>  x <- x * 2 # numeric, value: 2 
#>    x <- 1 # numeric, value: 1
y
#> [1] 3
#>  y <- 3 # numeric, value: 3
z
#> [1] 4
#>  z <- x + y # numeric, value: 4 
#>    x <- 1 # numeric, value: 1 
#>    y <- 3 # numeric, value: 3
bar
#> [1] 9
foo
#> [1] 13
#>  foo <- x + sqrt(z) + bar # numeric, value: 13 
#>    x <- x * 2 # numeric, value: 2 
#>      x <- 1 # numeric, value: 1 
#>    z <- x + y # numeric, value: 4 
#>      x <- 1 # numeric, value: 1 
#>      y <- 3 # numeric, value: 3 
#>    bar # numeric, value: 9
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
#>  x <- x * 2 # numeric, value: 2 
#>    x <- 1 # numeric, value: 1

# good
baz := x
baz
#> [1] 2
#>  baz <- x # numeric, value: 2 
#>    x <- x * 2 # numeric, value: 2 
#>      x <- 1 # numeric, value: 1

# good
baz <- forget(x)
baz
#> [1] 2
```

We can access the variables used to compute our elephant object by using
`list_calves()` or `calf()`.

``` r
list_calves(foo)
#> $x
#> [1] 2
#>  x <- x * 2 # numeric, value: 2 
#>    x <- 1 # numeric, value: 1 
#> 
#> $z
#> [1] 4
#>  z <- x + y # numeric, value: 4 
#>    x <- 1 # numeric, value: 1 
#>    y <- 3 # numeric, value: 3 
#> 
#> $bar
#> [1] 9
list_calves(foo, "z")
#> $x
#> [1] 1
#>  x <- 1 # numeric, value: 1 
#> 
#> $y
#> [1] 3
#>  y <- 3 # numeric, value: 3
calf(foo, "z")
#> [1] 4
#>  z <- x + y # numeric, value: 4 
#>    x <- 1 # numeric, value: 1 
#>    y <- 3 # numeric, value: 3
calf(foo, "z", "x")
#> [1] 1
#>  x <- 1 # numeric, value: 1
```

## Debugging with *elephant*

If an elephant calls fails, its memory is preserved and can be recovered
using `poach()`, see the example below :

``` r

test <- function(){
  x := 1
  y := 3
  z := x * 2
  bar <- x + y + z
  foo := x + sqrt(z) + bar * letters # <- problematic call!
}

test()
#> Elephant was killed in foo := x + sqrt(z) + bar * letters
#> Use poach() to collect its memory
#> Error in bar * letters: non-numeric argument to binary operator

poach()
#> [1] NA
#>  foo <- x + sqrt(z) + bar * letters # logical, value: NA 
#>    x <- 1 # numeric, value: 1 
#>    z <- x * 2 # numeric, value: 2 
#>      x <- 1 # numeric, value: 1 
#>    bar # numeric, value: 6 
#>    letters # character, length: 26

# extract the bar variable as used by foo, for further investigation
foo_poached <- poach()
calf(foo_poached, "letters")
#>  [1] "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s"
#> [20] "t" "u" "v" "w" "x" "y" "z"

# we can go deeper
calf(foo_poached, "z", "x")
#> [1] 1
#>  x <- 1 # numeric, value: 1
```

## Benchmark

`:=` has a small overhead, it shouldn’t slow your code much most of the
time:

``` r
bench::mark(
  elephant_assignment = (foo := x + sqrt(z) + bar), 
  standard_assignment = (foo <- x + sqrt(z) + bar), 
  check = FALSE)
#> # A tibble: 2 x 6
#>   expression               min   median `itr/sec` mem_alloc `gc/sec`
#>   <bch:expr>          <bch:tm> <bch:tm>     <dbl> <bch:byt>    <dbl>
#> 1 elephant_assignment     59us   65.9us    14454.        0B     18.6
#> 2 standard_assignment   27.9us   31.6us    29790.        0B     17.9
```

However it wouldn’t not be well advised, nor really that useful, to use
it in a loop growing an object as below.

``` r
x := 1
for (i in 1:4) {
  x:= x + 1
}
x
#> [1] 5
#>  x <- x + 1 # numeric, value: 5 
#>    x <- x + 1 # numeric, value: 4 
#>      x <- x + 1 # numeric, value: 3 
#>        x <- x + 1 # numeric, value: 2 
#>          x <- 1 # numeric, value: 1
```

It’s especially true for bigger objects as we’d be keeping in memory all
previous values that would have been flushed by the garbage collector if
we hadn’t used *elephant*.
