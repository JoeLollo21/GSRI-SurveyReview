# Visualization and Analytics for 2022 GSRI Survey Respondents
# Joe Lollo, UW Libraries

# Import all relevant R Libraries (installation is once per machine):
#install.packages("tidyverse")
#install.packages("ggplot2")
#install.packages("plotly")
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

# Equal number of respondents per session, but this is only half of the enrolled grad students across the 2022 GSRI sessions.

# More asynchronous respondents in the second session -- is this accurate to all of GSRI? Try to connect this with the broader student population (registered).

# Create new data frame of satisfaction with GSRI.
# Group by satisfaction levels with Slack and Canvas.
slack_df <- responses_df %>% group_by(Session, Satisfied.Slack) %>% summarize(count = n())

canvas_df <- responses_df %>% group_by(Session, Satisfied.Canvas) %>% summarize(count = n())

# Exclude blank values.
slack_df <- slack_df %>% filter(Satisfied.Slack != "")

canvas_df <- canvas_df %>% filter(Satisfied.Canvas != "")

# This is a smaller sample than this smaller sample! But it still works...

# Visualize responses.
slack_plot <- ggplot(slack_df) + geom_col(aes(x = Satisfied.Slack, y = count, fill = Session)) +
  labs(title = "GSRI 2022 Survey Respondents' Satisfaction with Slack", x = "Indicator", y = "Number of Students")

ggplotly(slack_plot)

canvas_plot <- ggplot(canvas_df) + geom_col(aes(x = Satisfied.Canvas, y = count, fill = Session)) +
  labs(title = "GSRI 2022 Survey Respondents' Satisfaction with Canvas", x = "Indicator", y = "Number of Students")
