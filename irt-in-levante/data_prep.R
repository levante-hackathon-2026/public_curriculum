# for reference, this is the script that loads real mental rotation data and
# subsets it to one response per participant per item to avoid complex data
# wrangling / model set up

library(levante)
library(tidyverse)

trials_pilot <- get_trials(data_source = "levante-data-pilots-hackathon:fpx0")

trials_mrot <- trials_pilot |> filter(item_task == "mrot")

trials_mrot_subset <- trials_mrot |>
  group_by(run_id, item_uid) |>
  arrange(timestamp) |>
  slice(1) |>
  ungroup() |>
  select(dataset, run_id, item_uid, correct) |>
  mutate(run_id = consecutive_id(run_id))

write_rds(trials_mrot_subset, "data/trials_mrot.rds", compress = "gz")
