# INFO 201 Final Project Proposal
By Kiran Pradhan, Shun Matsuo, Markus Shriner, and Nikki Demmel

5/14/18

###Project Description
We are working with a dataset on [hate crimes and income inequality](https://github.com/fivethirtyeight/data/tree/master/hate-crimes). This data comes from **FiveThirtyEight**, and it is accessible on GitHub. Most of the original data was collected in 2015, but a few values were observed in 2016, like the median household income and the amount of hate crimes per 100,000 people in each state. The oldest data comes from 2009, which is a measurement of the number of adults 25 and older who graduated form high school. The dataset is an aggregation of observations from many different sources, including the Kaiser Family Foundation and the United States Census Bureau.

Our goals in working with this dataset are to bring awareness to the real-life impacts income inequality has on our country's unity and wellbeing, and to encourage those in positions of power to address income inequality through legislation and advocacy. Our target audience is mayors, governors, lobby groups, and anyone else with a loud enough voice to act on our findings.


Our audience will learn three things from our dataset:

1. Do income inequality, education, and racial diversity each influence the rate of hate crimes in a state?

2. Which state has the highest rate of hate crimes per 100,000 people?

3. Is there any correlation between the 2016 general election and a change in the average number of hate crimes per state?

###Technical Description
- The data is in .csv format on GitHub, we will read it into RStudio to sift through the information.

- We will need to reshape the data to include only the information that is pertinent to our audience when we present our findings.

- Besides common libraries such as dplyr, we will be using the Hmisc and Companion to Applied Regression (CAR) libraries to perform our analyses.

- We anticipate a discussion over our creative differences later in the project's development, specifically when we are creating our visualizations. Because we all have similar political ideologies, we must take caution not to jump to conclusions in our findings which would affirm our biases. Due to the nature of the questions we are asking with this dataset, we must remind ourselves that correlation is not the same as causation.

- We will be using statistical analysis to derive index scores for each category related to hate crime rates. We will compare the Gini index, percent of the population with a high school degree, and the proportion of the population identifying as nonwhite each to the rate of hate crimes per 100,000 people to identify which quality most closely correlates with the average annual rate of hate crimes per 100,000 people.
