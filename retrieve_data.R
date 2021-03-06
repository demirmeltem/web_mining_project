library(XML)
library(httr)

series_seasons = c("2012_13", "2013_14", "2014_15", "2015_16", "2016_17")
series_urls <- list("https://docs.google.com/spreadsheets/d/15y9Yi_ypBd8aJSb6h-xvXoAW6Io5X4MNKyxfE-tQ3zk/pubhtml/sheet?hl=en_GB&headers=false&gid=0",
                    "https://docs.google.com/spreadsheets/d/1GNctAKy1UATkrAdHjC_nvGvtSBivrsUC0hv060I_i64/pubhtml/sheet?hl=en_GB&headers=false&gid=0",
                    "https://docs.google.com/spreadsheets/d/1nTCF0Nl3ziZeubamDKImnUaITwgA3ar3SipUC-9xt4g/pubhtml/sheet?headers=false&gid=2145367600&range=A1:AC106",
                    "https://docs.google.com/spreadsheets/d/1D9-DyxF5Qfb2wCmD66htfa5VICjtCOD_sRnM8JC5xw8/pubhtml/sheet?headers=false&gid=2145367600&range=A1:AC106",
                    "https://docs.google.com/spreadsheets/d/1XydtIiNi0xXzht8ZRROHSm7L12B44Is7wbPg4DqElUw/pubhtml/sheet?headers=false&gid=2145367600&range=A1:AC112"
)
col <- c('Show','Network','1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','AveragePerEpisode','Loss_Gain','Drop')
all_series = data.frame()
for(i in 1:length(series_urls)){
  URL <- GET(paste(series_urls[i]))
  one_series <- readHTMLTable(rawToChar(URL$content))[[1]]
  one_series <- one_series[c(-1,-2),]
  one_series <- one_series[,c(-1,-4)]
  one_series <- one_series[, 1:29]
  colnames(one_series) <- col
  one_series$Season <- series_seasons[i]
  all_series <- rbind(all_series, one_series)
  Sys.sleep(1)
}

all_series <- all_series[-which(all_series$Show == "Coach" & all_series$Season == "2015_16"),]
all_series[, 'AveragePerEpisode'] <- as.numeric(as.character(all_series[, 'AveragePerEpisode']))
all_series[, 'Show'] <- as.character(all_series[, 'Show'])
all_series[, 'Network'] <- as.character(all_series[, 'Network'])
all_series[, 'Loss_Gain'] <-as.numeric(as.character(all_series[, 'Loss_Gain']))
all_series[, 'Drop'] <-as.numeric(as.character(all_series[, 'Drop']))
all_series[, 'Season'] <-as.character(all_series[, 'Season'])

# for(i in 1:length(all_series$Show)){
#   for(j in 3:26){
#     all_series[i, j] <- as.double(as.character(all_series[i, j]))
#   }
#   
# }




