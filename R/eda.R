library(tidyverse)
library(precis)


tour_data <- read.csv('data/lions_tour_performance_data.csv')
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

calculate_type_from_position <- function(position) {
  if (position >=1  && position <= 8) {
    return("Forward")
  } else if (position >=9  && position <= 15) {
    return("Back")
  } else {
    return(NA)
  }
}

players <- tour_data %>% 
  group_by(Player, Team) %>% 
  mutate(PositionType = calculate_type_from_position(min(Position))) %>%
  select(Player, Team, PositionType)

players_with_position <- players %>% group_by(Player, Team, PositionType) %>% summarise()

write.csv(players_with_position, file = "data/player_positions.csv")


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
