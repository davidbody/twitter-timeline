library(dplyr)
library(ggplot2)
library(purrr)
library(tidyr)
library(rtweet)

# source("credentials.R")

# token <- create_token(app = "R apps API",
#                       consumer_key = getOption("twitter_consumer_key"),
#                       consumer_secret = getOption("twitter_consumer_secret"))

# Retreive 750 most recent tweets
timeline <- get_my_timeline(n = 750)

filename <- paste0("./data/timeline-", format(Sys.Date(), "%Y%m%d"), ".RData")
# save(timeline, file = filename)
# load(filename)

report <- timeline %>%
  group_by(screen_name) %>%
  summarize(total = n(), retweets = sum(is_retweet), replies = length(which(!is.na(reply_to_user_id))), tweets = total - retweets - replies) %>%
  arrange(-total) %>%
  select(screen_name, tweets, retweets, replies, total)

# Put data on tweeters constituting 1% or more of timeline in long format for plotting
total_tweets <- as.integer(count(timeline))
one_percent_of_tweets <- as.integer(total_tweets / 100)
long_report <- report %>% filter(total >= one_percent_of_tweets) %>% select(-total) %>% gather(type, count, -screen_name)
long_report$percent <- long_report$count / total_tweets

# Plot the top tweeters from the timeline
g <- ggplot(long_report, aes(x = reorder(screen_name, percent), y = percent))
g <- g + geom_bar(stat = "identity", aes(fill = type))
g <- g + labs(title = "Tweeters constituting 1% or more of timeline", y = "Percent of tweets in timeline", x = "Screen name")
g <- g + scale_y_continuous(labels = scales::percent)
g <- g + coord_flip()
g
