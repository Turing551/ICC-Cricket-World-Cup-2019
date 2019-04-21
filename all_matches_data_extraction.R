
# This file extracts the data from web for all the matches required
# Time taken for running ~several hours (Not advised to run this for testing)
# Also, some series are cannot be extracted due to various problems
# Most of such errors were fixed, but some still remain

# Load the required libraries
library(xml2)
library(rvest)
library(XML)
library(RCurl)
library(rlist)
library(dplyr)

# Required data
all_matches_df <<- data.frame()
all_players_urls = c()
all_series_urls = c()

# Links of all the seasons
main_url = "http://www.espncricinfo.com/ci/engine/series/index.html"
main_page_hrefs = html_attr(html_nodes(read_html(main_url), "a"), "href")
seasons_hrefs = unique(main_page_hrefs[grep(pattern = "series.*season", x = main_page_hrefs, ignore.case = TRUE)])
seasons_hrefs = seasons_hrefs[10:41]

# Looping over all seasons
for (index_season in c(1:length(seasons_hrefs))){
  season_url = paste("http://www.espncricinfo.com",seasons_hrefs[index_season], sep="")
  season = substring(strsplit(season_url, "season=")[[1]][2], first = 1, last = 4)
  format_list = html_nodes(read_html(season_url), xpath = "//div[@class='match-section-head']")%>%html_text()
  odi_node = format_list[grep(pattern="one.*day.*internation", ignore.case = TRUE, x=format_list)]
  odi_node = odi_node[grep(pattern="women|youth", invert = TRUE, ignore.case = TRUE, x=odi_node)]
  odi_index = which(format_list == odi_node)
  
  # Obtaining nodes under subsection One-Day Internationals
  odi_series_node = html_nodes(read_html(season_url), xpath = "//section[@class='series-summary-wrap']")[odi_index[1]]
  odi_series_nodes = odi_series_node%>%html_children()
  
  # Looping over all series of a season
  for (index_series in c(1:length(odi_series_nodes))){
    series_node = odi_series_nodes[index_series]%>%html_attrs()
    series_url = paste("http://www.espncricinfo.com", unname(series_node[[1]]["data-summary-url"]), sep="")
    
    # Not to repeat extracting data from the same series
    if (series_url %in% all_series_urls){
      next
    }
    
    all_series_urls = c(all_series_urls, series_url)
    series_page_hrefs = html_attr(html_nodes(read_html(series_url), "a"), "href")
    matches_hrefs = unique(series_page_hrefs[grep(pattern = "scorecard", x = series_page_hrefs, ignore.case = TRUE)])
    
    if (length(matches_hrefs) == 0){
      next
    }
    
    # Looping over all matches of a series
    for (index_match in c(1:length(matches_hrefs))){
      print(paste("Season ", index_season, ", Series ", index_series, ", Match ", index_match,sep=""))
      match_df = data.frame()
      match_url = matches_hrefs[index_match]
      match_nodes = html_nodes(read_html(match_url), "a")
      match_hrefs = html_attr(match_nodes, "href")
      player_hrefs = unique(match_hrefs[grep(pattern = "content.*player", x = match_hrefs, ignore.case = TRUE)])[1:22]
      
      # Obtaining the result of the match
      page_parse <- htmlParse(match_url)
      result_line <- lapply(page_parse['//span[@class="cscore_notes_game"]'],xmlValue)[[1]]
      result_list = strsplit(result_line, " ")[[1]]
      if ("tied" %in% result_list | "No" %in% result_list | "abandoned" %in% result_list | "cancelled" %in% result_list){
        next
      }
      winning_team = paste(result_list[1:which(result_list == "won")-1], collapse=" ")
      winning_margin = as.numeric(result_list[which(result_list == "won")+2])
      winning_runs_or_wickets = result_list[which(result_list == "won")+3]
      
      # Looping over all players of a match      
      for (index_player in c(1:length(player_hrefs))){
        player_page<-read_html(player_hrefs[index_player])
        player_page_information <-html_nodes(player_page, "p")
        player_country = player_page_information[grep("player.*country", player_page_information, ignore.case = TRUE)][1]%>%html_text()
        player_name = strsplit(player_page_information[grep("full.*name", player_page_information, ignore.case = TRUE)][1]%>%html_text(), "\n")[[1]][2]
        player_df = data.frame(match_url, winning_team, winning_margin, winning_runs_or_wickets, player_name, player_country, season)
        
        match_df = bind_rows(match_df, player_df)
        all_players_urls = c(all_players_urls, player_hrefs[index_player])
        
      } # end players loop
      all_matches_df = bind_rows(all_matches_df, match_df)
      
    } # end matches loop
  } # end series loop
  } # end season loop

# Write the extracted data into csv files
# The below lines are commented so that partially extracted data so not replace the full data
# which is present in the folder
#write.csv(all_matches_df, "Data_Matches.csv", Encoding<-'utf-8')
#write.csv(unique(all_players_urls), "Urls_Players.csv")
