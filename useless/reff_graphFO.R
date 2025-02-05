library(dplyr)
library(ggplot2)
library(tidyr)

# set threshold for superspreader
super_spreader <- 10

# num steps
num_steps <- 100

# read data in and transpose
reff_data <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig4reff.csv",
                        sep = ",") %>%
  t() %>%
  as.data.frame() %>%
  # keep only superspreaders
  filter(
    rowSums(.) > super_spreader
  )

# make cumulative sum
reff_cummulative <- data.frame(t(apply(reff_data, 1, cumsum)))

# rename columns
colnames(reff_cummulative) <- 1:num_steps

# add person index
reff_cummulative <- reff_cummulative %>%
  mutate(
    person = row_number()
  )

# reshape dataframe (pivot longer)
reff_final <- reff_cummulative %>%
  pivot_longer(-person,
               names_to = "step",
               values_to = "infected") %>%
  arrange(person)

# make steps integers
reff_final$step <- as.numeric(reff_final$step)

# "factorize" people
reff_final$person <- factor(reff_final$person)

# plot 1 - each line is a person
reff_final %>%
  filter(person %in% c(49, 21, 8, 16, 35, 3)) %>%
  ggplot(aes(x = step,
             y = infected,
             colour = person,
             group = person)) +
  geom_line(lwd = 0.5) +
  theme_light() +
  labs(
    x = "Simulation Step (days)",
    y = "Cumulative Number of Infected People"
  )