#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

library(httr)

# This script is aimed to the approximation of the value
# of pi via random sampling approximation

# test if there is at least one argument: if not, return an error
defaultVal = 1000000
n_val <- defaultVal

if (length(args)==0) {
  stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else {
  if(!is.null(args[1])) {
    n_val = args[1]
  }
}


# Optional, in order to make your results replicable by using the same set.seed()
# set.seed(3000)

# The function of the positive semi circumference (not used here, just for referenece)
semi_sp_positive <- function(x,yc,xc,r){
  y <- yc + sqrt(r**2 - (x - xc)**2)
  return(y)
}

# The function of the negative semi circumference
semi_sp_negative <- function(x,yc,xc,r){
  y <- yc - sqrt(r**2 - (x - xc)**2)
  return(y)
}

# Area of the square fitted around the circumference
square_area <- function(r){
  area <- r**2
  return(area)
}


# Plot a function using curve!!! The fastest way!
curve(semi_sp_positive(x,0,0,1),from = -1, to = 1, col = "green")
curve(semi_sp_negative(x,0,0,1),from = -1, to = 1, col = "green")


# We can just use half a circumference to achieve our task

# This function generate a random vector of uniformly distributed
# values between a and b
dots <- function(n,a,b){
  x = runif(n, min = a, max = b)
  return(x)
}

# The larger the number of random points, the better the approximation
# We built the two random vectors
x <- dots(n_val,-1,1)
y <- dots(n_val,-1,0)

#Add random points to the graph
points(x,y,col = "red")

# Start the Timer
ptm <- proc.time()

# We use a counter to keep track of points inside the semi circle
counter <- 0
for(i in 1:length(x)){
  if(semi_sp_negative(x[i],0,0,1) < y[i]){
    counter = counter + 1
  }    
}

# Now we calculate the ratio between inside and outside points
ratio = counter/length(x)

# We then calculate the area of half a square
half_area_square = square_area(2)/2

# We approximate the area of the semi-circumference
area_semicrf = half_area_square*ratio
a = paste("The area of the semi-circumference:",area_semicrf,sep=" ")

# And finally, we find out pi, which I named pie
# since R has a built-in approximation of pi
pie = 2*area_semicrf/1**2
b = paste("Our approximation of pi:", toString(pie),sep=" ")

# We can calculate how much we missed from the
# built-in value
error = (pi-pie)/pi*100
c = paste("We missed of", toString(error),"percent", sep = " ")

print(paste(a,b,c,sep="; "))

# Stop Time Timer
elapsedTime = proc.time() - ptm

print(n_val)
print(elapsedTime[3])

cdsw::track.metric("PiEst", pie)
cdsw::track.metric("NumIters", n_val)
cdsw::track.metric("ProcTime", elapsedTime[3])