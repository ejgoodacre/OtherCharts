# Load packages
library(reshape2)
library(ggplot2)

# Define tasks
taskA1 <- c("Part A, Task 1", "2019-08-01", "2020-04-30", "A")
taskB1 <- c("Part B, Task 1", "2019-09-01", "2019-12-08", "B")
taskA2 <- c("Part A, Task 2", "2019-09-25", "2019-10-30", "A")
taskA3 <- c("Part A, Task 3", "2019-11-01", "2020-01-30", "A")
taskB2 <- c("Part B, Task 2", "2020-01-08", "2020-03-30", "B")
taskB3 <- c("Part B, Task 3", "2020-01-15", "2020-04-30", "B")
taskA4 <- c("Part A, Task 4", "2020-02-01", "2020-04-30", "A")
taskA5 <- c("Part A, Task 5", "2020-02-01", "2020-03-07", "A")
taskA6 <- c("Part A, Task 6", "2020-03-08", "2020-05-30", "A")
taskB4 <- c("Part B, Task 4", "2020-05-01", "2020-11-30", "B")
taskA7 <- c("Part A, Task 7", "2020-06-01", "2020-06-30", "A")
taskA8 <- c("Part A, Task 8", "2020-07-01", "2020-07-15", "A")
taskA9 <- c("Part A, Task 9", "2020-07-16", "2020-08-30", "A")
taskA10 <- c("Part A, Task 10", "2020-09-01", "2020-09-30", "A")

# Create dataframe
dfGANTT <- as.data.frame(rbind(taskA1, taskB1, taskA2, taskA3, taskB2, taskB3, taskA4, taskA5, taskA6, taskB4, taskA7, taskA8, taskA9, taskA10))
names(dfGANTT) <- c("task", "start", "end", "part")
dfGANTT$task <- factor(dfGANTT$task, levels = dfGANTT$task)
dfGANTT$start <- as.Date(dfGANTT$start)
dfGANTT$end <- as.Date(dfGANTT$end)
dfGANTT_melted <- melt(dfGANTT, measure.vars = c("start", "end"))

# Create chart
GANTTchart <- ggplot(dfGANTT_melted, aes(value, task, colour=part))
GANTTchart + 
  geom_line(size = 6) +
  labs(x = "Time planned for completion",
       title = "GANTT Chart",
       caption="Created by Emily J. Goodacre") +
  theme(plot.title = element_text(size=14, hjust=0.5),
        plot.margin = margin(t = 15,r = 25,b = 15,l = 15, unit = "pt"),
        axis.title.y = element_blank(),
        axis.title.x = element_text(size=12),
        axis.text.y = element_text(size=10),
        axis.text.x = element_text(size=10),
        axis.ticks.x = element_blank(),
        panel.grid.major.x = element_line(colour="black", linetype = "dashed"),
        panel.grid.minor.x = element_line(colour="white"),
        panel.grid.major.y = element_line(colour="white"),
        panel.grid.minor = element_blank(),
        legend.position = c(0.9,0.8),
        legend.title = element_blank()) +
  scale_x_date(date_labels = "%d %b '%y", limits = c(as.Date("2019-08-01"), as.Date("2020-12-01")), date_breaks = "4 months", minor_breaks = "1 month", expand = expand_scale(0), position = "top")+
  scale_color_manual(values=c("#009E73", "#0072B2"),
                     labels=c("Part A", "Part B")) +
  scale_y_discrete(limits=c("Part A, Task 10","Part A, Task 9","Part A, Task 8","Part A, Task 7","Part B, Task 4","Part A, Task 6","Part A, Task 5","Part A, Task 4","Part B, Task 3","Part B, Task 2","Part A, Task 3","Part A, Task 2","Part B, Task 1","Part A, Task 1"))

# Save chart
ggsave("GANTTChart.png", plot = last_plot())
