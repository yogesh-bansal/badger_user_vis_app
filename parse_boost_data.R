## Loading libraries
library(jsonlite)
library(lubridate)
library(readr)
library(dplyr)

# ## Read in data
# setwd("~/Desktop/badger_user_vis/data/boosts")
# file_names <- list.files()
# boost_data <- data.frame()
# for(idx in 1:length(file_names))
# {
# 	data_t <- fromJSON(file_names[idx])$userData
# 	if(!("stakeRatio" %in% names(data_t[[1]]))) next()
# 	data_df <- data.frame(
# 							Time = as_datetime(abs(parse_number(file_names[idx]))),
# 							User = names(data_t),
# 							Boost = sapply(data_t,function(x) x$boost),
# 							NativeBalance = sapply(data_t,function(x) x$nativeBalance),
# 							NonNativeBalance = sapply(data_t,function(x) x$nonNativeBalance),
# 							StakeRatio = sapply(data_t,function(x) x$stakeRatio)
# 						)
# 	rownames(data_df) <- NULL
# 	boost_data <- rbind(boost_data,data_df)
# 	message(idx)
# 	message(nrow(boost_data))
# }
# write_csv(boost_data,"~/Desktop/badger_user_vis/data/boosts_users.csv")

## Read in data
setwd("~/Desktop/badger_user_vis/data/boosts")
file_names <- list.files()
boost_data <- data.frame()
for(idx in 1:length(file_names))
{
	data_t <- fromJSON(file_names[idx])$userData
	if(!("stakeRatio" %in% names(data_t[[1]]))) next()
	data_df <- data.frame(
							Time = as_datetime(abs(parse_number(file_names[idx]))),
							User = names(data_t),
							Boost = sapply(data_t,function(x) x$boost),
							NativeBalance = sapply(data_t,function(x) x$nativeBalance),
							NonNativeBalance = sapply(data_t,function(x) x$nonNativeBalance),
							StakeRatio = sapply(data_t,function(x) x$stakeRatio)
						)
	rownames(data_df) <- NULL
	data_df <- data_df[data_df$NativeBalance>0,]
	data_df <- data_df[data_df$NonNativeBalance>0,]
	boost_data <- rbind(boost_data,data_df)
	message(idx)
	message(nrow(boost_data))
}
write_csv(boost_data,"~/Desktop/badger_user_vis/data/boosts_users_2.csv")



