library(dplyr)
library(ggplot2)


# (1)
# CODE TO GRAPH MULTIPLE VACCINE EFFICACIES
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.8.csv",
                   sep = ",")

colnames(data) <- c("Vaccine_Effectiveness_Rate", "Percent_of_Infected_People")

data %>%
  ggplot(aes(x = Vaccine_Effectiveness_Rate,
             y = Percent_of_Infected_People,
             group = Vaccine_Effectiveness_Rate)) +
  labs(x = "Vaccine Effectiveness Rate",
       y = "Percent of Infected People") + 
  geom_point(size = 1) +
  geom_boxplot() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))





# (2)
# CODE TO GRAPH MULTIPLE VACCINE COMPLIANCE
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance.csv",
                   sep = ",")

colnames(data) <- c("Vaccine_Compliance_Rate", "Percent_of_Infected_People")

data %>%
  ggplot(aes(x = Vaccine_Compliance_Rate,
             y = Percent_of_Infected_People,
             group = Vaccine_Compliance_Rate)) +
  labs(x = "Vaccine Compliance Rate",
       y = "Percent of Infected People") + 
  geom_point(size = 1) +
  geom_boxplot() + 
  ylim(c(0, 100)) +
  xlim(c(0, 1.0))






# (3)
# CODE TO GRAPH VACCINE EFFICACY WITH 0.4 AND 0.8 COMPLIANCE
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.4.csv",
                   sep = ",")
colnames(data1) <- c("Vaccine_Effectiveness_Rate", "Percent_of_Infected_People1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.8.csv",
                    sep = ",")
colnames(data2) <- c("Vaccine_Effectiveness_Rate", "Percent_of_Infected_People2")

data <- left_join(data1, data2, by='Vaccine_Effectiveness_Rate')

colors <- c("vaccine compliance = 0.4\n" = "red",
            "vaccine compliance = 0.8\n" = "blue")

data %>%
  ggplot(aes(x = Vaccine_Effectiveness_Rate,
             group = Vaccine_Effectiveness_Rate)) +
        # FIRST LINE
        geom_boxplot(aes(y = Percent_of_Infected_People1,
                  color = "vaccine compliance = 0.4\n"),
                  size = 0.5) +
        # second line
        geom_boxplot(aes(y = Percent_of_Infected_People2,
                  color = "vaccine compliance = 0.8\n"),
                  size = 0.5) +
        labs(x = "Vaccine Effectiveness Rate",
             y = "Percent of Infected People",
             color = "Legend") +
        scale_color_manual(values = colors) +
        theme(legend.position = (c(0.3, 0.3))) +
        ylim(c(0 , 100)) +
        xlim(c(0, 1.0))
           

# (4)
# CODE TO GRAPH VACCINE EFFICACY WITH 0.4 AND 0.8 EFFECTIVENESS
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.4.csv",
                    sep = ",")
colnames(data1) <- c("Vaccine_Compliance_Rate", "Percent_of_Infected_People1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.8.csv",
                    sep = ",")
colnames(data2) <- c("Vaccine_Compliance_Rate", "Percent_of_Infected_People2")

data <- left_join(data1, data2, by='Vaccine_Compliance_Rate')

colors <- c("vaccine effectiveness = 0.4\n" = "red",
            "vaccine effectiveness = 0.8\n" = "blue")

data %>%
  ggplot(aes(x = Vaccine_Compliance_Rate,
             group = Vaccine_Compliance_Rate)) +
  # FIRST LINE
  geom_boxplot(aes(y = Percent_of_Infected_People1,
                   color = "vaccine effectiveness = 0.4\n"),
               size = 0.5) +
  # second line
  geom_boxplot(aes(y = Percent_of_Infected_People2,
                   color = "vaccine effectiveness = 0.8\n"),
               size = 0.5) +
  labs(x = "Vaccine Compliance Rate",
       y = "Percent of Infected People",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3))) +
  ylim(c(0 , 100)) +
  xlim(c(0, 1.0))


           
           