# Convergence

# set working directory
setwd("/home/sthu/Dropbox/hsf/github/courses/")

# clear the environment
rm(list = ls())

# some packages needed install.packages(...) and load packages library(...)

# Let us do the following:
  # 1. check if a package is installed
  # 2. if not installed the package should be installed and loaded
  # 3. if installed the package should be loaded
# I like to do it with a function that is part of pacman package:
if (!require("pacman")) {install.packages("pacman")}
pacman::p_load(haven, tidyverse, vtable, gtsummary, pastecs, Hmisc, 
               sjlabelled, tis, ggpubr, sjPlot)

# an alternative is to install and load it like that
# install.packages(c("haven", "tidyverse", "vtable", "gtsummary", "pastecs"))
# library(c("haven", "tidyverse", "vtable", "gtsummary", "pastecs"))


# The dataset convergence.dta, see  
# https://github.com/hubchev/courses/blob/main/dta/convergence.dta, contains the
# per capita GDP of 1960 (gdppc60) and the average growth rate of GDP per capita 
# between 1960 and 1995 (growth) for different countries (country), as well as 3 
# dummy variables indicating the belonging of a country to the region Asia 
# (asia), Western Europe (weurope) or Africa (africa). 

# import data
data <- read_dta("dta/convergence.dta")

# inspect data
names(data)
str(data)
data
head(data)
tail(data)
summary(data)
view(data)

#library(vtable)
vtable(data, missing=TRUE)

# library(pastecs)
stat.desc(data)

# library(Hmisc)
describe(data)

# library(gtsummary)
tbl_summary(data)

# ===
# Some countries are not assigned to a certain country group. Name the countries
# which are assign to be part of Western Europe, Africa or Asia. If you find 
# countries that are members of the EU, assign them a '1' in the variable 
# weurope.

# check the assignments of countries to continents
data %>% 
  select(country, africa, asia, weurope) %>% 
  view()

data <- mutate(data, x_1 = africa + asia + weurope)

data %>% 
  filter(x_1==0) %>% 
  select(africa, asia, weurope, country) %>% 
  view()

# correct the assignment manually
data$weurope[data$country == "Austria"] <- 1
data$weurope[data$country == "Greece"] <- 1
data$weurope[data$country == "Cyprus"] <- 1

filter(data, data$weurope==1) # check changes

# In the following, I do the same with a loop
# c_europe <- c("Austria","Greece","Cyprus")
# sum(data$weurope)                       # check changes
# for (i in c_europe){
#   print(i)
#   data$weurope[data$country == i] <- 1
#   }
# sum(data$weurope)                       # check changes
# data$weurope[data$country == "Austria"] # check changes

# create a category for the remaining countries
# use ifelse -- ifelse(condition, result if TRUE, result if FALSE)
data$rest <- ifelse(data$africa == 0 & data$asia == 0 & data$weurope == 0, 1, 0)
data$rest <- set_label(data$rest, label = "=1 if not in Africa, W.Europe, or Asia")


# ===
# Create a table that shows the average GDP per capita for all available points 
# in time. Group by Western European, Asian, African, and the remaining 
# countries.
# create table with means across country groups
table_gdp <- data %>%
  group_by(africa, asia, weurope) %>%
  summarise_at(vars(gdppc60:gdppc95), list(name = mean))

data %>%
  group_by(africa, asia, weurope) %>%
  select(gdppc60:gdppc95) %>% 
  summarise_all(mean)


# ===
# Create the growth rate of GDP per capita from 1960 to 1995 and call it 
# gdpgrowth. (Note: The log value X minus the log value X of the previous period 
# is approximately equal to the growth rate).
data$gr1 <- (data$gdppc95 - data$gdppc60)/data$gdppc60
data$gr2 <- log(data$gdppc95) - log(data$gdppc60)
cor(data$gr1, data$gr2)

