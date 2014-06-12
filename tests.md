Programming Assignment 2
========================

_Learning about functions and lexical scoping_

ND 2014-06-12


```r
source("cachematrix.R")
```

R functions can return functions. The `makeCacheMatrix()` function returns a list of 4 functions.


```r
makeCacheMatrix
```

```
## function (x = numeric()) 
## {
##     i <- NULL
##     set <- function(y) {
##         x <<- y
##         i <<- NULL
##     }
##     get <- function() x
##     setinverse <- function(inverse) i <<- inverse
##     getinverse <- function() i
##     list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
## }
```


```r
m <- makeCacheMatrix()
str(m)
```

```
## List of 4
##  $ set       :function (y)  
##  $ get       :function ()  
##  $ setinverse:function (inverse)  
##  $ getinverse:function ()
```

`m` can contain a matrix, which is set using the `m$set()` function.


```r
# store an example 2 x 2 matrix with the 'set' function
m$set(matrix(data = 1:4, nrow = 2, ncol = 2))
```

`m` now contains the example matrix, which can be obtained with the `m$get()` function.


```r
# return the example matrix with the 'get' function
m$get()
```

```
##      [,1] [,2]
## [1,]    1    3
## [2,]    2    4
```

`m` can also contain an inverse matrix, which is set using the `m$setinverse()` function. The inverse matrix can be obtained using the `solve()` function, which returns the inverse of a matrix if called with only one argument (i.e. the matrix to be inverted).


```r
# store the inverse of the example matrix with the 'setinverse' function
m$setinverse(solve(m$get()))
```

`m` now also contains the inverse of the example matrix, which can be obtained with the `m$getinverse()` function.


```r
# return the inverse of the example matrix with the 'getinverse' function
m$getinverse()
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

What we now want to do is cache the inverse matrix so it doesn't need to be calculated on each function call. The function `cacheSolve()` will do this.


```r
cacheSolve
```

```
## function (x, ...) 
## {
##     i <- x$getinverse()
##     if (!is.null(i)) {
##         message("getting cached data")
##         return(i)
##     }
##     data <- x$get()
##     i <- solve(data, ...)
##     x$setinverse(i)
##     i
## }
```


```r
# return the inverse of the example matrix stored in m with the 'cachesolve' function
cacheSolve(m)
```

```
## getting cached data
```

```
##      [,1] [,2]
## [1,]   -2  1.5
## [2,]    1 -0.5
```

Because the inverse matrix has already been set manually and is returned by the function `x$getinverse()`, `cacheSolve(m)` prints the message `getting cached data` before returning the inverse matrix. However if a new matrix is set, `cacheSolve(m)` will calculate and return the new inverse matrix.


```r
# create a new matrix
m$set(matrix(data = c(2, 2, 3, 2), nrow = 2, ncol = 2))
m$get()
```

```
##      [,1] [,2]
## [1,]    2    3
## [2,]    2    2
```


```r
# return the inverse of the new matrix stored in m
cacheSolve(m)
```

```
##      [,1] [,2]
## [1,]   -1  1.5
## [2,]    1 -1.0
```

If `cacheSolve(m)` is called a second time it will return the cached value rather than recalculating.


```r
# return the cached inverse
cacheSolve(m)
```

```
## getting cached data
```

```
##      [,1] [,2]
## [1,]   -1  1.5
## [2,]    1 -1.0
```
