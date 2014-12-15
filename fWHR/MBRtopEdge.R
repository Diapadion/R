library(alphahull)                                  # Exposes ashape()

MBR <- function(points) {
  # Analyze the convex hull edges                       
  a <- ashape(points, alpha=1000)                 # One way to get a convex hull...
  e <- a$edges[, 5:6] - a$edges[, 3:4]            # Edge directions
  norms <- apply(e, 1, function(x) sqrt(x %*% x)) # Edge lengths
  v <- diag(1/norms) %*% e                        # Unit edge directions
  w <- cbind(-v[,2], v[,1])                       # Normal directions to the edges
  
  # Find the MBR
  vertices <- (points) [a$alpha.extremes, 1:2]    # Convex hull vertices
  minmax <- function(x) c(min(x), max(x))         # Computes min and max
  x <- apply(vertices %*% t(v), 2, minmax)        # Extremes along edges
  y <- apply(vertices %*% t(w), 2, minmax)        # Extremes normal to edges
  areas <- (y[1,]-y[2,])*(x[1,]-x[2,])            # Areas
  k <- which.min(areas)                           # Index of the best edge (smallest area)
  
  # Form a rectangle from the extremes of the best edge
  cbind(x[c(1,2,2,1,1),k], y[c(1,1,2,2,1),k]) %*% rbind(v[k,], w[k,])
    # set k to '3' among *5* points in order to draw miminum rectangle along top (brow) line
}




# Create sample data
set.seed(runif(1,1,300))
points <- matrix(rnorm(20*2), ncol=2)                 # Random (normally distributed) points

# a B C d e

#points <- matrix(c(c(-1.9,-1,1,1.9,0),c(0,2,2,0,-4)),nrow = 5, ncol = 2)
#points <- matrix(c(c(285, 430, 643, 781, 512),c(-459, -421, -427, -466, -831)),nrow = 5, ncol = 2)
points <- matrix(c(c(236, 430, 643, 869, 512),c(-459, -421, -427, -466, -831)),nrow = 5, ncol = 2)



#mbr <- MBR(points)

# Analyze the convex hull edges                       
a <- ashape(points, alpha=1000)                 # One way to get a convex hull...
e <- a$edges[, 5:6] - a$edges[, 3:4]            # Edge directions
norms <- apply(e, 1, function(x) sqrt(x %*% x)) # Edge lengths
v <- diag(1/norms) %*% e                        # Unit edge directions
w <- cbind(-v[,2], v[,1])                       # Normal directions to the edges

# Find the MBR
vertices <- (points) [a$alpha.extremes, 1:2]    # Convex hull vertices
minmax <- function(x) c(min(x), max(x))         # Computes min and max
x <- apply(vertices %*% t(v), 2, minmax)        # Extremes along edges
y <- apply(vertices %*% t(w), 2, minmax)        # Extremes normal to edges
areas <- (y[1,]-y[2,])*(x[1,]-x[2,])            # Areas
k <- which.min(areas)                           # Index of the best edge (smallest area)

# Form a rectangle from the extremes of the best edge
k = 3
mbr <- cbind(x[c(1,2,2,1,1),k], y[c(1,1,2,2,1),k]) %*% rbind(v[k,], w[k,])

# Plot the hull, the MBR, and the points
limits <- apply(mbr, 2, function(x) c(min(x),max(x))) # Plotting limits
plot(ashape(points, alpha=1000), col="Gray", pch=20, 
     xlim=limits[,1], ylim=limits[,2])                # The hull
lines(mbr, col="Blue", lwd=3)                         # The MBR
points(points, pch=19)    


height = abs(limits[2,2]-limits[1,2])
width = limits[2,1]-limits[1,1]
fWHR = width/height
