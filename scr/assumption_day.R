################################################################################
# Dear students, I hope you are doing good. There is no lecture today. 
# Nevertheless, you should use the time to prepare for the exam. In the 
# following I will give you some tasks and hints what you should study and 
# repeat, respectively.
################################################################################

# ==============================================================================
# 0. 
# Set your working directory and clear the environment.
# ______________________________________________________________________________


# ==============================================================================
# 1. 
# Download and read the most recent version of the lecture notes 
# (rcourse_book.pdf) from ILIAS.
# ______________________________________________________________________________


# ==============================================================================
# 2. 
# Read: Wickham and Grolemund (2018, ch. "Workflow: basics"). 
# See: https://r4ds.had.co.nz/workflow-basics.html 
# ______________________________________________________________________________


# ==============================================================================
# 3. 
# Answer the following questions:

# ===
# a) 
# Run the two following lines of code 
# (a.k.a. send it from the script to the console)
# Why does the second line of code not work? Look carefully! 
# This may seem like an exercise in pointlessness, but training your brain
# to notice even the tiniest difference will pay off when programming.)

my_variable <- 10
my_varıable
  
# ===
# b)
# Tweak each of the following R commands so that they run correctly:
    
library(tidyverse)

ggplot(data = mpg) + 
  geom_point() +
  aes(x = displ, y = hwy)

# ===
# c)
# Press Alt + Shift + K. What happens? How can you get to the same place using
# the menus?
# ______________________________________________________________________________


# ==============================================================================
# 4. 
# Read Wickham and Grolemund (2018, ch. "Data transformation") 
# See: https://r4ds.had.co.nz/transform.html
# 
# Answer the following questions (Also see lecture notes excercise "Subsetting")
# 
# --- Solutions to these questions can be found here:
# https://raw.githubusercontent.com/hubchev/courses/main/scr/exe_subset.R
# !!! For your own benefit: try to come up with the solution yourself.  

# ===
# Load the following packages: tidyverse, dplyr, and tibble.


# ===
# Check to see if you have the mtcars dataset by entering the command mtcars.


# ===
# Save the mtcars dataset in an object named cars.


# ===
# What class is cars?


# ===
# How many observations (rows) and variables (columns) are in the 
# mtcars dataset?


# ===
# Rename mpg in cars to MPG. Use rename().


# ===
# Convert the column names of cars to all upper case. Use rename\_all, 
# and the toupper command.


# ===
# Convert the rownames of cars to a column called car using 
# rownames\_to\_column. 


# ===
# Subset the columns from cars that end in "p" and call it pvars 
# using ends\_with().


# ===
# Create a subset cars that only contains the columns: wt, qsec, and hp and 
# assign this object to carsSub.  (Use select().)


# ===
# What are the dimensions of carsSub? (Use dim().)


# ===# Convert the column names of carsSub to all upper case. Use rename\_all(), 
# and toupper() (or colnames()).


# ===
# Subset the rows of cars that get more than 20 miles per gallon (mpg) 
# of fuel efficiency. How many are there? (Use filter().)


# ===
# Subset the rows that get less than 16 miles per gallon (mpg) of fuel 
# efficiency and have more than 100 horsepower (hp). 
# How many are there? (Use filter() and the pipe operator.)


# ===
# Create a subset of the cars data that only contains the columns: wt, qsec, and
# hp for cars with 8 cylinders (cyl) and reassign this object to carsSub. 
# What are the dimensions of this dataset? Don't use the pipe operator.


# ===
# Create a subset of the cars data that only contains the columns: 
# wt, qsec, and hp for cars with 8 cylinders (cyl) and reassign 
# this object to carsSub2. Use the pipe operator.


# ===
# Re-order the rows of carsSub by weight (wt) in increasing order. 
# (Use arrange().)


# ===
# Create a new variable in carsSub called wt2, which is equal to $wt^2$, 
# using mutate() and piping \%>\%.

# ______________________________________________________________________________


# ==============================================================================
# 5.
# Solve the exercise "Convergence" that you also find in the lecture notes.
# 
# The dataset convergence.dta, see  
# https://github.com/hubchev/courses/blob/main/dta/convergence.dta, contains the
# per capita GDP of 1960 (gdppc60) and the average growth rate of GDP per capita 
# between 1960 and 1995 (growth) for different countries (country), as well as 3 
# dummy variables indicating the belonging of a country to the region Asia 
# (asia), Western Europe (weurope) or Africa (africa). 

# ===
# Some countries are not assigned to a certain country group. Name the countries
# which are assign to be part of Western Europe, Africa or Asia. If you find 
# countries that are members of the EU, assign them a '1' in the variable 
# weurope.


# ===
# Create a table that shows the average GDP per capita for all available points 
# in time. Group by Western European, Asian, African, and the remaining 
# countries.


# ===
# Create the growth rate of GDP per capita from 1960 to 1995 and call it 
# gdpgrowth. (Note: The log value X minus the log value X of the previous period 
# is approximately equal to the growth rate).


# ===
# Calculate the unconditional convergence of all countries by constructing a 
# graph in which a scatterplot shows the GDP per capita growth rate between 1960
# and 1995 (gdpgrowth) on the y-axis and the 1960 GDP per capita (gdppc60) on 
# the x-axis. Add to the same graph the estimated linear relationship. You do 
# not need to label the graph further, just two things: title the graph `world' 
# and label the individual observations with the country names.


# ===
# Create three graphs describing the same relationship for the sample of Western
# European, African and Asian countries. Title the graph accordingly with 
# `weurope', `africa' and `asia'. 


# ===
# Combine the 4 graphs into one image. Discuss how an upward or downward sloping
# regression line can be interpreted.


# ===
# Estimate the relationships illustrated in the 4 graphs using the least squares
# method. Present the 4 estimation results in a table, indicating the 
# significance level with stars. In addition, the Akaike information criterion, 
# and the number of observations should be displayed in the table. Interpret the
# four estimation results regarding their significance. 
	

# ===
# Put the data set into the so-called \textit{long format} and calculate the GDP
# per capita growth rates for the available time points in the countries.