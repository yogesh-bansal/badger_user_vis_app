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

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
    	h3("Badger Boost User Vis",align = "center"),
    	uiOutput("date_ui"),
    	p("Badget Boost is a staking incentive program that scales the APY users get from depositing into one of the many Sett vaults hosted by the protocol."),
    	p(" This bounty submission visualizes the change in user staking ratios, native asset and non-native asset holdings over time. For each graph, on the x-axis we have weekly dates tracking the distribution of user deposits. On the various y-axes, the staking ratio, native assets and non-native assets value ranges are listed."),
    	p(" Overall, from the beginning of tracking until the end, the Stake Ratio has increased, particularly around August 5th when the boosting program went live. The ratio increased because the numerator, the “Native Asset Balance”, was higher during this period as Badger asset token holders increased their platform balances."),
    	p(" At the start of this period the average native balance was low. A few week after, the trend began to increase simultaneously pulling up the Stake Ratio. These simple graphs show that the boosting program was indeed a success and other similar incentive initiatives could possibly be met with even better results.")
    ),
  	mainPanel(
      	plotOutput("gridplot",height = "650px") %>% withSpinner(color="#0dc5c1")
    )
  )
)
