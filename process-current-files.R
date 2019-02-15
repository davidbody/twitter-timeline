library(tidyverse)
library(here)

files <- list.files(here("data"), pattern = "timeline-")

dfs <- vector("list", length(files))

for (i in seq_along(files)) {
  file <- here("data", files[[i]])
  print(str_glue("Loading {file}"))
  load(file)
  dfs[[i]] <- timeline
}

timeline_df <- bind_rows(dfs)

# filter on unique status_id
timeline_df <- timeline_df %>%
  group_by(status_id) %>%
  slice(1L) %>%
  ungroup()

save(timeline_df, file="current-timeline.RData")
