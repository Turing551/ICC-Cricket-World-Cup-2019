# Load the required libraries
library(xml2)
library(rvest)
library(XML)
library(RCurl)
library(rlist)
library(dplyr)

# Required match links for the teams' latest matches
matches_hrefs = c("http://www.espncricinfo.com/series/8532/scorecard/1153252/afghanistan-vs-bangladesh-4th-match-super-four-asia-cup-2018",
                  "http://www.espn.in/cricket/series/18879/scorecard/1157380/new-zealand-vs-pakistan-3rd-odi-nz-in-uae-2018-19",
                  "http://www.espn.in/cricket/series/18902/scorecard/1157761/india-vs-west-indies-3rd-t20i-west-indies-in-india-2018-19",
                  "http://www.espn.in/cricket/series/18602/scorecard/1140381/sri-lanka-vs-england-3rd-odi-eng-in-sl-2018-19",
                  "http://www.espncricinfo.com/series/18684/scorecard/1144988/australia-vs-south-africa-3rd-odi-sa-in-aus-2018-19")

all_matches_df = data.frame()
all_players_urls = c()

# Looping over all the matches
for (index_match in c(1:length(matches_hrefs))){
  print(paste("Match",index_match,"out of",length(matches_hrefs), sep=" "))
  match_df = data.frame()
  match_url = matches_hrefs[index_match]
  match_nodes = html_nodes(read_html(match_url), "a")
  match_hrefs = html_attr(match_nodes, "href")
  player_hrefs = unique(match_hrefs[grep(pattern = "content.*player", x = match_hrefs, ignore.case = TRUE)])[1:22]
  
  # Looping over all players of a match      
  for (index_player in c(1:length(player_hrefs))){
    player_page<-read_html(player_hrefs[index_player])
    player_page_information <-html_nodes(player_page, "p")
    player_country = player_page_information[grep("player.*country", player_page_information, ignore.case = TRUE)][1]%>%html_text()
    player_name = strsplit(player_page_information[grep("full.*name", player_page_information, ignore.case = TRUE)][1]%>%html_text(), "\n")[[1]][2]
    player_df = data.frame(match_url, player_name, player_country)
    
    match_df = bind_rows(match_df, player_df)
    all_players_urls = c(all_players_urls, player_hrefs[index_player])
    
  } # end players loop
  all_matches_df = bind_rows(all_matches_df, match_df)
} # end matches loop

players_urls = unique(all_players_urls)
all_players_df = data.frame()

# Looping over all the players
for (index_player in c(1:length(players_urls))){
  print(paste("Player",index_player,"out of",length(players_urls), sep=" "))
  player_url = players_urls[index_player]
  player_page<-read_html(player_url)
  player_page_information <-html_nodes(player_page, "p")
  player_country = player_page_information[grep("player.*country", player_page_information, ignore.case = TRUE)][1]%>%html_text()
  player_name = strsplit(player_page_information[grep("full.*name", player_page_information, ignore.case = TRUE)][1]%>%html_text(), "\n")[[1]][2]
  
  player_batting_style_data = player_page_information[grep("batting.*style", player_page_information, ignore.case = TRUE)][1]%>%html_text()
  player_batting_style = ifelse(length(player_batting_style_data) == 0, NA, player_batting_style_data)
  player_bowling_style_data = player_page_information[grep("bowling.*style", player_page_information, ignore.case = TRUE)][1]%>%html_text()
  player_bowling_style = ifelse(length(player_bowling_style_data) == 0, NA, player_bowling_style_data)
  
  tables<-html_nodes(player_page, "table")
  
  # Batting Statistics
  table_batting <- html_table(tables[1], fill = TRUE)
  if (length(table_batting) == 0){
    next
  }
  rownames(table_batting[[1]]) = table_batting[[1]][,1]
  table_batting = table_batting[[1]][,-1]
  if (!"ODIs" %in% rownames(table_batting)){
    next
  }
  odi_batting = table_batting["ODIs",]
  odi_batting[odi_batting == "-" | odi_batting == " "] = NA
  odi_batting$HS = as.numeric(gsub("\\*", "", odi_batting$HS))
  odi_batting[] <- lapply(odi_batting, function(x) as.numeric(x))
  
  # Bowling Statistics
  table_bowling <- html_table(tables[2], fill = TRUE)
  rownames(table_bowling[[1]]) = table_bowling[[1]][,1]
  table_bowling = table_bowling[[1]][,-1]
  odi_bowling = table_bowling["ODIs",]
  odi_bowling$BBI = NULL
  odi_bowling$BBM = NULL
  odi_bowling[odi_bowling == "-" | odi_bowling == " "] = NA
  odi_bowling[] <- lapply(odi_bowling, function(x) as.numeric(x))
  
  player_statistics = merge(odi_batting, odi_bowling, by=0, suffixes = c("_Bat", "_Bowl"))
  player_statistics$Full_Name = player_name
  player_statistics$Country = player_country
  player_statistics$Batting_Style = player_batting_style
  player_statistics$Bowling_Style = player_bowling_style
  player_statistics$Row.names = NULL
  
  all_players_df = bind_rows(all_players_df, player_statistics)
  
} # end player for loop

# Writing the required data
write.csv(all_players_df, "Data_2019.csv")
