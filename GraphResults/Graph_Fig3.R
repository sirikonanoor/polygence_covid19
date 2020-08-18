# This file contains all the figures in Fig. 3 in Results section

library(dplyr)
library(ggplot2)


### FIGURE 3:

# Figure 3. a)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.0 <- paste0(input_path, "vaccine_efficacy_0.0.csv")
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")


# read data with compliance 0.0 and rbind
data1 <- read.table(file = full_path_comp_0.0,
                    sep = ",") %>%
  mutate(compliance = "0")

# read data with compliance 0.4
data2 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "40") %>%
  rbind(data1, .)

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "80") %>%
  rbind(data2, .)

full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_effectiveness",
                         "percent_infected",
                         "protection",
                         "reff",
                         "compliance")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_effectiveness,
             y = percent_infected,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
               aes(color = compliance)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Percent Infected",
       color = "Compliance (%)") + 
  theme_light() + 
  theme(legend.position = c(0.25, 0.2),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(-1, 30),
                     breaks = seq(0, 30, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))


# Figure 3. b)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.0 <- paste0(input_path, "vaccine_efficacy_0.0.csv")
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")


# read data with compliance 0.0 and rbind
data1 <- read.table(file = full_path_comp_0.0,
                    sep = ",") %>%
  mutate(compliance = "0")

# read data with compliance 0.4
data2 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "40") %>%
  rbind(data1, .)

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "80") %>%
  rbind(data2, .)

full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_effectiveness",
                         "percent_infected",
                         "protection",
                         "reff",
                         "compliance")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_effectiveness,
             y = protection,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
               aes(color = compliance)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Protective Effect (%)",
       color = "Compliance (%)") + 
  theme_light() + 
  theme(legend.position = c(0.3, 0.6),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(-2, 30),
                     breaks = seq(0, 30, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))

# Figure 3. c)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.0 <- paste0(input_path, "vaccine_efficacy_0.0.csv")
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")


# read data with compliance 0.0 and rbind
data1 <- read.table(file = full_path_comp_0.0,
                    sep = ",") %>%
  mutate(compliance = "0")

# read data with compliance 0.4
data2 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "40") %>%
  rbind(data1, .)

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "80") %>%
  rbind(data2, .)

full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_effectiveness",
                         "percent_infected",
                         "protection",
                         "reff",
                         "compliance")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_effectiveness,
             y = reff,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
               aes(color = compliance)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Reff",
       color = "Compliance (%)") + 
  theme_light() + 
  theme(legend.position = c(0.25, 0.2),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))



