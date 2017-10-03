n <- 20

# set.seed(10)
x <- runif(n, 1,10)
# set.seed(11)
y <- runif(n, 1,10)

test <- cbind(x,y)
dm <- as.matrix(dist(test, diag = T, upper = T))

start_row <- sample(1:n)[1]

sol <- c(start_row)
dmin <- vector()

r = start_row
maxcost <- max(test)+1
while(length(sol)< n){
      dm[,r] <- maxcost
      dmin <- c(dmin, min(dm[r,]))
      r <- grep(min(dm[r,]), dm[r,])
      
      sol <- c(sol, r)
}

sol
dmin

test2 <- data.frame(test, col=1:length(x), sol); 
test2[,3] <- as.factor(test2[,3])
b <- ggplot(test2, aes(x,y, color = col, label = col)) + geom_point() + geom_segment(aes(x=x[sol], y=y[sol], xend = x[sol[2:(n+1)]], yend = y[sol[2:(n+1)]]), arrow = arrow(length = unit(0.07, "npc")))
b +geom_text(aes(label=col),hjust=0, vjust=0)


