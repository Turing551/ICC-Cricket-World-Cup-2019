# ICC-Cricket-World-Cup-2019

Here I'm presenting a predictive analysis model for 2019 men's Cricket World Cup. I believe this predictive analysis strategy would be useful for viewers, sponsors and team strategists.

This model is developed based on the historical data collected for the 10 participating teams.

  1. Afghanistan
  2. Australia
  3. Bangladesh
  4. England
  5. India
  6. New Zealand
  7. Pakistan
  8. South Africa
  9. Sri Lanka 
  10. West Indies
  
In addition, we test our model on 2015 world cup data and measure the accuracy of predictions.


### Training Data

  To train our model, we utilize the data collected from every men’s cricket world cup. From 1975 to the present, there have been 11 world   cups (1975, 1979, 1983, 1987, 1992, 1996, 1999, 2003, 2007, 2011 and 2015) played so far. One thing to be noticed is that until 1983       world cup, each team played 60 overs each whereas from 1987 onwards, 50 overs. Also, run scoring has increased incredibly over the last     few  years, that will be considered in our features as well.
  
### Features

  All these features except the number of ICC trophies won for the last 12 years is based solely on One-Day International (ODI) records.     All the individual features are converted to a team statistic by taking the overall mean. Certain features are provided with a             description of Recent which basically means the period from 2015 world cup to present. Some features were also selected based on the       location of the upcoming World Cup. 


### Features List 1

| SNo           | Category      | Feature Description |
| ------------- |:-------------:| -----:|
|      1        |   Individual  | Career Batting Average |
|      2        |   Individual  | Career Batting Strike Rate |
|      3        |   Individual  | No of 100's scored in total |
|      4        |   Individual  | No of 50's scored in total |
|      5        |   Individual  | No of boundaries scored in total |
|      6        |   Individual  | Career Bowling Average |
|      7        |   Individual  | Career Bowling Strike Rate |
|      8        |   Individual  | Career Bowling Economy Rate |
|      9        |   Individual  | No of wickets taken per innings > 2 |
|      10       |   Individual  | Batting Average: Recent |
|      11       |   Individual  | Batting Strike Rate: Recent |
|      12       |   Individual  | No of 100's scored: Recent |
|      13       |   Individual  | No of 50's scored: Recent |
|      14       |   Individual  | No of boundaries: Recent |
|      15       |   Individual  | Bowling Average: Recent |
|      16       |   Individual  | Bowling Strike Rate: Recent |
|      17       |   Individual  | Bowling Economy Rate: Recent |
|      18       |   Individual  | No of ODI's Played |
|      19       |   Individual  | No of World Cup Matches played before |
|      20       |   Individual  | Age |
|      21       |   Team        | Consolidated Average of opening Batsmen in the squad |
|      22       |   Team        | Consolidated Average of Middle Order Batsmen in the squad |
|      23       |   Team        | Consolidated Batting and bowling averages of all-rounders in the squad |
|      24       |   Team        | Consolidated Bowling Average of Spinners in the Squad |
|      25       |   Team        | Consolidated Bowling Average of Fast Bowlers in the Squad |
|      26       |   Team        | Powerplay Batting Average: Recent |
|      27       |   Team        | Powerplay Batting Strike Rate: Recent |
|      28       |   Team        | Powerplay Batting No of boundaries: Recent |
|      29       |   Team        | Death Batting Average: Recent |
|      30       |   Team        | Overall Win Loss Ratio |
|      31       |   Team        | Win Loss Ratio: Recent |


### Adding Features List 2.... Coming soon

85% done

