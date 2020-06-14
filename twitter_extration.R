library("rtweet")    # Get data from Twitter
library("httpuv")    # Authentication via browser
library("tidyverse") # Data manipulation & visualization
library("scales")    # Customize plot axes
library("igraph")    # For Social Network Analysis
library("UpSetR")    # For upset plot
library("maps")
library("twitteR")
library("psych")
library("plyr")
setwd("/Users/rachelmartonik/MSDS_498_Capstone")

#R.home(component="home")

# To set Google Maps Key
#Sys.setenv(GOOGLE_MAPS_KEY = "AIzaSyBPYBcUqmmL74x1ANY-Bg4unGDpvPh5eaA")
#Sys.getenv("GOOGLE_MAPS_KEY")
#rtweet:::find_google_geocode_key()


#COVID TWEETS w/in 25 miles of FFX county center
#ffx <- search_tweets( q="#COVID",
  #geocode = "38.9085,-77.2405,25mi", n = 100
#)
#ffx['location']
#count(ffx$location)

##############################################################################
################## Virginia COVID PULL #######################################
##############################################################################
va_coords <- rtweet::lookup_coords("Virginia, US", 
                      apikey = "AIzaSyBPYBcUqmmL74x1ANY-Bg4unGDpvPh5eaA")

va_pull <- search_tweets(q="#COVID OR COVID OR COVID-19 OR #COVID-19 OR coronavirus OR #coronavirus",
                                         geocode = va_coords,
                                         include_rts = FALSE,
                                         n = 50000, 
                                         retryonratelimit = TRUE
)
va_pull['location']
count(va_pull$location)
count(va_pull$is_retweet)
count(va_pull$coords_coords)
sum(is.na(va_pull$geo_coords))
va_pull['text'][,1]

#Separate date and time from "created_at"
out <- strsplit(as.character(va_pull$created_at),' ') 
do.call(rbind, out)
va_pull <- data.frame(va_pull, do.call(rbind, out))

count(va_pull$X1)
count(va_pull$X2)

va_pull[order(va_pull$X2),]
head(va_pull)
tail(va_pull)

file_name = "va_pull_0426"
#Save file to folder - going to read into Python
save_as_csv(va_pull, file_name, prepend_ids = TRUE, na = "",
            fileEncoding = "UTF-8")

##############################################################################
################## Virginia Stay at Home PULL ################################
##############################################################################
va_stayathome <- search_tweets(q="#stayhome OR #stayathome OR #Quarantine OR quarantine OR #SocialDistancing",
                         geocode = va_coords,
                         include_rts = FALSE,
                         n = 50000,
                         retryonratelimit = TRUE
)

#Separate date and time from "created_at"
out <- strsplit(as.character(va_stayathome$created_at),' ') 
do.call(rbind, out)
va_stayathome <- data.frame(va_stayathome, do.call(rbind, out))

count(va_stayathome$X1)
count(va_stayathome$X2)



file_name = "va_stay_0426"
#Save file to folder - going to read into Python
save_as_csv(va_stayathome, file_name, prepend_ids = TRUE, na = "",
            fileEncoding = "UTF-8")


##############################################################################
################## Northam PULL ################################
##############################################################################
va_northam <- search_tweets(q="#northam OR northam",
                               geocode = va_coords,
                               include_rts = FALSE,
                               n = 80000,
                               retryonratelimit = TRUE
)

#Separate date and time from "created_at"
out <- strsplit(as.character(va_northam$created_at),' ') 
do.call(rbind, out)
va_northam <- data.frame(va_northam, do.call(rbind, out))

count(va_northam$X1)
count(va_northam$X2)


file_name = "va_northam_0416"
#Save file to folder - going to read into Python
save_as_csv(va_northam, file_name, prepend_ids = TRUE, na = "",
            fileEncoding = "UTF-8")

##############################################################################
################## USA Stay at Home PULL ################################
##############################################################################

