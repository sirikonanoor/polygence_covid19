library(plyr)
library(dplyr)
library(ggplot2)

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
  # geom_point(mapping = aes(y = protec_eff1, 
  #                   color = "vaccine effectiveness = 0.4\n"),
  #               size=1) + 
  # # stat_summary(fun.y = mean, fun.ymin = mean, fun.ymax = mean, 
  # #                     geom = "crossbar", 
  # #                     color = "vaccine effectiveness = 0.4\n", 
  # #                     size = 0.3) + 
  # geom_point()
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


  # labs(x = "Vaccine Compliance (%)",
  #      y = "Percent of Infected People",
  #      color = "Legend") +
  # scale_color_manual(values = colors) +
  # theme(legend.position = (c(0.3, 0.3)))  + 
  # scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  # scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))

  
  
  
  
  
  
  
  
  
  

data1 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.4.csv",
                    sep = ",")
colnames(data1) <- c("vacc_eff", "pct_inf1", "protec_eff1")

data2 <- read.table("/Users/sirikonanoor/Documents/Polygence/vaccine_compliance_0.8.csv",
                    sep = ",")
colnames(data2) <- c("vacc_eff", "pct_inf2", "protec_eff2")

data <- left_join(data1, data2, by='vacc_eff')

colors <- c("vaccine effectiveness = 0.4\n" = "red",
            "vaccine effectiveness = 0.8\n" = "blue")
labels <- c("vacc_eff")

data %>%
  ggplot(data, mapping = aes(x = vacc_eff, group = vacc_eff)) + 
  geom_jitter(width=0.2) +
  geom_crossbar(data=data, mapping = aes(y = protec_eff1, ymin = protec_eff1, ymax = protec_eff1),
                size=1,color="red", width = .5) + 
  labs(x = "Vaccine Compliance (%)",
       y = "Percent of Infected People",
       color = "Legend") + 
  scale_color_manual(values = colors) +
  theme(legend.position = (c(0.3, 0.3)))  + 
  scale_y_continuous(limits = c(0, 100), breaks=seq(0, 100, 10)) +
  scale_x_continuous(limits = c(0, 1.0), breaks=seq(0, 1.0, 0.1))

