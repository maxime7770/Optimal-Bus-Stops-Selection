# File to visualize our optimization results on top of the map.
# Adapted from old code from Hayden's RA @ UW SCTL Center, 8/3/2021

# load packages
library(tidyverse)
library(dplyr)
library(lubridate)
library(ggmap)
library(ggplot2)
library(leaflet)
library(stringr)
library(readr)
library(htmlwidgets) 


# set working directory
dir <- "/Users/haydenratliff/Documents/School/MIT/Fall/15.093 Optimization Methods/bus_routing_project" # Hayden opt project directory
setwd(dir)


plot_route <- function(route_id, lambda) {
  # function to plot the selected route
  
  # read in data
  # NOTE: we can get the no consecutive drops files by manually changing the location here and 
  # manually changing the output location below
  route_optimal <- read_csv(paste0("key_routes_grouped_results/route_", route_id, "_with_results.csv"), show_col_types=FALSE)

  
  col <- paste0("lambda_", lambda)
  
  # function to determine color
  # 10 + 20 * lambda retrieves the correct column since the step of lambda is 0.05
  getColor <- function(route_optimal) {
    sapply(route_optimal$lambda_0.1, function(lambda_k) {
      if(lambda_k == 1) {
        "green"
      } else {
        "red"
      } })
  }
  
  # decide icons
  icons <- awesomeIcons(
    icon = 'ios-close',
    iconColor = 'black',
    library = 'ion',
    #markerColor = "green"
    markerColor = getColor(route_optimal),
  )
  # could improve this by changing the size of icons
  
  mm <- leaflet(route_optimal) %>%
    # create leaflet plot
    addTiles() %>%
    # add markers for each stop
    addAwesomeMarkers(~X, ~Y, icon=icons, label=~Stop_Name)

  for (i in 1:(nrow(route_optimal)-1)) {
    mm <- mm %>% addPolylines(lat = ~Y, lng = ~X, data=route_optimal[i:(i+1),], color = "black")
    # add the lines between points - in this case, the lines are black
    #mm <- mm %>% addPolylines(lat = ~lat, lng = ~lon, data=tmp[i:(i+1),], color = ~coll[i])
    # add the lines between points - in this case, the color corresponds to the time
    # NOTE: when plotting just drive or park segments, there are lines that connect
    # different segments together. This could be improved to remove those lines in the future.
  }
  
  saveWidget(mm, file = paste0("maps/route_", route_id, "_lambda_", lambda, ".html") )
  #saveWidget(mm, file = paste0("maps/route_", route_id, "_all_green.html") )
  
  return (mm)
}

plot_route_time_period <- function(lambda, time_period) {
  # function to plot the selected route
  
  # read in data
  route_optimal <- read_csv("key_routes_time_periods_results/data_route1_time_periods_opt.csv", show_col_types=FALSE)
  
  route_filtered <- route_optimal %>%
    filter(time_period_id == time_period)
  
  #View(route_filtered)
  
  
  col <- paste0("lambda_", lambda)
  
  # function to determine color
  # 10 + 20 * lambda retrieves the correct column since the step of lambda is 0.05
  getColor <- function(route_filtered) {
    sapply(route_filtered$lambda_0.5, function(lambda_k) {
      if(lambda_k == 1) {
        "green"
      } else {
        "red"
      } })
  }
  
  # decide icons
  icons <- awesomeIcons(
    icon = 'ios-close',
    iconColor = 'black',
    library = 'ion',
    markerColor = getColor(route_filtered)
  )
  
  mm <- leaflet(route_filtered) %>%
    # create leaflet plot
    addTiles() %>%
    # add markers for each stop
    addAwesomeMarkers(~X, ~Y, icon=icons, label=~Stop_Name)
  
  for (i in 1:(nrow(route_filtered)-1)) {
    mm <- mm %>% addPolylines(lat = ~Y, lng = ~X, data=route_filtered[i:(i+1),], color = "black")
    # add the lines between points - in this case, the lines are black
    #mm <- mm %>% addPolylines(lat = ~lat, lng = ~lon, data=tmp[i:(i+1),], color = ~coll[i])
    # add the lines between points - in this case, the color corresponds to the time
    # NOTE: when plotting just drive or park segments, there are lines that connect
    # different segments together. This could be improved to remove those lines in the future.
  }
  
  saveWidget(mm, file = paste0("maps/route_", route_id, "_", time_period, "_lambda_", lambda, ".html"))
  
  return (mm)
}

plot_multiple_routes <- function(routes, lambda) {
  # read in data
  
  # initialize map
  mm <- leaflet() %>%
    # create leaflet plot
    addTiles()
  
  
  for (route_id in routes) {
    # NOTE: we can get the no consecutive drops files by manually changing the location here and 
    # manually changing the output location below
    route_optimal <- read_csv(paste0("key_routes_grouped_results/route_", route_id, "_with_results.csv"), show_col_types=FALSE)
    
    # function to determine color
    # 10 + 20 * lambda retrieves the correct column since the step of lambda is 0.05
    getColor <- function(route_optimal) {
      sapply(route_optimal$lambda_0.75, function(lambda_k) {
        if(lambda_k == 1) {
          "green"
        } else {
          "red"
        } })
    }
    
    # decide icons
    icons <- awesomeIcons(
      icon = 'ios-close',
      iconColor = 'black',
      library = 'ion',
      markerColor = getColor(route_optimal)
    )
    
    mm <- 
      # add markers for each stop
      addAwesomeMarkers(~X, ~Y, data=route_optimal, icon=icons, label=~Stop_Name)
    
    for (i in 1:(nrow(route_optimal)-1)) {
      mm <- mm %>% addPolylines(lat = ~Y, lng = ~X, data=route_optimal[i:(i+1),], color = "black")
      # add the lines between points - in this case, the lines are black
      #mm <- mm %>% addPolylines(lat = ~lat, lng = ~lon, data=tmp[i:(i+1),], color = ~coll[i])
      # add the lines between points - in this case, the color corresponds to the time
      # NOTE: when plotting just drive or park segments, there are lines that connect
      # different segments together. This could be improved to remove those lines in the future.
    }
  }
  
  saveWidget(mm, file = paste0("maps/route_", "TEST", "_lambda_", lambda, ".html") )
  
  return (mm)
}


key_routes = c(1, 15, 22, 23, 28, 32, 39, 57, 66, 71, 73, 77, 111, 116, 117)

# decide route_id and lambda
route_id <- 1
routes <- c(1)
lambda = 0.1
time_period = "time_period_01"

# plot route
plot_route(route_id, lambda)

#plot_multiple_routes(routes, lambda)

# time_periods = c("time_period_01", "time_period_02", "time_period_03", "time_period_04",
#                  "time_period_05", "time_period_06", "time_period_07", "time_period_08",
#                  "time_period_09", "time_period_10", "time_period_11")
# 
# for (time_period in time_periods) {
#   plot_route_time_period(lambda, time_period)
#   print(time_period)
# }