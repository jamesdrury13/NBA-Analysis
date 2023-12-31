# get player shooting charts for a specific game

season <- 2022

load(paste0(path, "/Data/games_player_team_", season, ".Rdata"))

d <- games_player_team


### all shooting stats

both_team_shooting_barplot <- function() {

  d %>%
    filter(dateGame == "2021-10-30" &
           (slugTeam == "UTA" |
           slugOpponent == "UTA")) %>%
    arrange(slugTeam) %>%
    group_by(slugTeam) %>%
    top_n(n = 3, wt = pts) %>%
    ungroup() %>%
    pivot_longer(cols = c("fga", "fgm", "fta", "ftm", "fg2a", "fg2m", "fg3m", "fg3a"), 
                 names_to = "made_miss",
                 values_to = "value") %>%
    mutate(shot_type = case_when(
      made_miss %in% c("fga", "fgm") ~ "All FGs",
      made_miss %in% c("fg2a", "fg2m") ~ "2-pt FGs",
      made_miss %in% c("fg3a", "fg3m") ~ "3-pt FGs",
      made_miss %in% c("fta", "ftm") ~ "FTs"
    )) %>%
    ggplot(aes(x = shot_type, y = value)) +
    geom_bar(data = . %>% filter(made_miss %in% c("fg3a", "fg2a", "fta")),
             aes(fill = "Shots taken"),
             color = "darkolivegreen3",
             alpha = 0.5,
             stat = "identity",
             position = "dodge") +
    geom_bar(data = . %>% filter(made_miss %in% c("fg3m", "fg2m", "ftm")),
             aes(fill = "Shots made"),
             stat = "identity",
             position = "dodge") +
    facet_wrap(namePlayer ~ pts) +
    theme_minimal() +
    scale_fill_manual(values = c("Shots made" = "darkolivegreen3", 
                                 "Shots taken" = "gray")) +
    labs(x = "",
         y = "Shots",
         fill = "")
  
}

team_shooting_barplot <- function(date, team, n) {

  d %>%
    filter(dateGame == date &
             nameTeam == team) %>%
    top_n(n = n, wt = pts) %>%
    pivot_longer(cols = c("fga", "fgm", "fta", "ftm", "fg2a", "fg2m", "fg3m", "fg3a"), 
                 names_to = "made_miss",
                 values_to = "value") %>%
    mutate(shot_type = case_when(
      made_miss %in% c("fga", "fgm") ~ "All FGs",
      made_miss %in% c("fg2a", "fg2m") ~ "2-pt FGs",
      made_miss %in% c("fg3a", "fg3m") ~ "3-pt FGs",
      made_miss %in% c("fta", "ftm") ~ "FTs"
    )) %>%
    ggplot(aes(x = shot_type, y = value)) +
    geom_bar(data = . %>% filter(made_miss %in% c("fg3a", "fg2a", "fta")),
             aes(fill = "Shots taken"),
             color = "darkolivegreen3",
             alpha = 0.5,
             stat = "identity",
             position = "dodge") +
    geom_bar(data = . %>% filter(made_miss %in% c("fg3m", "fg2m", "ftm")),
             aes(fill = "Shots made"),
             stat = "identity",
             position = "dodge") +
    facet_grid(~namePlayer) +
    theme_minimal() +
    scale_fill_manual(values = c("Shots made" = "darkolivegreen3", 
                                 "Shots taken" = "gray")) +
    labs(x = "",
         y = "Shots",
         fill = "")
}

team_shooting_barplot("2021-10-30", "Utah Jazz", 2)