# ===
# Calculate the unconditional convergence of all countries by constructing a 
# graph in which a scatterplot shows the GDP per capita growth rate between 1960
# and 1995 (gdpgrowth) on the y-axis and the 1960 GDP per capita (gdppc60) on 
# the x-axis. Add to the same graph the estimated linear relationship. You do 
# not need to label the graph further, just two things: title the graph `world' 
# and label the individual observations with the country names.
ggplot(data, aes(x = gdppc60, y = growth, label=country)) +
  geom_point() +
  geom_text(hjust=0, vjust=0) 

# ===
# Create three graphs describing the same relationship for the sample of Western
# European, African and Asian countries. Title the graph accordingly with 
# `weurope', `africa' and `asia'. 
p1 <- ggplot(data, aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
 # geom_text(hjust=0, vjust=0) +
  ggtitle("World")

p2 <- data %>% 
  filter(weurope==1) %>% 
  ggplot( aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
  #geom_text(hjust=0, vjust=0) +
  ggtitle("Western Europe")

p3 <- data %>% 
  filter(asia==1) %>% 
  ggplot( aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
 # geom_text(hjust=0, vjust=0) +
  ggtitle("Asia")

p4 <- data %>% 
  filter(africa==1) %>% 
  ggplot( aes(x = gdppc60, y = growth, label=country )) +
  geom_point() +
  stat_smooth(formula=y~x, method="lm", se=FALSE, colour="red", linetype=1) +
#  geom_text( hjust=0, vjust=0) +
  ggtitle("Africa")


# ===
# Combine the 4 graphs into one image. Discuss how an upward or downward sloping
# regression line can be interpreted.

ggarrange(p1, p2, p3, p4 , 
          labels = c("A", "B", "C", "D"),
          ncol = 2, nrow = 2)

# ===
# Estimate the relationships illustrated in the 4 graphs using the least squares
# method. Present the 4 estimation results in a table, indicating the 
# significance level with stars. In addition, the Akaike information criterion, 
# and the number of observations should be displayed in the table. Interpret the
# four estimation results regarding their significance. 

# Regression analysis
m1  <-  lm(growth ~ gdppc60, data = data)
m2  <-  lm(growth ~ gdppc60, data = subset(data, weurope==1))
m3  <-  lm(growth ~ gdppc60, data = subset(data, asia==1))
m4  <-  lm(growth ~ gdppc60, data = subset(data, africa==1))

tab_model(m1, m2, m3, m4,
          p.style = "stars",
          p.threshold = c(0.2, 0.1, 0.05),
          show.ci = FALSE, 
          show.se = FALSE, 
          show.aic = TRUE,
          dv.labels = c("World", "W.Europe", "Asia", "Africa")) 

# ===
# Put the data set into the so-called \textit{long format} and calculate the GDP
# per capita growth rates for the available time points in the countries.
# reshape data, also see:
# https://stackoverflow.com/questions/2185252/reshaping-data-frame-from-wide-to-long-format

data_long <- gather(data, condition, measurement, gdppc60:gdppc95, factor_key=TRUE)
data_long$year <- as.numeric(substr(data_long$condition, 6, 7))

data_long$gr_long <- data_long %>% 
  select(country,measurement) %>%
  group_by(country) %>%
  mutate(gr = c(NA,diff(measurement))/lag(measurement, 1))

# erase all helping variables
data <- select(data, -starts_with("h_"))

# generate and remove variables in a dataframe
data <- mutate(data, Land = country)
data <- select(data, -country)




data %>%
  summarise(
    y65 = mean(gdppc65, na.rm = TRUE),
    y70 = mean(gdppc70, na.rm = TRUE),
    y75 = mean(gdppc75, na.rm = TRUE),
    y80 = mean(gdppc80, na.rm = TRUE),
    y85 = mean(gdppc85, na.rm = TRUE),
    y90 = mean(gdppc90, na.rm = TRUE),
    y95 = mean(gdppc95, na.rm = TRUE)
  )



