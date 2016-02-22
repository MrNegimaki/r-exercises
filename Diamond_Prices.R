## Load the diamond data set from ggplot.

library(ggplot2)
data(diamonds)

## Create a histogram of the price of all the diamonds in the diamond data set. Make it presentable.

price_hist <- qplot(x = price, data = diamonds, binwidth = 500, color = I('black'), fill = I('green')) +
  scale_x_continuous(limits = c(0,20000), breaks = seq(0,20000,1000), expand = c(0,0)) +
  scale_y_continuous(limits = c(0,13000),expand = c(0,0))

## Break out the histogram of diamond prices by cut, clean out white space on top, and individualize y-axis by graph.

price_hist_cut <- qplot(x = price, data = diamonds, binwidth = 500, color = I('black'), fill = I('green')) +
  scale_x_continuous(limits = c(0,20000), breaks = seq(0,20000,1000), expand = c(0,0)) + facet_wrap(~cut, scales = "free_y")

## Create a histogram of price per carat, facet by cut, and transform.

price_hist_cut_per_carat <- qplot(x = price/carat, data = diamonds, color = I('black'), fill = I('blue')) + 
  facet_wrap(~cut, scale = "free_y") +
  scale_x_log10()

## Create a series of box plots organized by color, and summarize by color.

price_by_color <- qplot(x = color, y = price, geom = 'boxplot', data = diamonds)

## Investigate the price per carat of diamonds across the different colors of diamonds using boxplots.

carat_price_by_color <- qplot(x = color, y = price/carat, geom = 'boxplot', data = diamonds)

## Create a frequency polygon that investigates the weight of the diamonds.

freq_of_carat <- qplot(x = carat, geom = 'freqpoly', data = diamonds, binwidth = .01)
