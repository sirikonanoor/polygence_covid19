# This file contains all the Supplemental Figures in Results section

library(dplyr)
library(ggplot2)
library(tidyr)

# Supplemental Figure 1
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
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
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



# Supplemental Figure 2
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
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
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


# Supplemental Figure 3
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
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
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



# Supplemental Figure 4
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
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


# Supplemental Figure 5
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
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



# Supplemental Figure 6
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
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



# Supplemental Figure 7
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")
full_path_eff_0.6 <- paste0(input_path, "vaccine_compliance_0.6.csv")
full_path_eff_0.7 <- paste0(input_path, "vaccine_compliance_0.7.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")
full_path_eff_0.9 <- paste0(input_path, "vaccine_compliance_0.9.csv")
full_path_eff_1.0 <- paste0(input_path, "vaccine_compliance_1.0.csv")

# read data with effectiveness 0.0
data.0 <- read.table(file = full_path_eff_0.0,
                     sep = ",") %>%
  mutate(effectiveness = "0")
# read data with effectiveness 0.5 and rbind
data.4 <- read.table(file = full_path_eff_0.4,
                     sep = ",") %>%
  mutate(effectiveness = "40") %>%
  rbind(data.0, .)
# read data with effectiveness 0.5 and rbind
data.5 <- read.table(file = full_path_eff_0.5,
                     sep = ",") %>%
  mutate(effectiveness = "50") %>%
  rbind(data.4, .)
# read data with effectiveness 0.6 and rbind
data.6 <- read.table(file = full_path_eff_0.6,
                     sep = ",") %>%
  mutate(effectiveness = "60") %>%
  rbind(data.5, .)
# read data with effectiveness 0.7 and rbind
data.7 <- read.table(file = full_path_eff_0.7,
                     sep = ",") %>%
  mutate(effectiveness = "70") %>%
  rbind(data.6, .)
# read data with effectiveness 0.8 and rbind
data.8 <- read.table(file = full_path_eff_0.8,
                     sep = ",") %>%
  mutate(effectiveness = "80") %>%
  rbind(data.7, .)
# read data with effectiveness 0.9 and rbind
data.9 <- read.table(file = full_path_eff_0.9,
                     sep = ",") %>%
  mutate(effectiveness = "90") %>%
  rbind(data.8, .)
# read data with effectiveness 1.0 and rbind
full_data <- read.table(file = full_path_eff_1.0,
                        sep = ",") %>%
  mutate(effectiveness = "100") %>%
  rbind(data.9, .)

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
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
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
  scale_color_discrete(breaks=c("0","40","50", "60",
                                "70","80","90","100")) + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 20),
                     breaks = seq(0, 20, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))



# Supplemental Figure 8
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")
full_path_eff_0.6 <- paste0(input_path, "vaccine_compliance_0.6.csv")
full_path_eff_0.7 <- paste0(input_path, "vaccine_compliance_0.7.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")
full_path_eff_0.9 <- paste0(input_path, "vaccine_compliance_0.9.csv")
full_path_eff_1.0 <- paste0(input_path, "vaccine_compliance_1.0.csv")

# read data with effectiveness 0.0
data.0 <- read.table(file = full_path_eff_0.0,
                     sep = ",") %>%
  mutate(effectiveness = "0")
# read data with effectiveness 0.5 and rbind
data.4 <- read.table(file = full_path_eff_0.4,
                     sep = ",") %>%
  mutate(effectiveness = "40") %>%
  rbind(data.0, .)
# read data with effectiveness 0.5 and rbind
data.5 <- read.table(file = full_path_eff_0.5,
                     sep = ",") %>%
  mutate(effectiveness = "50") %>%
  rbind(data.4, .)
# read data with effectiveness 0.6 and rbind
data.6 <- read.table(file = full_path_eff_0.6,
                     sep = ",") %>%
  mutate(effectiveness = "60") %>%
  rbind(data.5, .)
# read data with effectiveness 0.7 and rbind
data.7 <- read.table(file = full_path_eff_0.7,
                     sep = ",") %>%
  mutate(effectiveness = "70") %>%
  rbind(data.6, .)
# read data with effectiveness 0.8 and rbind
data.8 <- read.table(file = full_path_eff_0.8,
                     sep = ",") %>%
  mutate(effectiveness = "80") %>%
  rbind(data.7, .)
# read data with effectiveness 0.9 and rbind
data.9 <- read.table(file = full_path_eff_0.9,
                     sep = ",") %>%
  mutate(effectiveness = "90") %>%
  rbind(data.8, .)
# read data with effectiveness 1.0 and rbind
full_data <- read.table(file = full_path_eff_1.0,
                        sep = ",") %>%
  mutate(effectiveness = "100") %>%
  rbind(data.9, .)

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
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 5,
               geom = "crossbar",
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
  scale_color_discrete(breaks=c("0","40","50", "60",
                                "70","80","90","100")) +
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))



