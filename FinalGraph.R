library(dplyr)
library(ggplot2)
library(reshape)

reff_data <- read.table("/Users/sirikonanoor/Documents/Polygence/reff_.csv",
                       sep = ",")
# rename columns
colnames(reff_data) <- 1:2000
head(reff_data)
# reshape dataframe to have only one value column

# Transpose everything other than the first column
reff_data.T <- as.data.frame(as.matrix(t(reff_data)))

# Assign first column as the column names of the transposed dataframe
colnames(reff_data.T) <- 1:2000
colnames(reff_data.T)
head(reff_data.T)
reff_data.T <- melt(reff_data.T)
head(reff_data.T)
# create a x vector from 1 to the number of value for each variable (here 43)
reff_data.T$x <- rep(1:length(reff_data.T$value[reff_data.T$variable==1]))

# Use the dataframe in ggplot
ggplot(data=reff_data.T, aes(x=x, y=value, color=variable)) +
  geom_line() +
  theme(legend.position = (c(10, 10)))






reff_data <- read.table("/Users/sirikonanoor/Documents/Polygence/reff_.csv",
                        sep = ",")
# rename columns
colnames(reff_data) <- 1:2000
# reshape dataframe to have only one value column
reff_data <- melt(reff_data)
# create a x vector from 1 to the number of value for each variable (here 43)
reff_data$x <- rep(1:length(reff_data$value[reff_data$variable==1]))
head(reff_data)
# Use the dataframe in ggplot
reff_data %>%
  ggplot(data=reff_data, mapping = aes(x=x, y=value)) +
    geom_line() +
    theme(legend.position = (c(10, 10)))



  


# (1a) To graph Fig. 1a: with 0.01% of the population infected
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



# (1b) To graph Fig. 1b: with 0.1% of the population infected and 0.1 vaccinated

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
  theme(legend.position = (c(0.75, 0.4)),
        legend.background = element_rect(fill = "lightgray")) +
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 100), breaks=seq(0, 100, 10))


# (1c) To graph Fig. 1c: with 0.1% of the population infected and 0.1 vaccinated AND recovery, 100% suscep

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



# (2a) GRAPH EFFECT OF MULT VACC EFFECTIVENESS WITH VACC COMPLIANCE = 0.5
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.5.csv",
                   sep = ",")

colnames(data) <- c("vacc_eff", "pct_inf")

data %>%
  ggplot(aes(x = vacc_eff,
             y = pct_inf,
             group = vacc_eff)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Percent of Infected People") + 
  geom_point(size = 1) +
  geom_boxplot() + 
  theme_light()
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))


# (2b) GRAPH PROTECTIVE_EFFECT OF 2a
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.5.csv",
                   sep = ",")

colnames(data) <- c("vacc_eff", "pct_inf", "protec_eff")

data %>%
  ggplot(aes(x = vacc_eff,
             y = protec_eff,
             group = vacc_eff)) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Protective Effect (%)") + 
  geom_point(size = 1) +
  geom_boxplot() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))



# CODE TO GRAPH VACCINE EFFICACY WITH 0.4 AND 0.8 COMPLIANCE
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.4.csv",
                    sep = ",")
colnames(data1) <- c("vacc_eff", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.8.csv",
                    sep = ",")
colnames(data2) <- c("vacc_eff", "pct_inf2")

data <- left_join(data1, data2, by='vacc_eff')

colors <- c("vaccine compliance = 0.4\n" = "red",
            "vaccine compliance = 0.8\n" = "blue")

data %>%
  ggplot(aes(x = vacc_eff,
             group = vacc_eff)) +
  # FIRST LINE
  geom_boxplot(aes(y = pct_inf1,
                   color = "vaccine compliance = 0.4\n"),
               size = 0.5) +
  # second line
  geom_boxplot(aes(y = pct_inf2,
                   color = "vaccine compliance = 0.8\n"),
               size = 0.5) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Percent of Infected People",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3)))  + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))




# the PROTECTIVE_EFFECT OF ABOVE
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.4.csv",
                    sep = ",")
