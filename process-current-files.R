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
timeline_df <- unique(timeline_df)

save(timeline_df, file="current-timeline.RData")
