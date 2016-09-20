visualize.matrix <-
function(mat) {
  print(names(mat))
  
  image(1:nrow(mat$x), 1:ncol(mat$x), z=mat$x,
        col = c("darkgreen", "white"),
        xlab = "Observations", ylab = "Attributes")
  
  title(main = "Visualizing the Sparse Binary Matrix",
        font.main = 4)
  return (dim(mat$x)) #returns the dimensions of the matrix
}
