test_that("elephant", {
  expect_error(
    regexp = NA,
    {x := 1
      y := 3
      z := x + y
      x := x * 2
      bar <- x + y + z
      foo := x + sqrt(z) + bar
      print(foo)
      list_calves(foo)
      calf(foo, "z")
      iris2 := head(iris,2)
      print(iris2)
      baz := 1:2
      print(baz)
      poach()
      })
  expect_true(is.elephant(x))
  expect_false(is.elephant(forget(x)))
  expect_false(is.elephant(x+y))
  expect_false(is.elephant(x-y))
  expect_false(is.elephant(x*y))
  expect_false(is.elephant(x/y))
  expect_false(is.elephant(x^y))
  expect_false(is.elephant(x%%y))
  expect_false(is.elephant(x%/%y))
  expect_false(is.elephant(x + 1i))
  expect_false(is.elephant(Re(x)))
  expect_false(is.elephant(sqrt(x)))
  expect_false(is.elephant(x || x))
  expect_false(is.elephant(min(x)))
  expect_error(test := 2 * "a")
})
