# This file contains all the figures in Fig. 2 in Results section

library(dplyr)
library(ggplot2)


###FIGURE 2

# Figure 2. a)
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")


# read data with effectiveness 0.0
data1 <- read.table(file = full_path_eff_0.0,
                    sep = ",") %>%
  mutate(effectiveness = "0")

# read data with effectiveness 0.4
data2 <- read.table(file = full_path_eff_0.4,
                    sep = ",") %>%
  mutate(effectiveness = "40") %>%
  rbind(data1, .)

# read data with effectiveness 0.8 and rbind
full_data <- read.table(file = full_path_eff_0.8,
                        sep = ",") %>%
  mutate(effectiveness = "80") %>%
  rbind(data2, .)

full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_compliance",
                         "percent_infected",
                         "protection",
                         "reff",
                         "effectiveness")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_compliance,
             y = percent_infected,
             group = effectiveness)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 1,
               width = 5,
               geom = "point",
               aes(color = effectiveness)) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.4,
               width = 5,
               geom = "line",
               aes(color = effectiveness)) +
  labs(x = "Vaccine Compliance (%)",
       y = "Percent Infected",
       color = "Effectiveness (%)") + 
  theme_light() + 
  theme(legend.position = c(0.8, 0.3),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 30),
                     breaks = seq(0, 30, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))


# Figure 2. b)
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")


# read data with effectiveness 0.0
data1 <- read.table(file = full_path_eff_0.0,
                    sep = ",") %>%
  mutate(effectiveness = "0")

# read data with effectiveness 0.4
data2 <- read.table(file = full_path_eff_0.4,
                    sep = ",") %>%
  mutate(effectiveness = "40") %>%
  rbind(data1, .)

# read data with effectiveness 0.8 and rbind
full_data <- read.table(file = full_path_eff_0.8,
                        sep = ",") %>%
  mutate(effectiveness = "80") %>%
  rbind(data2, .)

full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_compliance",
                         "percent_infected",
                         "protection",
                         "reff",
                         "effectiveness")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_compliance,
             y = protection,
             group = effectiveness)) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 1,
               width = 5,
               geom = "point",
               aes(color = effectiveness)) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.4,
               width = 5,
               geom = "line",
               aes(color = effectiveness)) +
  labs(x = "Vaccine Compliance (%)",
       y = "Protective Effect (%)",
       color = "Effectiveness (%)") + 
  theme_light() + 
  theme(legend.position = c(0.2, 0.7),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 30),
                     breaks = seq(0, 30, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))


# Figure 2. c)
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")


# read data with effectiveness 0.0
data1 <- read.table(file = full_path_eff_0.0,
                    sep = ",") %>%
  mutate(effectiveness = "0")

# read data with effectiveness 0.4
data2 <- read.table(file = full_path_eff_0.4,
                    sep = ",") %>%
  mutate(effectiveness = "40") %>%
  rbind(data1, .)

# read data with effectiveness 0.8 and rbind
full_data <- read.table(file = full_path_eff_0.8,
                        sep = ",") %>%
  mutate(effectiveness = "80") %>%
  rbind(data2, .)

full_data[, 1] = full_data[, 1] * 100

# name columns
colnames(full_data) <- c("vaccine_compliance",
                         "percent_infected",
                         "protection",
                         "reff",
                         "effectiveness")

# plot!
full_data %>%
  ggplot(aes(x = vaccine_compliance,
             y = reff,
             group = effectiveness)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 1,
               width = 5,
               geom = "point",
               aes(color = effectiveness)) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.4,
               width = 5,
               geom = "line",
               aes(color = effectiveness)) +
  labs(x = "Vaccine Compliance (%)",
       y = "Reff",
       color = "Effectiveness (%)") + 
  theme_light() + 
  theme(legend.position = c(0.3, 0.3),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))

