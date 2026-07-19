
# Program 1 – Data Visualization using ggplot2

library(ggplot2)

# The mpg dataset is loaded automatically with ggplot2.[web:10]

# TODO: Create the four plots exactly as specified.

# Plot 1: scatter + smooth (overall) 
plot1 <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth(se = FALSE) 
# Plot 2: scatter + smooth grouped by drv 
plot2 <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point() + geom_smooth(aes(group = drv), se = FALSE) 
# Plot 3: scatter colored by drv + smooth overall 
plot3 <- ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + geom_point() + geom_smooth(se = FALSE)
# Plot 4: scatter colored by drv + smooth overall (color only in points) 
plot4 <- ggplot(mpg, aes(x = displ, y = hwy)) + geom_point(aes(color = drv)) + geom_smooth(se = FALSE)
