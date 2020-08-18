library(dplyr)
library(ggplot2)

# code to graph multiple vaccine efficacies
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.5.csv",
                   sep = ",")
colnames(data1) <- c("Effectivity/Compliance_Rate", "Percent_of_Infected_People")


data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance.csv",
                   sep = ",")
colnames(data2) <- c("Effectivity/Compliance_Rate", "Percent_of_Infected_People")

data <- left.join(data1, data2, by='Effectivity/Compliance_Rate')

data %>%
  ggplot(aes(x = Vaccine_Efficacy,
             y = Percent_of_Infected_People)) +
  geom_line(size = 1) +
  ylim(c(0, 100)) +
  xlim(c(0, 1.0))













# graph most basic (look at first demo slide on ppt)
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/fig1b_infonly.csv",
                   sep = ",")
colnames(data1) <- c("Simulation_Step_Num", "pct_inf_people1")


data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/basic_sim_data2.csv",
                   sep = ",")
colnames(data2) <- c("Simulation_Step_Num", "pct_inf_people2")
#
# data3 <- read.table("/Users/sirikonanoor/Documents/Polygence/basic_sim_data3.csv",
#                     sep = ",")
# colnames(data3) <- c("Simulation_Step_Num", "pct_inf_people3")

data <- left_join(data1, data2, by='Simulation_Step_Num')
# data <- left_join(data3, data, by='Simulation_Step_Num')

colors <- c("#1) Crit Dist = 0.1\n10% Infected\n" = "red",
            "#2) Same Params as #1,\n30% Vaccinated,\n100% Vaccine Efficacy\n" = "blue",
            "#3) Same Params as #2,\nVarying Susceptibility" = "green")


data %>%
  ggplot(aes(x = Simulation_Step_Num)) +
    # first line
    geom_line(aes(y = pct_inf_people1,
                  color = "#1) Crit Dist = 0.1\n10% Infected\n"),
                  size = 1) +
    # second line
    geom_line(aes(y = pct_inf_people2,
                  color = "#2) Same Params as #1,\n30% Vaccinated,\n100% Vaccine Efficacy\n"),
                  size = 1) +
    # # third line
    # geom_line(aes(y = pct_inf_people3,
    #               color = "#3) Same Params as #2,\nVarying Susceptibility"),
    #               size = 1) +
    labs(x = "Simulation Step #",
         y = "Percent of Infected People",
         color = "Legend") +
    scale_color_manual(values = colors) +
    theme(legend.position = (c(0.7, 0.8))) +
    ylim(c(0 , 100)) +
    xlim(c(0, 100))
  








# code to graph multiple vaccine compliance
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance.csv",
                   sep = ",")

colnames(data) <- c("Vaccine_Compliance_Rate", "Percent_of_Infected_People")

data %>%
  ggplot(aes(x = Vaccine_Compliance_Rate,
             y = Percent_of_Infected_People,
             group = Vaccine_Compliance_Rate)) +
  geom_point() +
  geom_boxplot() + 
  labs(x = "Vaccine Compliance Rate",
       y = "Percent of Infected People",
       color = "Legend") +
  ylim(c(0, 100)) +
  xlim(c(0, 1.0))








# code to graph multiple vaccine efficacy
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy.csv",
                   sep = ",")

colnames(data) <- c("Vaccine_Efficacy_Rate", "Percent_of_Infected_People")

data %>%
  ggplot(aes(x = Vaccine_Efficacy_Rate,
             y = Percent_of_Infected_People,
             group = Vaccine_Efficacy_Rate)) +
  geom_point() +
  geom_boxplot() + 
  labs(x = "Vaccine Efficacy Rate",
       y = "Percent of Infected People",
       color = "black") + 
  geom_line(size = 1) +
  ylim(c(0, 100)) +
  xlim(c(0, 1.0))








# graph most basic (look at first demo slide on ppt)
data <- read.table("/Users/sirikonanoor/Documents/Polygence/flu_comparison1.csv",
                   sep = ",")

colnames(data) <- c("Simulation_Step_Num", "Percent_of_Infected_People")

data %>%
  ggplot(aes(x = Simulation_Step_Num,
             y = Percent_of_Infected_People)) +
  geom_line(size = 1, colour = "red") +
  ylim(c(0, 100)) +
  xlim(c(0, 100))
