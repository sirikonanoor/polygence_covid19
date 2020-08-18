# This file contains all the figures in the Results section

library(dplyr)
library(ggplot2)

### FIGURE 1:


# Figure 1. a)
data <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1a.csv",
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


# Figure 1. b)
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1b_infonly.csv",
                    sep = ",")
colnames(data1) <- c("sim_step", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1b_vacc.csv",
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



# Figure 1. c)
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1c_infonly.csv",
                    sep = ",")
colnames(data1) <- c("sim_step", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1c_vacc.csv",
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

# Figure 2. a)

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


# Figure 2. b)

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

# Figure 2. c)
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


# Figure 2. d)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")

# read data with compliance 0.4
data1 <- read.table(file = full_path_comp_0.4,
                         sep = ",") %>%
  mutate(compliance = "0.4")

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "0.8") %>%
  rbind(data1, .)

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
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Percent Infected") + 
  theme_light() + 
  theme(legend.position = c(0.3, 0.4),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


# Figure 2. e)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")

# read data with compliance 0.4
data1 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "0.4")

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "0.8") %>%
  rbind(data1, .)

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
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Protective Effect (%)") + 
  theme_light() + 
  theme(legend.position = c(0.3, 0.6),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))



# Figure 2. f)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_comp_0.4 <- paste0(input_path, "vaccine_efficacy_0.4.csv")
full_path_comp_0.8 <- paste0(input_path, "vaccine_efficacy_0.8.csv")

# read data with compliance 0.4
data1 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "0.4")

# read data with compliance 0.8 and rbind
full_data <- read.table(file = full_path_comp_0.8,
                        sep = ",") %>%
  mutate(compliance = "0.8") %>%
  rbind(data1, .)

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
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Reff") + 
  theme_light() + 
  theme(legend.position = c(0.3, 0.3),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))





###FIGURE 3


# Figure 3.a)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")

# read data with effectiveness 0.5
data <- read.table(file = full_path_eff_0.5,
                   sep = ",") %>%
  mutate(effectiveness = "0.5")

# name columns
colnames(data) <- c("vaccine_compliance",
                    "percent_infected",
                    "protection",
                    "reff",
                    "effectiveness")

# plot!
data %>%
  ggplot(aes(x = vaccine_compliance,
             y = percent_infected,
             group = effectiveness)) + 
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Percent Infected") + 
  theme_light() + 
  theme(legend.position = c(1.5, 1.5)) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))

# Figure 3.b)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")

# read data with effectiveness 0.5
data <- read.table(file = full_path_eff_0.5,
                   sep = ",") %>%
  mutate(effectiveness = "0.5")

# name columns
colnames(data) <- c("vaccine_compliance",
                    "percent_infected",
                    "protection",
                    "reff",
                    "effectiveness")

# plot!
data %>%
  ggplot(aes(x = vaccine_compliance,
             y = protection,
             group = effectiveness)) + 
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Protective Effect (%)") + 
  theme_light() + 
  theme(legend.position = c(1.5, 1.5)) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


# Figure 3.c)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")

# read data with effectiveness 0.5
data <- read.table(file = full_path_eff_0.5,
                   sep = ",") %>%
  mutate(effectiveness = "0.5")

# name columns
colnames(data) <- c("vaccine_compliance",
                    "percent_infected",
                    "protection",
                    "reff",
                    "effectiveness")

# plot!
data %>%
  ggplot(aes(x = vaccine_compliance,
             y = reff,
             group = effectiveness)) + 
  geom_point(aes(colour = effectiveness),
             size = 0.5) +
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Reff") + 
  theme_light() + 
  theme(legend.position = c(1.5, 1.5)) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


# Figure 3. d)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")

# read data with effectiveness 0.4
data1 <- read.table(file = full_path_eff_0.4,
                    sep = ",") %>%
  mutate(effectiveness = "0.4")

# read data with effectiveness 0.8 and rbind
full_data <- read.table(file = full_path_eff_0.8,
                        sep = ",") %>%
  mutate(effectiveness = "0.8") %>%
  rbind(data1, .)

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
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Percent Infected") + 
  theme_light() + 
  theme(legend.position = c(0.25, 0.3),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))

# Figure 3. e)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")

# read data with effectiveness 0.4
data1 <- read.table(file = full_path_eff_0.4,
                    sep = ",") %>%
  mutate(effectiveness = "0.4")

