# In my following function makeCacheMatrix, I determined that my function will be applied
# to x, that is my matrix in current environment.
# Then I set the value of a, my anonymous variable, to be NULL.
# Next, I assigned value to my matrix according to an anonymous function using
# the <<- operator. Thus, the value set is different than my current environment.
# Next, I used 'get' to tell R to fetch the values within my matrix.
# Next, I used 'setInv' to explain to R that the function (Inv) applied
# to my current anonymous variable `a` is also set as the (Inv) in the envoriment
# that is different from my current one

makeCacheMatrix <- function (x = matrix()) {
    a <- NULL
    set <- function (y) {
        x <<- y
        a <<- NULL
    }
    get <- function() x
    setInv <- function(Inv) a <<- Inv
    getInv <- function() a
    list(set = set, get = get,
         setInv = setInv, getInv = getInv)
}

# In order to compute the inverse of my matrix,
# I will use the R function 'solve'.
# 'solve' is a generic function that solves the equation a %*% x = b for x,
# where b can be either a vector or a matrix.
# In this case, if I have a matrix 'mat', then its inverse
# can be returned by typing solve (mat)

cacheSolve <- function(x, ...) {
    a <- x$getInv()
    if(!is.null(a)){
        message("getting cached data")
        return(a)
    }
    mat <- x$get()
    a <- solve(mat,...)
    x$setInv(a)
    a
}