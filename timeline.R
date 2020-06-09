library(tidyverse)
library(lubridate)
library(rtweet)

# Retreive 750 most recent tweets
timeline <- get_my_timeline(n = 750)

filename <- paste0("./data/timeline-", format(Sys.Date(), "%Y%m%d"), ".RData")
if (!file.exists(filename)) {
  save(timeline, file = filename)
}
# load(filename)

report <- timeline %>%
  group_by(screen_name) %>%
  summarize(total = n(), retweets = sum(is_retweet), replies = length(which(!is.na(reply_to_user_id))), tweets = total - retweets - replies) %>%
  arrange(-total) %>%
  select(screen_name, tweets, retweets, replies, total)

# Put data on tweeters constituting 1% or more of timeline in long format for plotting
total_tweets <- as.integer(count(timeline))
one_percent_of_tweets <- round(total_tweets / 100)
long_report <- report %>%
  filter(total >= one_percent_of_tweets) %>%
  select(-total) %>%
  gather(type, count, -screen_name)
long_report$percent <- long_report$count / total_tweets

plot_report <- function(report, title) {
  report %>%
    ggplot(aes(x = reorder(screen_name, percent), y = percent)) +
    geom_bar(stat = "identity", aes(fill = type)) +
    labs(title = title, y = "Percent of tweets in timeline", x = "Screen name") +
    scale_y_continuous(labels = scales::percent) +
    coord_flip()
}

g <- long_report %>%
  plot_report("Tweeters constituting 1% or more of timeline")

# Tweets for the last one day
one_day <- timeline %>% filter(created_at > max(created_at) - ddays(1))

one_day_report <- one_day %>%
  group_by(screen_name) %>%
  summarize(total = n(), retweets = sum(is_retweet), replies = length(which(!is.na(reply_to_user_id))), tweets = total - retweets - replies) %>%
  arrange(-total) %>%
  select(screen_name, tweets, retweets, replies, total)

# Put data on tweeters constituting 1% or more of one-day timeline in long format for plotting
total_tweets_one_day <- as.integer(count(one_day))
one_percent_of_one_day <- round(total_tweets_one_day / 100)
long_one_day_report <- one_day_report %>%
  filter(total >= one_percent_of_one_day) %>%
  select(-total) %>%
  gather(type, count, -screen_name)
long_one_day_report$percent <- long_one_day_report$count / total_tweets_one_day

g_hours <- one_day %>%
  ggplot(aes(x = hour(created_at))) +
  geom_bar()

g1 <- long_one_day_report %>%
  plot_report("Top tweeters for the last day")