# read data with effectiveness 0.8 and rbind
full_data <- read.table(file = full_path_eff_0.8,
                        sep = ",") %>%
  mutate(effectiveness = "0.8") %>%
  rbind(data1, .)

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
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Protective Effect (%)") + 
  theme_light() + 
  theme(legend.position = c(0.3, 0.7),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


# Figure 3. f)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.4 <- paste0(input_path, "vaccine_compliance_0.4.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")

# read data with effectiveness 0.4
data1 <- read.table(file = full_path_eff_0.4,
                    sep = ",") %>%
  mutate(effectiveness = "0.4")

# read data with effectiveness 0.8 and rbind
full_data <- read.table(file = full_path_eff_0.8,
                        sep = ",") %>%
  mutate(effectiveness = "0.8") %>%
  rbind(data1, .)

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
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Reff") + 
  theme_light() + 
  theme(legend.position = c(0.8, 0.75),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))


### FIGURE 4


# Figure 4. a)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
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
  mutate(compliance = "0.0")
# read data with compliance 0.4 and rbind
data4 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "0.4") %>%
  rbind(data0, .)
# read data with compliance 0.5 and rbind
data5 <- read.table(file = full_path_comp_0.5,
                    sep = ",") %>%
  mutate(compliance = "0.5") %>%
  rbind(data4, .)
# read data with compliance 0.6 and rbind
data6 <- read.table(file = full_path_comp_0.6,
                    sep = ",") %>%
  mutate(compliance = "0.6") %>%
  rbind(data5, .)
# read data with compliance 0.7 and rbind
data7 <- read.table(file = full_path_comp_0.7,
                    sep = ",") %>%
  mutate(compliance = "0.7") %>%
  rbind(data6, .)
# read data with compliance 0.8 and rbind
data8 <- read.table(file = full_path_comp_0.8,
                    sep = ",") %>%
  mutate(compliance = "0.8") %>%
  rbind(data7, .)
# read data with compliance 0.9 and rbind
data9 <- read.table(file = full_path_comp_0.9,
                    sep = ",") %>%
  mutate(compliance = "0.9") %>%
  rbind(data8, .)
# read data with compliance 1.0 and rbind
full_data <- read.table(file = full_path_comp_1.0,
                    sep = ",") %>%
  mutate(compliance = "1.0") %>%
  rbind(data9, .)

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
  geom_line(size = 0.15,
            aes(color = compliance)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Protective Effect (%)") + 
  theme_light() + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))




# Figure 4. b)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
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
  mutate(compliance = "0.0")
# read data with compliance 0.4 and rbind
data4 <- read.table(file = full_path_comp_0.4,
                    sep = ",") %>%
  mutate(compliance = "0.4") %>%
  rbind(data0, .)
# read data with compliance 0.5 and rbind
data5 <- read.table(file = full_path_comp_0.5,
                    sep = ",") %>%
  mutate(compliance = "0.5") %>%
  rbind(data4, .)
# read data with compliance 0.6 and rbind
data6 <- read.table(file = full_path_comp_0.6,
                    sep = ",") %>%
  mutate(compliance = "0.6") %>%
  rbind(data5, .)
# read data with compliance 0.7 and rbind
data7 <- read.table(file = full_path_comp_0.7,
                    sep = ",") %>%
  mutate(compliance = "0.7") %>%
  rbind(data6, .)
# read data with compliance 0.8 and rbind
data8 <- read.table(file = full_path_comp_0.8,
                    sep = ",") %>%
  mutate(compliance = "0.8") %>%
  rbind(data7, .)
# read data with compliance 0.9 and rbind
data9 <- read.table(file = full_path_comp_0.9,
                    sep = ",") %>%
  mutate(compliance = "0.9") %>%
  rbind(data8, .)
# read data with compliance 1.0 and rbind
full_data <- read.table(file = full_path_comp_1.0,
                        sep = ",") %>%
  mutate(compliance = "1.0") %>%
  rbind(data9, .)

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
  geom_line(size = 0.15,
            aes(color = compliance)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Effectiveness",
       y = "Reff") + 
  theme_light() + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))



# Figure 4. c)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")
full_path_eff_0.6 <- paste0(input_path, "vaccine_compliance_0.6.csv")
full_path_eff_0.7 <- paste0(input_path, "vaccine_compliance_0.7.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")
full_path_eff_0.9 <- paste0(input_path, "vaccine_compliance_0.9.csv")
full_path_eff_1.0 <- paste0(input_path, "vaccine_compliance_1.0.csv")

# read data with effectiveness 0.0
data.0 <- read.table(file = full_path_eff_0.0,
                    sep = ",") %>%
  mutate(effectiveness = "0.0")
