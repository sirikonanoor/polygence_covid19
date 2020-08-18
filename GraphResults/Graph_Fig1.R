# This file contains all the figures in Fig. 1 in Results section

library(dplyr)
library(ggplot2)

### FIGURE 1:


# Figure 1. a)
# data <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1a.csv",
#                    sep = ",")
data <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/test.csv",
                   sep = ",")
colnames(data) <- c("sim_step", "pct_inf")

data %>%
  ggplot(aes(x = sim_step,
             y = pct_inf)) +
  geom_line(size = 1, colour = "red") +
  labs(x = "Simulation Step # (days)",
       y = "Percent Infected",
       color = "Legend") +
  theme_light() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))



# Figure 1. b)
data <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1b.csv",
                   sep = ",")

colnames(data) <- c("sim_step", "pct_inf")

data %>%
  ggplot(aes(x = sim_step,
             y = pct_inf)) +
  geom_line(size = 1, colour = "red") +
  labs(x = "Simulation Step # (days)",
       y = "Percent Infected",
       color = "Legend") +
  theme_light() + 
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

colors <- c("0" = "red",
            "10" = "blue")


data %>%
  ggplot(aes(x = sim_step)) +
  # first line
  geom_line(aes(y = pct_inf1,
                color = "0"),
            size = 1) +
  # second line
  geom_line(aes(y = pct_inf2,
                color = "10"),
            size = 1) +
  labs(x = "Simulation Step # (days)",
       y = "Percent Infected",
       color = "Percent Vaccinated") +
  scale_color_manual(values = colors) +
  theme_light()  + 
  theme(legend.position = (c(0.7, 0.5)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))


# Figure 1. d)
data <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1d.csv",
                   sep = ",")

colnames(data) <- c("sim_step", "pct_inf")

data %>%
  ggplot(aes(x = sim_step,
             y = pct_inf)) +
  geom_line(size = 1, colour = "red") +
  labs(x = "Simulation Step # (days)",
       y = "Percent Infected",
       color = "Legend") +
  theme_light() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))



# Figure 1. e)
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1e_infonly.csv",
                    sep = ",")
colnames(data1) <- c("sim_step", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/csvfiles/fig.1e_vacc.csv",
                    sep = ",")
colnames(data2) <- c("sim_step", "pct_inf2")

data <- left_join(data1, data2, by='sim_step')

colors <- c("0" = "red",
            "10" = "blue")


data %>%
  ggplot(aes(x = sim_step)) +
  # first line
  geom_line(aes(y = pct_inf1,
                color = "0"),
            size = 1) +
  # second line
  geom_line(aes(y = pct_inf2,
                color = "10"),
            size = 1) +
  labs(x = "Simulation Step # (days)",
       y = "Percent Infected",
       color = "Percent Vaccinated") +
  scale_color_manual(values = colors) +
  theme_light() + 
  theme(legend.position = (c(0.7, 0.5)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))

