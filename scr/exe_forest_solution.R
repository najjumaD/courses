knitr::opts_chunk$set(echo = TRUE)

setwd("/home/sthu/Dropbox/hsf/github/courses/rmd/")

rm(list=ls())

# install.packages("tidyverse")
# install.packages("ggpubr")
# install.packages("sjPlot")
library("tidyverse")
library("ggpubr")
library("sjPlot")

load(url("https://github.com/hubchev/courses/raw/main/dta/forest.Rdata"))

summary(df)

df <- rename(df, country=country.x)

df <- df %>% 
  mutate(gdp_mio = gdp/1000000)

df  %>%
  group_by(region) %>%
  summarise(m_gdp_mio = mean(gdp_mio), 
            m_forest = mean(forest)
  )

df  %>%
  group_by(region) %>%
  summarise(m_gdp_pc = mean(gdppc), 
            m_forest = mean(forest)
  )

# rmarkdown::render("exe_forest.Rmd", "all")