# read data with effectiveness 0.5 and rbind
data.5 <- read.table(file = full_path_eff_0.5,
                    sep = ",") %>%
  mutate(effectiveness = "0.5") %>%
  rbind(data.0, .)
# read data with effectiveness 0.6 and rbind
data.6 <- read.table(file = full_path_eff_0.6,
                    sep = ",") %>%
  mutate(effectiveness = "0.6") %>%
  rbind(data.5, .)
# read data with effectiveness 0.7 and rbind
data.7 <- read.table(file = full_path_eff_0.7,
                    sep = ",") %>%
  mutate(effectiveness = "0.7") %>%
  rbind(data.6, .)
# read data with effectiveness 0.8 and rbind
data.8 <- read.table(file = full_path_eff_0.8,
                    sep = ",") %>%
  mutate(effectiveness = "0.8") %>%
  rbind(data.7, .)
# read data with effectiveness 0.9 and rbind
data.9 <- read.table(file = full_path_eff_0.9,
                    sep = ",") %>%
  mutate(effectiveness = "0.9") %>%
  rbind(data.8, .)
# read data with effectiveness 1.0 and rbind
full_data <- read.table(file = full_path_eff_1.0,
                        sep = ",") %>%
  mutate(effectiveness = "1.0") %>%
  rbind(data.9, .)

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
  geom_line(size = 0.15,
            aes(color = effectiveness)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Protective Effect (%)") + 
  theme_light() + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 100),
                     breaks = seq(0, 100, 10)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))



# Figure 4. d)
# define paths
input_path <- "/Users/sirikonanoor/Documents/Polygence/csvfiles/"
full_path_eff_0.0 <- paste0(input_path, "vaccine_compliance_0.0.csv")
full_path_eff_0.5 <- paste0(input_path, "vaccine_compliance_0.5.csv")
full_path_eff_0.6 <- paste0(input_path, "vaccine_compliance_0.6.csv")
full_path_eff_0.7 <- paste0(input_path, "vaccine_compliance_0.7.csv")
full_path_eff_0.8 <- paste0(input_path, "vaccine_compliance_0.8.csv")
full_path_eff_0.9 <- paste0(input_path, "vaccine_compliance_0.9.csv")
full_path_eff_1.0 <- paste0(input_path, "vaccine_compliance_1.0.csv")

# read data with effectiveness 0.0
data.0 <- read.table(file = full_path_eff_0.0,
                     sep = ",") %>%
  mutate(effectiveness = "0.0")
# read data with effectiveness 0.5 and rbind
data.5 <- read.table(file = full_path_eff_0.5,
                     sep = ",") %>%
  mutate(effectiveness = "0.5") %>%
  rbind(data.0, .)
# read data with effectiveness 0.6 and rbind
data.6 <- read.table(file = full_path_eff_0.6,
                     sep = ",") %>%
  mutate(effectiveness = "0.6") %>%
  rbind(data.5, .)
# read data with effectiveness 0.7 and rbind
data.7 <- read.table(file = full_path_eff_0.7,
                     sep = ",") %>%
  mutate(effectiveness = "0.7") %>%
  rbind(data.6, .)
# read data with effectiveness 0.8 and rbind
data.8 <- read.table(file = full_path_eff_0.8,
                     sep = ",") %>%
  mutate(effectiveness = "0.8") %>%
  rbind(data.7, .)
# read data with effectiveness 0.9 and rbind
data.9 <- read.table(file = full_path_eff_0.9,
                     sep = ",") %>%
  mutate(effectiveness = "0.9") %>%
  rbind(data.8, .)
# read data with effectiveness 1.0 and rbind
full_data <- read.table(file = full_path_eff_1.0,
                        sep = ",") %>%
  mutate(effectiveness = "1.0") %>%
  rbind(data.9, .)

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
  geom_line(size = 0.15,
            aes(color = effectiveness)) + 
  stat_summary(fun.y = "mean",
               fun.ymin = "mean",
               fun.ymax= "mean",
               size = 0.1,
               width = 0.05,
               geom = "crossbar") +
  labs(x = "Vaccine Compliance",
       y = "Reff") + 
  theme_light() + 
  theme(legend.justification = c("right"),
        legend.background = element_rect(fill = "lightgray")) + 
  scale_y_continuous(limits = c(0, 0.1),
                     breaks = seq(0, 0.1, 0.01)) +
  scale_x_continuous(limits = c(-0.1, 1.1),
                     breaks = seq(0, 1.0, 0.2))