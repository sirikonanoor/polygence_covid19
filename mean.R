library(plyr)
library(dplyr)
library(ggplot2)


# ATTEMPT 1
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
  ggplot(data, mapping = aes(data$vacc_eff, data$protec_eff2)) + 
  geom_point(size=1) + 
  stat_summary(fun.y = mean, fun.ymin = mean, fun.ymax = mean, geom = "crossbar", color = "blue", size = 0.3) + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))




# ATTEMPT 2

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
  ggplot(data, mapping = aes(x = vacc_eff, group = vacc_eff)) + 
  stat_summary(geom = "crossbar", mapping = aes(y = protec_eff1), 
               fun = "mean",  size = 0.5) +
  stat_summary(geom = "crossbar", mapping = aes(y = protec_eff2), 
               fun = "mean",  size = 0.5, color = "blue") +
  labs(x = "Vaccine Compliance (%)",
       y = "Percent of Infected People",
       color = "Legend") + 
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3)))  + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))