# Supplemental Figure 9
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_comp_0.0 <- paste0(input_path, "vaccine_efficacy_0.0.csv")
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.5 <- paste0(input_path, "vaccine_efficacy_0.5.csv")
full_path_comp_0.6 <- paste0(input_path, "vaccine_efficacy_0.6.csv")
full_path_comp_0.7 <- paste0(input_path, "vaccine_efficacy_0.7.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")
full_path_comp_0.9 <- paste0(input_path, "vaccine_efficacy_0.9.csv")
full_path_comp_1.0 <- paste0(input_path, "vaccine_efficacy_1.0.csv")

# read data with compliance 0.0
data0 <- read.table(file = full_path_comp_0.0,
                    sep = ",") %>%
  mutate(compliance = "0")
# read data with compliance 0.4 and rbind
data4 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "40") %>%
  rbind(data0, .)
# read data with compliance 0.5 and rbind
data5 <- read.table(file = full_path_comp_0.5,
                    sep = ",") %>%
  mutate(compliance = "50") %>%
  rbind(data4, .)
# read data with compliance 0.6 and rbind
data6 <- read.table(file = full_path_comp_0.6,
                    sep = ",") %>%
  mutate(compliance = "60") %>%
  rbind(data5, .)
# read data with compliance 0.7 and rbind
data7 <- read.table(file = full_path_comp_0.7,
                    sep = ",") %>%
  mutate(compliance = "70") %>%
  rbind(data6, .)
# read data with compliance 0.8 and rbind
data8 <- read.table(file = full_path_comp_0.8,
                    sep = ",") %>%
  mutate(compliance = "80") %>%
  rbind(data7, .)
# read data with compliance 0.9 and rbind
data9 <- read.table(file = full_path_comp_0.9,
                    sep = ",") %>%
  mutate(compliance = "90") %>%
  rbind(data8, .)
# read data with compliance 1.0 and rbind
full_data <- read.table(file = full_path_comp_1.0,
                        sep = ",") %>%
  mutate(compliance = "100") %>%
  rbind(data9, .)

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
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.4,
               width = 5,
               geom = "line",
               aes(color = compliance)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Percent Infected",
       color = "Compliance (%)") + 
  theme_light() + 
  scale_color_discrete(breaks=c("0","40","50", "60",
                                "70","80","90","100")) + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 20),
                     breaks = seq(0, 20, 5)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))



# Supplemental Figure 10
# define paths
input_path <- "/Users/sirikonanoor/Documents/polygence_covid19/csvfiles/"
full_path_comp_0.0 <- paste0(input_path, "vaccine_efficacy_0.0.csv")
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.5 <- paste0(input_path, "vaccine_efficacy_0.5.csv")
full_path_comp_0.6 <- paste0(input_path, "vaccine_efficacy_0.6.csv")
full_path_comp_0.7 <- paste0(input_path, "vaccine_efficacy_0.7.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")
full_path_comp_0.9 <- paste0(input_path, "vaccine_efficacy_0.9.csv")
full_path_comp_1.0 <- paste0(input_path, "vaccine_efficacy_1.0.csv")

# read data with compliance 0.0
data0 <- read.table(file = full_path_comp_0.0,
                    sep = ",") %>%
  mutate(compliance = "0")
# read data with compliance 0.4 and rbind
data4 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "40") %>%
  rbind(data0, .)
# read data with compliance 0.5 and rbind
data5 <- read.table(file = full_path_comp_0.5,
                    sep = ",") %>%
  mutate(compliance = "50") %>%
  rbind(data4, .)
# read data with compliance 0.6 and rbind
data6 <- read.table(file = full_path_comp_0.6,
                    sep = ",") %>%
  mutate(compliance = "60") %>%
  rbind(data5, .)
# read data with compliance 0.7 and rbind
data7 <- read.table(file = full_path_comp_0.7,
                    sep = ",") %>%
  mutate(compliance = "70") %>%
  rbind(data6, .)
# read data with compliance 0.8 and rbind
data8 <- read.table(file = full_path_comp_0.8,
                    sep = ",") %>%
  mutate(compliance = "80") %>%
  rbind(data7, .)
# read data with compliance 0.9 and rbind
data9 <- read.table(file = full_path_comp_0.9,
                    sep = ",") %>%
  mutate(compliance = "90") %>%
  rbind(data8, .)
# read data with compliance 1.0 and rbind
full_data <- read.table(file = full_path_comp_1.0,
                        sep = ",") %>%
  mutate(compliance = "100") %>%
  rbind(data9, .)

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
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.4,
               width = 5,
               geom = "line",
               aes(color = compliance)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Reff",
       color = "Compliance (%)") + 
  theme_light() + 
  scale_color_discrete(breaks=c("0","40","50", "60",
                                "70","80","90","100")) +  
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-5, 105),
                     breaks = seq(0, 105, 20))



# Supplemental Figure 11
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
  filter(person %in% c(12, 30, 18, 16, 27, 4)) %>%
  ggplot(aes(x = step,
             y = infected,
             colour = person,
             group = person)) +
  geom_line(lwd = 0.5) +
  theme_light() +
  labs(x = "Simulation Step (days)",
       y = "Cumulative Number of Infected People")
