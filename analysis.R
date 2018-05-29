# analysis.R
# manipulate data to create data frames for visualizations
library(dplyr)

# hate crimes
hate_crimes <- read.csv("hate_crimes.csv", stringsAsFactors = FALSE)
hate_crimes[is.na(hate_crimes)] <- 0

hate_crimes_minus_DC <- hate_crimes[-9, ]
# Hate Crimes per State

# trying max(hate_crimes_minus_DC$avg_hatecrimes_per_100k_fbi) didn't work so I 
# cheated vvv)
worst_state_frame <- subset(hate_crimes_minus_DC, state == "Massachusetts")

# gives the string "Massachusetts" as a value
worst_state <- worst_state_frame$state

# Factors Influencing Rate of Hate Crimes

# affect of income inequality on rate of hate crimes
hate_crimes_minus_DC <- mutate(hate_crimes_minus_DC, income_corr = gini_index
                               / avg_hatecrimes_per_100k_fbi)

# affect of education on rate of hate crimes
hate_crimes_minus_DC <- mutate(hate_crimes_minus_DC,
                               edu_corr = share_population_with_high_school_degree / 
                                 avg_hatecrimes_per_100k_fbi)

# affect of racial diversity on rate of hate crimes
hate_crimes_minus_DC <- mutate(hate_crimes_minus_DC, div_corr = share_non_white
                               / avg_hatecrimes_per_100k_fbi)

# rename corr columns for easy use in visualizations
names(hate_crimes_minus_DC)[names(hate_crimes_minus_DC) == 'edu_corr'] <- 'Education'
names(hate_crimes_minus_DC)[names(hate_crimes_minus_DC) == 'div_corr'] <- 'Racial Diversity'
names(hate_crimes_minus_DC)[names(hate_crimes_minus_DC) == 'income_corr'] <- 'Income Inequality'