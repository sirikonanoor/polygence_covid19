library(dplyr)
library(ggplot2)
library(reshape)

reff_data <- read.table("/Users/sirikonanoor/Documents/Polygence/reff.csv",
                        sep = ",")
# rename columns
colnames(reff_data) <- 1:2000

# reshape dataframe to have only one value column
reff_data <- melt(reff_data)

# create a x vector from 1 to the number of value for each variable
reff_data$x <- rep(1:length(reff_data$value[reff_data$variable==1]))
# head(reff_data)

# Use the dataframe in ggplot
reff_data %>%
  ggplot(data=reff_data, mapping = aes(x=x, y=value)) +
  geom_line() +
  theme(legend.position = (c(10, 10))) + 
  labs(x = "Steps (days)",
       y = "Num People Infected") 
