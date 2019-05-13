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
Refer to Testing with 2015 Cricket World Cup Table.


### Training Data

  To train our model, we utilize the data collected from every men’s cricket world cup. From 1975 to the present, there have been 11 world   cups (1975, 1979, 1983, 1987, 1992, 1996, 1999, 2003, 2007, 2011 and 2015) played so far. One thing to be noticed is that until 1983       world cup, each team played 60 overs each whereas from 1987 onwards, 50 overs. Also, run scoring has increased incredibly over the last     few  years, that will be considered in our features as well.
  
### Features

  All these features except the number of ICC trophies won for the last 12 years is based solely on One-Day International (ODI) records.     All the individual features are converted to a team statistic by taking the overall mean. Certain features are provided with a             description of Recent which basically means the period from 2015 world cup to present. Some features were also selected based on the       location of the upcoming World Cup. 


### Features List 1

| SNo           | Category      | Feature Description |
| ------------- |:-------------:| :-----:|
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


### Features List 2

| SNo           | Category      | Feature Description |
| ------------- |:-------------:| :-----:|
|      1        |   Team        | Death Batting Strike Rate: Recent |
|      2        |   Team        | Death Batting Number of Boundaries: Recent |
|      3        |   Team        | Powerplay Bowling Average: Recent |
|      4        |   Team        | Powerplay Bowling Strike Rate: Recent |
|      5        |   Team        | Powerplay Bowling Economy Rate: Recent |
|      6        |   Team        | Death Bowling Average: Recent |
|      7        |   Team        | Death Bowling Strike Rate: Recent |
|      8        |   Team        | Death Bowling Number of Boundaries: Recent |
|      9        |   Individual  | Batting Average at World Cup Location |
|      10       |   Individual  | Batting Strike Rate at World Cup Location |
|      11       |   Individual  | Number of 100s scored at World Cup Location |
|      12       |   Individual  | Number of 50s scored at World Cup Location |
|      13       |   Individual  | Bowling Average at World Cup Location |
|      14       |   Individual  | Bowling Strike Rate at World Cup Location |
|      15       |   Individual  | Bowling Economy Rate at World Cup Location |
|      16       |   Team        | Win-loss ratio at World Cup Location |
|      17       |   Team        | Number of ICC Trophies in last 12 years |
|      18       |   Team        | Win-loss ratio of the Captain |
|      19       |   Team        | No of Bowler variations in the squad |
|      20       |   Team        | Win-loss ratio while defending |
|      21       |   Team        | Win-loss ratio while Chasing |
|      22       |   Team        | Ratio of Number of Matches won afetr winning the toss |
|      23       |   Team        | Ratio of Number of Matches won afetr losing the toss |
|      24       |   Team        | Number of players with experience in playing long tournaments |
|      25       |   Individual  | Ratio of Number of catches and number of matches played |
|      26       | Miscellaneous | Weather Conditions: Recent |
|      27       | Miscellaneous | Location of World Cup |


### Classification Methods

In this research, we present two different approaches for our predictive analysis. At first, we present a classifier approach and later we present a neural network approach with hidden layers. Classifier approach would help us to identify the pattern whereas neural network would help us identify the weights allocated after training for each feature. 

### 1. Ensemble Classification Approach

The framework of ensemble classifier systems is established by combining numerous basic classifiers together to reduce the variance caused by a single training set and more expressive concept in classification than a single classifier. We utilize the 8 basic classifiers for this study. The number of basic classifiers are selected based on the leave one out fold validation of the training data. Ensemble classifier has proven to be effective for predictive analysis, hence we adopted the same for this prediction.

### 2. Neural Network Approach

In this neural network approach, we utilize 12 hidden layers for this prediction. The number of hidden layers was chosen based on leave one out validation of the training data. Gradient descent back propagation method is utilized.


### Testing with 2015 Cricket World Cup

At first, we validate our approach by estimating the probabilities of winning the World Cup of these 10 teams for the 2015 world cup and match with the actual 2015 world cup results. We estimate the probabilities based on the data collected from 1975-2011 world cups. Despite the 2015 world cup being played among 14 different countries, we focus on the results of these 10 teams. Above tables lists the probabilities for the 2015 world cup based on both classifier and neural network approaches along with the actual result.

| Team            | Classifier Probability | Neural Network Prediction | Actual Result    |
| :---            |     :---:              |          :---:            |     :---:        |
| Afghanistan     | 1%                     | 1%                        |  Group Stage     |
| **Australia**   | **28.5%**              | **25.1%**                 |  **Winners**     |
| Bangladesh      | 5%                     | 2%                        |  Quarter Finals  |
| England         | 6.5%                   | 5%                        |  Group Stage     |
| **India**       | **16.0%**              | **12.4%**                 |  **Semi Finals** |
| **New Zealand** | **12.5%**              | **16.1%**                 |  **Finalists**   |
| Pakistan        | 9%                     | 11%                       |  Quarter Finals  |
| **South Africa**| **12.0%**              | **15.4%**                 |  **Semi Finals** |
| Sri Lanka       | 7%                     | 9%                        |  Quarter Finals  |
| West Indies     | 2.5%                   | 3%                        |  Quarter Finals  |


### 2019 Cricket World Cup

Now, we predict the 2019 world cup results based on the data collected from 1975-2015 world cups. Table 3 presents the probabilities based on the classification approaches based on the data collected until 18th July 2018

| Team            | Classifier Probability | Neural Network Prediction | Predicted Result    | Actual Result |
| :---            |     :---:              |          :---:            |     :---:           |    :---:      |
| Afghanistan     | 0.5%                   | 1%                        |  Group Stage        |    Waiting    |
| Australia       | 10.0%                  | 6.1%                      |  Quarter Finals     |    Waiting    |
| Bangladesh      | 3%                     | 2%                        |  Group Stage        |    Waiting    |
| **England**     | **21.0%**              | **18.8%**                 |  **Finalists**      |    Waiting    |
| **India**       | **18.0%**              | **20.8%**                 |  **Winners**        |    Waiting    |
| **New Zealand** | **14.5%**              | **15.7%**                 |  **Semi Finals**    |    Waiting    |
| **Pakistan**    | **17.5%**              | **19.0%**                 |  **Semi Finals**    |    Waiting    |
| South Africa    | 8.5%                   | 10.6%                     |  Semi Finals        |    Waiting    |
| Sri Lanka       | 3.5%                   | 3%                        |  Quarter Finals     |    Waiting    |
| West Indies     | 3.5%                   | 3%                        |  Quarter Finals     |    Waiting    |


100% DONE.... SUBMITTED

