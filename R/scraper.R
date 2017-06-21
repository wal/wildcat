library(rvest)
library(stringr)
library(precis)

html_files_path <-'data/html/'
html_files <- list.files(html_files_path, full.names = TRUE)
#html_files <- c("data/html//M1-British & Irish Lions _ NZ Provincial Barbarians v British & Irish Lions.html")

tour_data <- data.frame()

for(i in 1:length(html_files)) {
  match_file = html_files[i]
  message(paste('Parsing match file ', match_file))
  
  match_html = read_html(match_file)

  lions_performance_table <-  match_html %>% 
    html_nodes(xpath = '//*[@id="sotic_wp_widget-39-content"]/div/div[2]/div[2]/div/table') %>% 
    html_table(header = TRUE, trim = TRUE, fill = TRUE)
  
  lions_performance_data <- lions_performance_table[[1]]
  lions_performance_data <- lions_performance_data %>% filter(Pos != "Replacements")
  lions_performance_data$match_html_file = match_file
  
  lions_performance_data$Player <- sapply(strsplit(as.character(lions_performance_data$Player),'\n'), "[", 1)
  
  tour_data <- rbind(tour_data, lions_performance_data)
}

names(tour_data) <- c("Position", "Player", "Metres_Gained", "Carries", "Passes", "Tackles", "Missed_Tackles", "Turnovers_Won", "Turnovers_Conceded", "Defenders_Beaten", "Try_Assists", "Offloads", "Clean_Breaks", "Lineouts_Won", "Lineouts_Stolen")
tour_data$Player <- as.factor(tour_data$Player)
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

precis(tour_data)


write.csv(tour_data, file = "data/lions_tour_performance_data.csv")




  