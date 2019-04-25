
library(dplyr)

# Required Data
all_players_df = read.csv("Data_2019.csv")
all_players_df$X = NULL

# Aggregating data by team
aggregation_by_team = function(x){
  x$Mat_avg = mean(x$Mat_Bat, na.rm=TRUE)
  x$Inns_Bat_avg = mean(x$Inns_Bat, na.rm=TRUE)
  x$NO_avg = mean(x$NO, na.rm=TRUE)
  x$Runs_Bat_avg = mean(x$Runs_Bat, na.rm=TRUE)
  x$Runs_Bat_max = max(x$Runs_Bat, na.rm=TRUE)
  x$HS_avg = mean(x$HS, na.rm=TRUE)
  x$HS_max = max(x$HS, na.rm=TRUE)
  x$Ave_Bat_avg = mean(x$Ave_Bat, na.rm=TRUE)
  x$Ave_Bat_max = max(x$Ave_Bat, na.rm=TRUE)
  x$BF_avg = mean(x$BF, na.rm=TRUE)
  x$SR_Bat_avg = mean(x$SR_Bat, na.rm=TRUE)
  x$SR_Bat_max = max(x$SR_Bat, na.rm=TRUE)
  x$X100_avg = mean(x$X100, na.rm=TRUE)
  x$X100_max = max(x$X100, na.rm=TRUE)
  x$X50_avg = mean(x$X50, na.rm=TRUE)
  x$X50_max = max(x$X50, na.rm=TRUE)
  x$X4s_avg = mean(x$X4s, na.rm=TRUE)
  x$X4s_max = max(x$X4s, na.rm=TRUE)
  x$X6s_avg = mean(x$X6s, na.rm=TRUE)
  x$X6s_max = max(x$X6s, na.rm=TRUE)
  x$Ct_avg = mean(x$Ct, na.rm=TRUE)
  x$Ct_max = max(x$Ct, na.rm=TRUE)
  x$St_avg = mean(x$St, na.rm=TRUE)
  x$St_max = max(x$St, na.rm=TRUE)
  x$Inns_Bowl_avg = mean(x$Inns_Bowl, na.rm=TRUE)
  x$Balls_avg = mean(x$Balls, na.rm=TRUE)
  x$Runs_Bowl_avg = mean(x$Runs_Bowl, na.rm=TRUE)
  x$Wkts_avg = mean(x$Wkts, na.rm=TRUE)
  x$Wkts_max = max(x$Wkts, na.rm=TRUE)
  x$Ave_Bowl_avg = mean(x$Ave_Bowl, na.rm=TRUE)
  x$Ave_Bowl_min = min(x$Ave_Bowl, na.rm=TRUE)
  x$Econ_avg = mean(x$Econ, na.rm=TRUE)
  x$Econ_min = min(x$Econ, na.rm=TRUE)
  x$SR_Bowl_avg = mean(x$SR_Bowl, na.rm=TRUE)
  x$SR_Bowl_min = min(x$SR_Bowl, na.rm=TRUE)
  x$X4w_avg = mean(x$X4w, na.rm=TRUE)
  x$X4w_max = max(x$X4w, na.rm=TRUE)
  x$X5w_avg = mean(x$X5w, na.rm=TRUE)
  x$X5w_max = max(x$X5w, na.rm=TRUE)
  x$X10_avg = mean(x$X10, na.rm=TRUE)
  x$X10_max = max(x$X10, na.rm=TRUE)
  
  return (x[1,c("Country", "Mat_avg", "Inns_Bat_avg", 
                "NO_avg", "Runs_Bat_avg", "Runs_Bat_avg", "HS_avg", "HS_max", "Ave_Bat_avg", "Ave_Bat_max",
                "BF_avg", "SR_Bat_avg", "SR_Bat_max", "X100_avg", "X100_max", "X50_avg", "X50_max", "X4s_avg", "X4s_max",
                "X6s_avg", "X6s_max", "Ct_avg", "Ct_max", "St_avg", "St_max", "Inns_Bowl_avg", "Balls_avg", 
                "Runs_Bowl_avg", "Wkts_avg", "Wkts_max", "Ave_Bowl_avg", "Ave_Bowl_min", "Econ_avg", 
                "Econ_min", "SR_Bowl_avg", "SR_Bowl_min", "X4w_avg", "X4w_max", "X5w_avg", "X5w_max", 
                "X10_avg", "X10_max")])
} # end function

teams_data = all_players_df %>% group_by(Country) %>% do(data.frame(aggregation_by_team(.)))
teams = list(as.character(teams_data$Country))[[1]]

# Simulating the matches
matches_df = data.frame()
for (i in c(1:(length(teams)-1))){
  for (j in c((i+1):length(teams))){
    if (i==j){
      next
    }
    Match = paste(teams[i], "vs", teams[j], sep=" ")
    Team = teams[i]
    match1 = data.frame(Match, Team)
    Team = teams[j]
    match2 = data.frame(Match, Team)
    matches_df = bind_rows(matches_df, match1, match2)
  } # end j
} # end i
rownames(matches_df) = NULL
matches_df_merged = merge(matches_df, teams_data, by.x = "Team", by.y = "Country", all.x = TRUE)

# Aggregating Data by match
aggregation_by_match = function(x){
  rownames(x) = NULL
  match = x$Match[1]
  team1 = x$Team[1]
  team2 = x$Team[2]
  x$Match = NULL
  x$Team = NULL
  x$country = NULL

  x[3,] = x[2,] - x[1,]
  x$Match = match
  x$Team1 = team1
  x$Team2 = team2
  return (x[3,])
}
matches_data_final = matches_df_merged %>% group_by(Match) %>% do(data.frame(aggregation_by_match(.)))

# Writing the required output
write.csv(matches_data_final, "Data_Testing_2019.csv")

