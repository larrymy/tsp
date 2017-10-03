tsp_nn_all <- function(n, seed){
      
      set.seed(seed);
      x <- runif(n, 0,100); y <- runif(n, 0,100)
      
      coordinates_matrix <- cbind(x,y) 
      distance_matrix <- as.matrix(dist(coordinates_matrix, diag = T, upper = T)) #distance matrix
      maxcost <- max(distance_matrix)+1
      
      all_start_list <- lapply(1:n, FUN = function(j){
            r <- start_row <- j
            sol <- c(start_row)
            dmin <- vector()
            dm <- distance_matrix
            while(length(sol)< n){
                  dm[,r] <- maxcost
                  dmin <- c(dmin, min(dm[r,]))
                  r <- grep(min(dm[r,]), dm[r,])
                  
                  sol <- c(sol, r)
            }
            dmin <- c(dmin, distance_matrix[sol[1], sol[length(sol)]])
            cost <- sum(dmin)
            
            plot_obj <- plot_TSP(coordinates_matrix, sol)
            
            
            LIST <- list(cost, plot_obj, sol, dmin)
            return(LIST)
      })
      
      return(all_start_list)
}

plot_TSP <- function(coordinates_matrix, sol){
      n <- nrow(coordinates_matrix);
      plot_matrix <- data.frame(coordinates_matrix, col=1:n, sol); 
      plot_matrix[,"col"] <- as.factor(plot_matrix[,"col"])
      b <- ggplot(plot_matrix, aes(x,y, color = col, label = col))  + 
            geom_point() + 
            geom_segment(aes(x=x[sol], y=y[sol], xend = x[sol[2:(n+1)]], yend = y[sol[2:(n+1)]]), arrow = arrow(length = unit(0.03, "npc"))) +
            geom_text(aes(label=col),hjust=0, vjust=0) + 
            geom_text(aes(x=x[sol[1]], y=y[sol[1]], label = "START"), vjust=1.5) +
            geom_text(aes(x=x[sol[n]], y=y[sol[n]], label = "END"), vjust=1.5) 
      return(b)
}

h <- tsp_nn_all(100,4)
cost_v <- sapply(h, function(j){j[[1]]})
m1 <- grep(min(cost_v), cost_v)[1]
m2 <- grep(max(cost_v), cost_v)[1]

hist(cost_v, 30); 
sd(cost_v)/mean(cost_v)
summary(cost_v)
h[[m1]][[2]]
# h[[m2]][[2]]
