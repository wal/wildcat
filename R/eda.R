library(tidyverse)
library(precis)


tour_data <- read.csv('data/lions_tour_performance_data.csv')
tour_data$Tour_Match <- factor(tour_data$Tour_Match, levels = c("M1","M2","M3","M4","M5","M6","M7","M8","M9","M10"))
tour_data$Player <- as.factor(tour_data$Player)
tour_data$Position <- as.numeric(tour_data$Position)
tour_data$Team <- factor(tour_data$Team, levels = c("NZ Provincial Barbarians",
                                                    "Blues",
                                                    "Crusaders", 
                                                    "Highlanders", 
                                                    "Maori All Blacks", 
                                                    "Chiefs",
                                                    "New Zealand",
                                                    "Hurricanes",
                                                    "BIL"))



test_match_data <- tour_data %>% filter(Tour_Match %in% c("M7","M9","M10"))

variable_name = 'Carries'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Carries, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  


variable_name = 'Offloads'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Offloads, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Tackles'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Tackles, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Missed Tackles'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Missed_Tackles, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Passes'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Passes, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Turnovers Won'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Turnovers_Won, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Turnovers Conceded'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Turnovers_Conceded, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Defenders Beaten'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Defenders_Beaten, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Clean Breaks'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Clean_Breaks, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Lineouts Won'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Lineouts_Won, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  

variable_name = 'Lineouts Stolen'
png(paste("plots/TestMatch - ", variable_name, ".png"))
ggplot(test_match_data, aes(x = Team, y = Lineouts_Stolen, fill = Team)) + 
  geom_bar(stat = "Identity") +
  facet_wrap(~ Tour_Match) +
  ggtitle(paste(variable_name," by Team")) +
  scale_fill_manual(values=c("black", "red"))
dev.off()  


# 
# # Tackles
# tour_data$Tackles[is.na(tour_data$Tackles)] <- 0
# png("plots/TourTackleCount.png")
# ggplot(tour_data, aes(x = reorder(tour_data$Player, tour_data$Tackles, sum), y = Tackles, fill = Opposition)) + 
#   geom_bar(stat="summary", fun.y=sum) +
#   coord_flip() +
#   labs(x = "Player", y = "Tackles") +
#   ggtitle("Tackles Made")
# 
# dev.off()
# 
# 
# tour_data %>% group_by(Player) %>% summarise(total_carries = sum(Offloads)) %>% arrange(total_carries, 'desc')
# 
# # Offloads
# tour_data$Offloads[is.na(tour_data$Offloads)] <- 0
# png("plots/Offloads.png")
# ggplot(tour_data, aes(x = reorder(tour_data$Player, tour_data$Offloads, sum), y = Tackles, fill = Opposition)) + 
#   geom_bar(stat="summary", fun.y=sum) +
#   coord_flip() +
#   labs(x = "Player", y = "Offloads") +
#   ggtitle("Offloads")
# 
# dev.off()
# 
# 
# # Carries
# tour_data$Carries[is.na(tour_data$Carries)] <- 0
# png("plots/Carries.png")
# ggplot(tour_data, aes(x = reorder(tour_data$Player, tour_data$Carries, sum), y = Carries, fill = Opposition)) + 
#   geom_bar(stat="summary", fun.y=sum) +
#   coord_flip() +
#   labs(x = "Player", y = "Carries") +
#   ggtitle("Carries")
# 
# dev.off()
# 
