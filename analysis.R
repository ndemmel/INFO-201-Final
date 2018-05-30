# analysis.R
# manipulate data to create data frames for visualizations
library(dplyr)

# hate crimes
hate_crimes <- read.csv("hate_crimes.csv", stringsAsFactors = FALSE)

hate_crimes_minus_dc <- hate_crimes[-9, ]

# Hate Crimes per State

worst_state_frame <- subset(hate_crimes_minus_dc, state == "Massachusetts")

# gives the string "Massachusetts" as a value
worst_state <- worst_state_frame$state

# Factors Influencing Rate of Hate Crimes

# affect of income inequality on rate of hate crimes
hate_crimes_minus_dc <- mutate(hate_crimes_minus_dc, income_corr = gini_index /
                               avg_hatecrimes_per_100k_fbi)

# affect of education on rate of hate crimes
hate_crimes_minus_dc <- mutate(hate_crimes_minus_dc,
  edu_corr = share_population_with_high_school_degree /
    avg_hatecrimes_per_100k_fbi
)

# affect of racial diversity on rate of hate crimes
hate_crimes_minus_dc <- mutate(hate_crimes_minus_dc, div_corr = share_non_white
                               / avg_hatecrimes_per_100k_fbi)

# rename corr columns for easy use in visualizations
names(hate_crimes_minus_dc)[names(hate_crimes_minus_dc) == "edu_corr"] <-
  "Education"
names(hate_crimes_minus_dc)[names(hate_crimes_minus_dc) == "div_corr"] <-
  "Racial Diversity"
names(hate_crimes_minus_dc)[names(hate_crimes_minus_dc) == "income_corr"] <-
  "Income Inequality"

# Adds column with state abbreviations for interactive map
crimes_states <- mutate(hate_crimes_minus_dc, locations = c(
  "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE",
  "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
  "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM",
  "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX",
  "UT", "VT", "VA", "WA", "WV", "WI", "WY"
))

# Scale weeks on rate of hate crimes to match avg annual
crimes_states <- crimes_states %>%
  mutate(avg_hatecrimes_per_100k_fbi = avg_hatecrimes_per_100k_fbi / 36.5)