colnames(data1) <- c("vacc_eff", "pct_inf1", "protec_eff1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_efficacy_0.8.csv",
                    sep = ",")
colnames(data2) <- c("vacc_eff", "pct_inf2", "protec_eff2")

data <- left_join(data1, data2, by='vacc_eff')

colors <- c("vaccine compliance = 0.4\n" = "red",
            "vaccine compliance = 0.8\n" = "blue")

data %>%
  ggplot(aes(x = vacc_eff,
             group = vacc_eff)) +
  # FIRST LINE
  geom_boxplot(aes(y = protec_eff1,
                   color = "vaccine compliance = 0.4\n"),
               size = 0.5) +
  # second line
  geom_boxplot(aes(y = protec_eff2,
                   color = "vaccine compliance = 0.8\n"),
               size = 0.5) +
  labs(x = "Vaccine Effectiveness (%)",
       y = "Protective Effect (%)",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3)))  + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))

















# Multiple compliances with vaccine eff of 0.5

data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.5.csv",
                   sep = ",")

colnames(data) <- c("vacc_eff", "pct_inf")

data %>%
  ggplot(aes(x = vacc_eff,
             y = pct_inf,
             group = vacc_eff)) +
  labs(x = "Vaccine Complaince (%)",
       y = "Percent of Infected People") + 
  geom_point(size = 1) +
  geom_boxplot() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))


# GRAPH PROTECTIVE_EFFECT OF above
data <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.5.csv",
                   sep = ",")

colnames(data) <- c("vacc_eff", "pct_inf", "protec_eff")

data %>%
  ggplot(aes(x = vacc_eff,
             y = protec_eff,
             group = vacc_eff)) +
  labs(x = "Vaccine Compliance (%)",
       y = "Protective Effect (%)") + 
  geom_point(size = 1) +
  geom_boxplot() + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))


# CODE TO GRAPH VACCINE COMPLIANCE WITH 0.4 AND 0.8 EFFECTIVENESS
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.4.csv",
                    sep = ",")
colnames(data1) <- c("vacc_eff", "pct_inf1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.8.csv",
                    sep = ",")
colnames(data2) <- c("vacc_eff", "pct_inf2")

data <- left_join(data1, data2, by='vacc_eff')

colors <- c("vaccine effectiveness = 0.4\n" = "red",
            "vaccine effectiveness = 0.8\n" = "blue")

data %>%
  ggplot(aes(x = vacc_eff,
             group = vacc_eff)) +
  # FIRST LINE
  geom_boxplot(aes(y = pct_inf1,
                   color = "vaccine effectiveness = 0.4\n"),
               size = 0.5) +
  # second line
  geom_boxplot(aes(y = pct_inf2,
                   color = "vaccine effectiveness = 0.8\n"),
               size = 0.5) +
  labs(x = "Vaccine Compliance (%)",
       y = "Percent of Infected People",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3)))  + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))



# the PROTECTIVE_EFFECT OF ABOVE
data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.4.csv",
                    sep = ",")
colnames(data1) <- c("vacc_eff", "pct_inf1", "protec_eff1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.8.csv",
                    sep = ",")
colnames(data2) <- c("vacc_eff", "pct_inf2", "protec_eff2")

data <- left_join(data1, data2, by='vacc_eff')

colors <- c("vaccine effectiveness = 0.4\n" = "red",
            "vaccine effectiveness = 0.8\n" = "blue")

data %>%
  ggplot(aes(x = vacc_eff,
             group = vacc_eff)) +
  # FIRST LINE
  geom_boxplot(aes(y = protec_eff1,
                   color = "vaccine effectiveness = 0.4\n"),
               size = 0.5) +
  # second line
  geom_boxplot(aes(y = protec_eff2,
                   color = "vaccine effectiveness = 0.8\n"),
               size = 0.5) +
  labs(x = "Vaccine Compliance (%)",
       y = "Percent of Infected People",
       color = "Legend") +
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3)))  + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))

