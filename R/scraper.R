library(rvest)
library(stringr)
library(tidyverse)

html_files_path <-'data/html'
html_files <- list.files(html_files_path, full.names = TRUE)

tour_data <- data.frame()

load_performance_table <- function(match_html, table_xpath) {
  match_html %>% 
    html_nodes(xpath = table_xpath) %>% 
    html_table(header = TRUE, trim = TRUE, fill = TRUE)
}

process_performance_table <- function(performance_table, match_file) {
  performance_data <- performance_table[[1]]
  
  # HTML table includes a row to seperate the replacements, remove this 
  performance_data <- performance_data %>% filter(Pos != "Replacements")
  
  # Add in what html file this row came from
  performance_data$match_html_file = match_file
  
  # Figure out which tour match from the file name and add it as a variable
  performance_data <- performance_data %>% mutate(Game = NA,Game = str_match(match_html_file, "M(10|[0-9])")[,1])
  
  # Clean up player name (as field in table includes substitution info)
  # TODO - Infer minutes played from substitution info
  performance_data$Player <- sapply(strsplit(as.character(performance_data$Player),'\n'), "[", 1)
  
  return(performance_data)
}

for(i in 1:length(html_files)) {
  match_file = html_files[i]
  message(paste('Parsing match file ', match_file))
  
  match_html = read_html(match_file)
  
  # Lions stats
  lions_performance_table <-  load_performance_table(match_html,  '//*[@id="sotic_wp_widget-39-content"]/div/div[2]/div[2]/div/table')
  lions_performance_data <- process_performance_table(lions_performance_table, match_file)
  lions_performance_data$Team = 'BIL'
  
  tour_data <- rbind(tour_data, lions_performance_data)
  
  # Opposiion stats
  opposition_performance_table <- load_performance_table(match_html,  '//*[@id="sotic_wp_widget-39-content"]/div/div[2]/div[1]/div/table')
  opposition_performance_data <- process_performance_table(opposition_performance_table, match_file)

  # Locate opposition name from file name
  opposition = str_match(match_file, "British & Irish Lions _ (.*) v")[,2]
  opposition = str_trim(opposition)
  opposition_performance_data$Team = opposition
  
  tour_data <- rbind(tour_data, opposition_performance_data)
}

# Better variable names
names(tour_data) <- c("Position", "Player", "Metres_Gained", "Carries", "Passes", "Tackles", "Missed_Tackles", "Turnovers_Won", "Turnovers_Conceded", "Defenders_Beaten", "Try_Assists", "Offloads", "Clean_Breaks", "Lineouts_Won", "Lineouts_Stolen", "Match_Data_File", "Tour_Match", "Team")

# More useful data types
# Factors
tour_data$Player <- as.factor(tour_data$Player)
tour_data$Tour_Match <- as.factor(tour_data$Tour_Match)
tour_data$Team <- as.factor(tour_data$Team)

# Numbers
tour_data$Position <- as.numeric(tour_data$Position)
tour_data$Metres_Gained <- as.numeric(tour_data$Metres_Gained)
tour_data$Carries <- as.numeric(tour_data$Carries)
tour_data$Passes <- as.numeric(tour_data$Passes)
tour_data$Tackles <- as.numeric(tour_data$Tackles)
tour_data$Missed_Tackles <- as.numeric(tour_data$Missed_Tackles)
tour_data$Turnovers_Won <- as.numeric(tour_data$Turnovers_Won)
tour_data$Turnovers_Conceded <- as.numeric(tour_data$Turnovers_Conceded)
tour_data$Defenders_Beaten <- as.numeric(tour_data$Defenders_Beaten)
tour_data$Try_Assists <- as.numeric(tour_data$Try_Assists)
tour_data$Offloads <- as.numeric(tour_data$Offloads)
tour_data$Clean_Breaks <- as.numeric(tour_data$Clean_Breaks)
tour_data$Lineouts_Won <- as.numeric(tour_data$Lineouts_Won)
tour_data$Lineouts_Stolen <- as.numeric(tour_data$Lineouts_Stolen)

write.csv(tour_data, file = "data/lions_tour_performance_data.csv")
save(tour_data,file="data/lions_tour_performance_data.Rda")



  