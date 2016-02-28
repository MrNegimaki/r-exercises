## Load the ggplot, dplyr and tidyr libraries, along with the diamonds dataset.

library(dplyr)
library(tidyr)
library(ggplot2)
data(diamonds)

## Create a histogram of diamond prices. Facet the histogram by diamond color and use cut to color the histogram bars.

ggplot(data = diamonds, aes(x = price, fill = cut)) + 
  geom_histogram() + 
  scale_y_continuous(expand = c(0,0)) +
  facet_wrap(~color) + 
  scale_fill_brewer(type = 'qual') +
  scale_x_log10()

## Create a scatterplot of diamond price vs. table and color the points by the cut of the diamond.

ggplot(data = diamonds, aes(x = table, y = price, fill = cut)) +
  geom_point(aes(color = cut)) +
  scale_x_continuous(limits = c(50,80), breaks = seq(50,80,2), expand = c(0,0))

## Create a scatterplot of diamond price vs. volume (x * y * z) and color the points by the clarity of diamonds.

ggplot(data = diamonds, aes(x = (x*y*z), y = price)) +
  geom_point(aes(color = clarity)) +
  scale_x_continuous(name = 'volume') + 
  scale_y_log10() +
  coord_cartesian(xlim=c(0,quantile(diamonds$x*diamonds$y*diamonds$z,0.99)))
  
## Load Pseudo-Facebook data set, and create a new variable called 'prop_initiated'.

pf$prop_initiated <- pf$friendships_initiated / pf$friend_count

## Create a line graph of the median proportion of friendships initiated ('prop_initiated') vs.
## tenure and color the line segment by year_joined.bucket. Finally, smooth the graph.

pf$year_joined = floor(2014 - pf$tenure / 365)
pf$year_joined.bucket = cut(pf$year_joined, c(2004,2009,2011,2012,2014))

ggplot(aes(x = tenure, y = prop_initiated ), data = pf) +
  geom_line(aes(color = year_joined.bucket), stat = 'summary', fun.y=median) +
  geom_smooth(method = 'lm')

## Create a scatter plot of the price/carat ratio of diamonds. The variable x should be assigned to cut. 
## The points should be colored by diamond color, and the plot should be faceted by clarity.

diamonds$price_per_carat <- diamonds$price / diamonds$carat

ggplot(aes(x = cut, y = price_per_carat), data = diamonds) +
  geom_point(aes(color=color)) +
  scale_color_brewer(type = 'div') +
  facet_wrap(~clarity)