usa_coords <- rtweet::lookup_coords("USA", 
                                   apikey = "AIzaSyBPYBcUqmmL74x1ANY-Bg4unGDpvPh5eaA")
usa_stayathome <- search_tweets(q="#stayhome, #stayathome, #Quarantine, #SocialDistancing",
                               geocode = usa_coords,
                               include_rts = FALSE,
                               n = 100000, 
                               retryonratelimit = TRUE
)

file_name = "usa_stay_0407"
#Save file to folder - going to read into Python
save_as_csv(va_stayathome, file_name, prepend_ids = TRUE, na = "",
            fileEncoding = "UTF-8")

#Separate date and time from "created_at"
out <- strsplit(as.character(va_stayathome$created_at),' ') 
do.call(rbind, out)
va_stayathome <- data.frame(va_stayathome, do.call(rbind, out))

count(va_stayathome$X1)
count(va_stayathome$X2)

va_stayathome[order(va_stayathome$X2),]
head(va_stayathome)
tail(va_stayathome)



################################################################################
#Map the tweets
va_coords_map <- lat_lng(va_pull)
par(mar = c(0, 0, 0, 0))
maps::map("state", fill = TRUE, col = "#ffffff", 
          lwd = .25, mar = c(0, 0, 0, 0), 
          xlim = c(-86, -76), y = c(35, 41))
with(va_coords_map, points(lng, lat, pch = 20, col = "red"))


# Fairfax  overall
ffx_coords <- rtweet::lookup_coords("Fairfax, VA, US", 
                                   apikey = "AIzaSyBPYBcUqmmL74x1ANY-Bg4unGDpvPh5eaA")

ffx_pull <- search_tweets( q="#COVID, COVID, COVID-19, coronavirus",
                          geocode = va_coords,
                          include_rts = FALSE,
                          n = 1000
)
ffx_pull['location']
count(ffx_pull$location)
count(ffx_pull$is_retweet)
count(ffx_pull$coords_coords)

ffx_pull['text'][,1]

#Map the tweets
va_coords_map <- lat_lng(ffx_pull)
par(mar = c(0, 0, 0, 0))
maps::map("state", fill = TRUE, col = "#ffffff", 
          lwd = .25, mar = c(0, 0, 0, 0), 
          xlim = c(-86, -76), y = c(35, 41))
with(va_coords_map, points(lng, lat, pch = 20, col = "red"))


# Harrisonburg overall
hb_coords <- rtweet::lookup_coords("West Virginia, US", 
                                    apikey = "AIzaSyBPYBcUqmmL74x1ANY-Bg4unGDpvPh5eaA")

hb_pull <- search_tweets( q="#COVID",
                           geocode = va_coords,
                           include_rts = FALSE,
                           n = 1000
)
hb_pull['location']
count(hb_pull$location)
count(hb_pull$is_retweet)
count(hb_pull$coords_coords)

hb_pull['text'][,1]

#Map the tweets
va_coords_map <- lat_lng(hb_pull)
par(mar = c(0, 0, 0, 0))
maps::map("state", fill = TRUE, col = "#ffffff", 
          lwd = .25, mar = c(0, 0, 0, 0), 
          xlim = c(-86, -76), y = c(35, 41))
with(va_coords_map, points(lng, lat, pch = 20, col = "yellow"))


# Stream Tweets

## stream london tweets for a week (60 secs x 60 mins * 24 hours *  7 days)
stream_tweets(
  "realdonaldtrump,trump",
  timeout = 60 * 60 * 24 * 7,
  file_name = "tweetsabouttrump.json",
  parse = FALSE
)

## read in the data as a tidy tbl data frame
djt <- parse_stream("tweetsabouttrump.json")

## stream london tweets for a week (60 secs x 60 mins * 24 hours *  7 days)
stream_tweets(
  "realdonaldtrump,trump",
  timeout = 60 * 60 * 24 * 7,
  file_name = "tweetsabouttrump.json",
  parse = FALSE
)

## read in the data as a tidy tbl data frame
djt <- parse_stream("tweetsabouttrump.json")
