# Visualization and Analytics for 2022 GSRI Survey Respondents
# Joe Lollo, UW Libraries

# Import all relevant R Libraries:
install.packages("tidyverse")
install.packages("ggplot2")
install.packages("plotly")
library("tidyverse")
library("ggplot2")
library("plotly")

# Load 2022 survey as CSV:
responses_df <- read.csv("https://raw.githubusercontent.com/ChessPiece21/GSRI-SurveyReview/main/data/GSRI-2022-Refined.csv", stringsAsFactors = FALSE)

# Create new data frame of the student population.
# Group it by discipline and field:
studentPop_df <- responses_df %>% group_by(Discipline, Field) %>% summarize(count = n())

# Visualize respondents by discipline and field/area of study:
studentPop_plot <- ggplot(studentPop_df) + 
  geom_col(aes(x = Discipline, y = count, fill = Field)) + 
  labs(title = "GSRI 2022 Survey Respondents, by Discipline and Field", x = "Discipline", y = "Number of Students", fill = "Area of Study")

ggplotly(studentPop_plot)

# Mostly STEM and social science students!
# Also, LIS is represented well!
# Arts/humanities students, though...:(

# Create new data frame of sessions attended.
# Group by each session:
session_df <- responses_df %>% group_by(Session, Engagement.Style) %>% summarize(count = n())

# Visualize respondents by session/option attended in a stacked bar chart:
session_plot <- ggplot(session_df) +
  geom_col(aes(x = Session, y = count, fill = Engagement.Style)) +
  labs(title = "GSRI 2022 Survey Respondents, by Session Attended", x = "Session", y = "Number of Students")

ggplotly(session_plot)

# Equal number of respondents per session, but this is only half of the enrolled grad students.
# More asynchronous respondents in the second session -- is this accurate to all of GSRI? Try to connect this with the broader student population (registered).
