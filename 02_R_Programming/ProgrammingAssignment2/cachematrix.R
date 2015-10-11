## A pair of functions that cache the inverse of a matrix to avoid 
## the costly repeated computation of ucached matrix inversion. 

## Computing the inverse of a square matrix can be done with the solve function in R. 
## For example, if X is a square invertible matrix, then solve(X) returns its inverse.

## !!!ASSUMPTION!!! ~ For this assignment, assume that the matrix supplied is always invertible, meaning 2x2 always, greatly simplifying the problem.

## makeCacheMatrix function creates a special "matrix" object that can cache its inverse.

makeCacheMatrix <- function(x = matrix()) {
        m <- NULL
        set <- function(y) {
                x <<- y
                m <<- NULL
        }
        get <- function() x
        setinverse <- function(inverseX) m <<- inverseX
        getinverse <- function() m
        ## Consturctor of Functions
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)
}


## cacheSolve function computes the inverse of the special "matrix" returned by makeCacheMatrix function.
## If the inverse has already been calculated (and the matrix has not changed), then cacheSolve should retrieve the inverse from the cache.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
        
        m <- x$getinverse()
        if(!is.null(m)) {
                message("getting cached data")
                return(m)
        }
        data <- x$get()
        ## Utilizing the Solve function here
        m <- solve(data, ...)
        x$setinverse(m)
        m
}