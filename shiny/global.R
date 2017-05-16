seasons <- c("2012-2013", "2012-2013", "2014-2015", "2015-2016", "2016-2017")
season_series <- all_series[all_series$Season == head(seasons, 1), ]$Show
get_season <- function(full_season) {
  season <- gsub("(20\\d{2})\\-20(\\d{2})", "\\1_\\2", full_season)
}

