library(here)

files <- list.files(here("old-data"), pattern = "home_timeline_df")

timeline_df <- data.frame()

invisible(lapply(files, function(file) {
  file <- here("old-data", file)
  load(file)
  timeline_df <<- rbind(timeline_df, home_timeline_df)
}))

timeline_df <- unique(timeline_df)

save(timeline_df, file="old-timeline.RData")
