## Load libraries
library(readr)
library(lubridate)
library(ggridges)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(scales)
library(grid)
library(dplyr)
library(shinycssloaders)


## Read in data
user_data <- read_csv("data/boosts_users_2.csv",show_col_types=FALSE)
user_data$Time <- as.Date(user_data$Time)


function(input, output, session)
{
	output$date_ui <- renderUI({
									dateRangeInput(
													"daterange", NULL,#h4("Date range:"),
                 									min = min(as.Date(user_data$Time)),
                 									max   = max(as.Date(user_data$Time)),
                 									start = min(as.Date(user_data$Time)),
                 									end = max(as.Date(user_data$Time))
                 					)
						})

	output$gridplot <- renderPlot({
									if(is.null(input$daterange)) return(NULL)

									## Subset on Date
									user_data <- user_data[user_data$Time > input$daterange[1],]
									user_data <- user_data[user_data$Time < input$daterange[2],]
									user_data$Time <- as.factor(format(user_data$Time,"%m-%d"))

									## RidgePlot StakeRatio
									p1 <- ggplot(user_data, aes(x = StakeRatio, y = Time, fill = ..x..)) +
											geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01,quantile_lines = TRUE, quantiles = 2) +
											scale_fill_viridis()+
											# labs(title = "Stake Ratio Spread Change over Time") +
											xlab("Stake Ratio\n") +
											scale_x_log10(breaks = c(.0001,.01,.1,1,10,100,10000),labels = c(".0001",".01",".1","1","10","100","10000"))+
											theme(
													axis.text.y = element_text(color = "grey20", size = 10, hjust = .5, vjust = .5, face = "plain"),
													axis.title.y=element_text(size=12,face="bold",hjust = .5),
													axis.text.x = element_blank(),
													axis.title.x = element_blank(),
													legend.position="none",
													panel.spacing = unit(0.1, "lines"),
													plot.background = element_blank()
												)+
											coord_flip()

									## RidgePlot NativeBalance
									p2 <- ggplot(user_data, aes(x = NativeBalance, y = Time, fill = ..x..)) +
											geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01,quantile_lines = TRUE, quantiles = 2) +
											scale_fill_viridis()+
											# labs(title = "Native Balance Spread Change over Time") +
											xlab("Native Balance\n") +
											scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),labels = trans_format("log10", math_format(10^.x)))+
											theme(
													axis.text.y = element_text(color = "grey20", size = 10, hjust = .5, vjust = .5, face = "plain"),
													axis.title.y=element_text(size=12,face="bold",hjust = .5),
													axis.text.x = element_blank(),
													axis.title.x = element_blank(),
													legend.position="none",
													panel.spacing = unit(0.1, "lines"),
													plot.background = element_blank()
												)+
											coord_flip()

									## RidgePlot NonNativeBalance
									p3 <- ggplot(user_data, aes(x = NonNativeBalance, y = Time, fill = ..x..)) +
											geom_density_ridges_gradient(scale = 3, rel_min_height = 0.01,quantile_lines = TRUE, quantiles = 2) +
											scale_fill_viridis()+
											# labs(title = "Non Native Balance Spread Change over Time") +
											xlab("Non Native Balance\n") +
											ylab("\nTime") +
											scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),labels = trans_format("log10", math_format(10^.x)))+
											theme(
													axis.text.y = element_text(color = "grey20", size = 10, hjust = .5, vjust = .5, face = "plain"),
													axis.text.x = element_text(color = "grey20", size = 12,angle=90, hjust = .5, vjust = .5, face = "plain"),
													axis.title=element_text(size=12,face="bold",hjust = .5),
													legend.position="none",
													panel.spacing = unit(0.1, "lines"),
													plot.background = element_blank()
												)+
											coord_flip()
									grid.newpage()
									grid.draw(rbind(ggplotGrob(p1), ggplotGrob(p2),ggplotGrob(p3), size = "last"))
						}, bg="transparent")
}