Sys.setenv("VROOM_CONNECTION_SIZE" = 256000)

library(remotes)
# install_github('jyablonski/practice_package')
# install_github("d-edison/theoddsapi")
devtools::install_github("abresler/nbastatR")
library("nbastatR")
# library(theoddsapi)

library(nbastatR)
library(tidyverse)
library(ggthemes)
library(jsonlite)
library(httr)
library(rvest)
library(scales)
library(shiny)
# library(shinythemes)
# library(shinyWidgets)
# library(shinyjs)
library(writexl)

assign_nba_players()
assign_nba_teams()
# useShinyjs()

# path = "C:/Users/jdrury/OneDrive - Mathematica/Documents/3_Projects/NBA Analysis/"
# setwd(path)





