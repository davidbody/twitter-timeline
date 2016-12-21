library(dplyr)
library(ggplot2)
library(purrr)
library(tidyr)
library(twitteR)

source("credentials.R")

setup_twitter_oauth(getOption("twitter_consumer_key"),
                    getOption("twitter_consumer_secret"),
                    getOption("twitter_access_token"),
                    getOption("twitter_access_token_secret"))

#' Returns a data frame containing your Twitter timeline
#'
#' Generates error or warnings based on results of API call.
#'
#' The most common errors are from rate limits.
#'
#' @param n Integer number of tweets to retreive.
#'
#' @return Returns a data frame containing tweet data.
#'
#' @example
#' home_timeline_df <- get_homeTimeline(n = 100)
get_homeTimeline <- function(n = 200) {
    # retreives tweets in batches of 200
    num_to_get <- min(200, n)
    message("getting first ", num_to_get)
    tryCatch(
        home_timeline <- homeTimeline(n = num_to_get),

        error = function(e) {
            stop(e)
        },
        warning = function(w) {
            stop(w)
        }
    )

    done <- FALSE

    while (!done && length(home_timeline) < n) {
        num_to_get <- min(200, n - length(home_timeline))
        last_id <- last(home_timeline)$id
        message("getting next ", num_to_get)
        tryCatch(
            home_timeline <- c(home_timeline, homeTimeline(n = num_to_get, maxID = last_id)),

            error = function(e) {
                message("An error occurred:\n", e)
                done <<- TRUE
            },

            warning = function(w) {
                message("A warning occurred:\n", w)
                done <<- TRUE
            }
        )
    }
    tbl_df(map_df(home_timeline, as.data.frame))
}

# Retreive 750 most recent tweets
home_timeline_df <- get_homeTimeline(n = 750)

# save(home_timeline_df, file = "home_timeline_df.RData")
# load("home_timeline_df.RData")

# Group by screenName and count tweets, retweets, and replies, and sort in descending order of total tweets
report <- home_timeline_df %>%
    group_by(screenName) %>%
    summarize(total = n(), retweets = sum(isRetweet), replies = length(which(!is.na(replyToSID))), tweets = total - retweets - replies) %>%
    arrange(-total) %>%
    select(screenName, tweets, retweets, replies, total)

# Put data on the top 20 tweeters in long format for plotting
long_report <- report[1:20,] %>% select(-total) %>% gather(type, count, -screenName)

# Plot the top tweeters from the timeline
g <- ggplot(long_report, aes(x = reorder(screenName, count), y = count))
g <- g + geom_bar(stat = "identity", aes(fill = type))
g <- g + coord_flip()
g
