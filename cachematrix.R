# This file containts two functions, makeCacheMatrix() and cacheSolve() for
# the R Programming week 2 assignment. They demonstrate various aspects of 
# functions, lexical scoping and the use of the <<- operator.

# ND 2014-06-12

# function makeCacheMatrix() returns four functions that allow a matrix to be
# stored (set) and retrieved (get), and an inverse matrix to be set (setinverse)
# and retrieved (getinverse)
makeCacheMatrix <- function(x = numeric()) {
  i <- NULL # initialise local variable for inverse matrix
  
  set <- function(y) {
    x <<- y # sets x to the value passed to the set function
    i <<- NULL # when a new matrix is set, its inverse is reinitialised
    # NB the <<- operator assigns values to variables in the parent environment,
    # i.e. the the environment in which the function is defined, which in this
    # case is the function makeCacheMatrix.
  }
  
  get <- function() x # returns x, found in the defining environment
  
  setinverse <- function(inverse) i <<- inverse # sets i to the value passed to the setinverse function
  
  getinverse <- function() i # returns i, found in the defining environment
  
  list(set = set, get = get,
       setinverse = setinverse,
       getinverse = getinverse) # return list of functions
}

# cacheSolve() function returns a previously calculated inverse matrix if
# present, otherwise it calculates, stores and returns a new inverse matrix
cacheSolve <- function(x, ...) {
  i <- x$getinverse()   # retrieve inverse matrix
  
  if(!is.null(i)) {     # if i is not null then something was been retrieved
    message("getting cached data")
    return(i)           # return retrieved inverse
  }
  
  data <- x$get()       # retrieve matrix
  i <- solve(data, ...) # calculate inverse
  x$setinverse(i)       # set calculated inverse
  i                     # return calculated inverse
}
