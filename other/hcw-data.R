library(tidyverse)

hcw_data_raw <- read_delim("data/hcw-data.txt", "\t", escape_double = FALSE, col_names = FALSE, trim_ws = TRUE) %>%
  set_names("Hong Kong", "Australia",  "Austria", "Canada", "Denmark", "Finland", "France",
            "Germany", "Italy", "Japan", "Korea", "Mexico", "Netherlands", "New Zealand",
            "Norway", "Switzerland", "United Kingdom", "United States", "Singapore",
            "Philippines", "Indonesia", "Malaysia", "Thailand", "Taiwan", "China")

date <- c("1993Q1", "1993Q2", "1993Q3", "1993Q4", "1994Q1", "1994Q2", "1994Q3", "1994Q4", "1995Q1", "1995Q2",
          "1995Q3", "1995Q4", "1996Q1", "1996Q2", "1996Q3", "1996Q4", "1997Q1", "1997Q4", "1997Q1", "1997Q4",
          "1998Q1", "1998Q2", "1998Q3", "1998Q4", "1999Q1", "1999Q2", "1999Q3", "1999Q4", "2000Q1", "2000Q2",
          "2000Q3", "2000Q4", "2001Q1", "2001Q2", "2001Q3", "2001Q4", "2002Q1", "2002Q2", "2002Q3", "2002Q4",
          "2003Q1", "2003Q2", "2003Q3", "2003Q4", "2004Q1", "2004Q2", "2004Q3", "2004Q4", "2005Q1", "2005Q2",
          "2005Q3", "2005Q4", "2006Q1", "2006Q2", "2006Q3", "2006Q4", "2007Q1", "2007Q2", "2007Q3", "2007Q4",
          "2008Q1")

hcw_data <- hcw_data_raw %>%
  cbind(date)

devtools::use_data(hcw_data)
