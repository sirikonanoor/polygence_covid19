# This file contains all the figures in the Results section

library(dplyr)
library(ggplot2)

### FIGURE 1:


# Figure 1.a)
data <- read.table("/Users/sirikonanoor/Documents/Polygence/fig.1a.csv",
                   sep = ",")

colnames(data) <- c("sim_step", "pct_inf")

data %>%
  ggplot(aes(x = sim_step,
             y = pct_inf)) +
  geom_line(size = 1, colour = "red") +
  labs(x = "Simulation Step # (days)",
       y = "Percent of Infected People",
       color = "Legend") +
  theme_light() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))


# Figure 1.b)
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/fig.1b_infonly.csv",
                    sep = ",")
colnames(data1) <- c("sim_step", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/fig.1b_vacc.csv",
                    sep = ",")
colnames(data2) <- c("sim_step", "pct_inf2")

data <- left_join(data1, data2, by='sim_step')

colors <- c("Infection with no Vaccination\n" = "red",
            "Infection with 10% Compliance" = "blue")


data %>%
  ggplot(aes(x = sim_step)) +
  # first line
  geom_line(aes(y = pct_inf1,
                color = "Infection with no Vaccination\n"),
            size = 1) +
  # second line
  geom_line(aes(y = pct_inf2,
                color = "Infection with 10% Compliance"),
            size = 1) +
  labs(x = "Simulation Step # (days)",
       y = "Percent of Infected People",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme_light() + 
  theme(legend.position = (c(0.8, 0.4))) +
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))


# Figure 1.c)
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/fig.1c_infonly.csv",
                    sep = ",")
colnames(data1) <- c("sim_step", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/fig.1c_vacc.csv",
                    sep = ",")
colnames(data2) <- c("sim_step", "pct_inf2")

data <- left_join(data1, data2, by='sim_step')

colors <- c("Infection with no Vaccination\n" = "red",
            "Infection with 10% Compliance" = "blue")


data %>%
  ggplot(aes(x = sim_step)) +
  # first line
  geom_line(aes(y = pct_inf1,
                color = "Infection with no Vaccination\n"),
            size = 1) +
  # second line
  geom_line(aes(y = pct_inf2,
                color = "Infection with 10% Compliance"),
            size = 1) +
  labs(x = "Simulation Step # (days)",
       y = "Percent of Infected People",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme_light() + 
  theme(legend.position = (c(0.75, 0.3)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))


### FIGURE 2:

# Figure 2.a)

# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.5 <- paste0(input_path, "vaccine_efficacy_0.5.csv")

# read data with compliance 0.5
data <- read.table(file = full_path_comp_0.5,
                    sep = ",") %>%
  mutate(compliance = "0.5")

# name columns
colnames(data) <- c("vaccine_effectiveness",
                    "percent_infected",
                    "protection",
                    "reff",
                    "compliance")

# plot!
data %>%
  ggplot(aes(x = vaccine_effectiveness,
             y = percent_infected,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Percent Infected") + 
  theme_light() + 
  theme(legend.position = c(1.5, 1.5)) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


# Figure 1. b)

# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.5 <- paste0(input_path, "vaccine_efficacy_0.5.csv")

# read data with compliance 0.5
data <- read.table(file = full_path_comp_0.5,
                   sep = ",") %>%
  mutate(compliance = "0.5")

# name columns
colnames(data) <- c("vaccine_effectiveness",
                    "percent_infected",
                    "protection",
                    "reff",
                    "compliance")

# plot!
data %>%
  ggplot(aes(x = vaccine_effectiveness,
             y = protection,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Protective Effect (%)") + 
  theme_light() + 
  theme(legend.position = c(1.5, 1.5)) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))

# Figure 1. c)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.5 <- paste0(input_path, "vaccine_efficacy_0.5.csv")

# read data with compliance 0.5
data <- read.table(file = full_path_comp_0.5,
                   sep = ",") %>%
  mutate(compliance = "0.5")

# name columns
colnames(data) <- c("vaccine_effectiveness",
                    "percent_infected",
                    "protection",
                    "reff",
                    "compliance")

# plot!
data %>%
  ggplot(aes(x = vaccine_effectiveness,
             y = reff,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Reff") + 
  theme_light() + 
  theme(legend.position = c(1.5, 1.5)) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


# Figure 1.d)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csv files"
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")

# read data with compliance 0.4
datathingy <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "0.4")

# data_thing <- read.table("/Users/sirikonanoor/Documents/Polygence/csv files/vaccine_efficacy_0.8.csv",
#                          sep = ",")%>%
#   mutate(compliance = "0.8")

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "0.8") %>%
  rbind(datathingy, .)

# name columns
colnames(full_data) <- c("vacc_lolol",
                         "percent_infected",
                         "protection",
                         "reff",
                         "compliance")

# plot!
full_data %>%
  ggplot(aes(x = vacc_lolol,
             y = percent_infected,
             group = compliance)) + 
  geom_point(aes(colour = compliance),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Percent Infected") + 
  theme_light() + 
  theme(legend.position = c(0.8, 0.5)) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))