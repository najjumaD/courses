## ----setup, include=FALSE--------------------------------------------------------------------
library("knitr")
knit_hooks$set(purl = hook_purl)

## ----echo=FALSE------------------------------------------------------------------------------
setwd("/home/sthu/Dropbox/hsf/github/courses/rmd/")

## --------------------------------------------------------------------------------------------
norm <- rnorm(100, mean = 0, sd = 1)

## ---- echo = FALSE---------------------------------------------------------------------------
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)

## ---- warning = FALSE------------------------------------------------------------------------
library(dplyr)

## ---- fig.width = 4, fig.height = 3----------------------------------------------------------
A <- c("a", "a", "b", "b")
B <- c(5, 10, 15, 20)
dataframe <- data.frame(A, B)
print(dataframe)
boxplot(B~A,data=dataframe)

