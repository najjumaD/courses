# Subsetting with \R
# exe_subset.R
# Stephan Huber; 2022-06-07

setwd("/home/sthu/Dropbox/hsf/22-ss/dsda/work/")
rm(list=ls())

# 1
library(tidyverse)
library(dplyr)
library(tibble)

# 2
mtcars

# 3
cars <- mtcars

# 4
class(cars)

# 5
dim(cars)

# Alternative
ncol(cars)
nrow(cars)

# 6
cars <- rename(cars, MPG = mpg)

# 7
cars <- rename_all(cars, toupper)
# if you like lower cases:
# cars <- rename_all(cars, tolower)

# 8
cars <- rownames_to_column(mtcars, var = "car")

# 9
pvars <- select(cars, car, ends_with("p"))

# 10
carsSub <- select(cars, car, wt, qsec, hp)

# 11
dim(carsSub)

# 12
carsSub <- rename_all(carsSub, toupper)

# 13
cars_mpg <- filter(cars, mpg > 20)
dim(cars_mpg)

#14
cars_whattever <- filter(cars, mpg < 16 & hp > 100)

# 15
carsSub <- filter(cars, cyl == 8) 
carsSub <- select(carsSub, wt, qsec, hp, car)
dim(carsSub)

# 16
# Alternative with pipe operator:
carsSub <- cars %>%
  filter(cyl == 8) %>%
  select(wt, qsec, hp, car)

# 17
carsSub <- arrange(carsSub, wt)

# 18
carsSub <- carsSub %>% 
  mutate(wt2 = wt^2)

# Alternatively you can put everything into one pipe:
carsSub2 <- cars %>%
  filter(cyl == 8) %>%
  select(wt, qsec, hp, car) %>% 
  arrange(carsSub, wt) %>% 
  mutate(wt2 = wt^2)

