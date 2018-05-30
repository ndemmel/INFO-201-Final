library(dplyr)

# Reads in hate crimes dataset.
hate_crimes <- read.csv("hate_crimes.csv", stringsAsFactors = FALSE)

# Creates new dataset with District of Columbia (DC) data removed.
hate_crimes_minus_dc <- hate_crimes[-9, ]

# Calculates Correlation Coefficient and adds column to hate_crimes_minus_dc.
# (affect of income inequality on rate of hate crimes).
hate_crimes_minus_dc <- mutate(hate_crimes_minus_dc, income_corr = gini_index /
  avg_hatecrimes_per_100k_fbi)

# Calculates Correlation Coefficient and adds column to hate_crimes_minus_dc.
# (affect of education on rate of hate crimes).
hate_crimes_minus_dc <- mutate(hate_crimes_minus_dc,
  edu_corr = share_population_with_high_school_degree /
    avg_hatecrimes_per_100k_fbi
)

# Calculates Correlation Coefficient and adds column to hate_crimes_minus_dc.
# (affect of racial diversity on rate of hate crimes).
hate_crimes_minus_dc <- mutate(hate_crimes_minus_dc, div_corr = share_non_white
 / avg_hatecrimes_per_100k_fbi)

# Renames corr columns for easy use in visualizations.
names(hate_crimes_minus_dc)[names(hate_crimes_minus_dc) == "edu_corr"] <-
  "Education"
names(hate_crimes_minus_dc)[names(hate_crimes_minus_dc) == "div_corr"] <-
  "Racial Diversity"
names(hate_crimes_minus_dc)[names(hate_crimes_minus_dc) == "income_corr"] <-
  "Income Inequality"

# Adds column with state abbreviations to new dataset for interactive map.
crimes_states <- mutate(hate_crimes_minus_dc, locations = c(
  "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE",
  "FL", "GA", "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME",
  "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM",
  "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX",
  "UT", "VT", "VA", "WA", "WV", "WI", "WY"
))

# Scales average annual dataset on rate of hate crimes down to match 10 days.
crimes_states <- crimes_states %>%
  mutate(avg_hatecrimes_per_100k_fbi = avg_hatecrimes_per_100k_fbi / 36.5)

# Creates a list that stores the names of all the states.
states <- list("Alabama", "Alaska", "Arizona", "Arkansas", "California",
"Colorado", "Connecticut", "Delaware",
"District of Columbia", "Florida", "Georgia", "Hawaii",
"Idaho", "Illinois", "Indiana", "Iowa", "Kansas",
"Kentucky", "Louisiana", "Maine", "Maryland",
"Massachusetts", "Michigan", "Minnesota", "Mississippi",
"Missouri", "Montana", "Nebraska", "Nevada",
"New Hampshire", "New Jersey", "New Mexico", "New York",
"North Carolina", "North Dakota", "Ohio", "Oklahoma",
"Oregon", "Pennsylvania", "Rhode Island",
"South Carolina", "South Dakota", "Tennessee", "Texas",
"Utah", "Vermont", "Virginia", "Washington",
"West Virginia", "Wisconsin", "Wyoming")
