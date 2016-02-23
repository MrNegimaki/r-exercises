## Load dplyr

library(dplyr)

## Create a scatterplot of price vs x using the ggplot syntax.

price_vs_x <- ggplot(data = diamonds, aes(x = x, y = price)) +
  geom_point()

## Create a simple scatter plot of price vs depth.

price_vs_depth <- ggplot(data = diamonds, aes(x = depth, y = price)) +
  geom_point()

## Make transparency of price_vs_depth 1/100 of current, and mark x-axis every 2 units.

price_vs_depth_altered <- ggplot(data = diamonds, aes(x = depth, y = price)) + 
  geom_point(alpha = 1/100) +
  scale_x_continuous(breaks = seq(0,80,2))

## Create a scatterplot of price vs carat and omit the top 1% of price and carat values.

price_vs_carat <- ggplot(data = diamonds, aes(x = carat, y = price)) +
  geom_point() +
  xlim(0, quantile(diamonds$carat, .9)) +
  ylim(0, quantile(diamonds$price, .9))
  
## Create a scatterplot of price vs volume (x * y * z).

diamonds$volume <- (diamonds$x * diamonds$y * diamonds$z)
price_vs_volume <- ggplot(data = diamonds, aes(x = volume, y = price)) +
  geom_point()

## Find the correlation coefficient of price vs volume, but exclude values 0 and >800.

with(subset(diamonds, volume > 0 & volume <= 800), cor(price, volume))

## Subset the data to exclude diamonds with a volume greater than or equal to 800. Also, exclude diamonds
## with a volume of 0. Adjust the transparency of the points and add a linear model to the plot.

cleaned_price_vs_volume <- ggplot(data = subset(diamonds, volume > 0 & volume <= 800), aes(x = volume, y = price)) + 
                                  geom_point(alpha = 1/20) +
                                  stat_smooth(method = "lm", formula = "y ~ x + I(x^2)")
                                  
## Use the function dplyr package to create a new data frame containing info on diamonds by clarity.

diamondsByClarity <- group_by(diamonds, clarity) %>% summarise(mean_price = mean(price),
                                                       median_price = median(price),
                                                       min_price = min(price),
                                                       max_price = max(price),
                                                       n = n())

## Create data frames organizing diamonds by their clarity and color, as well their respective mean prices.

diamonds_by_clarity <- group_by(diamonds, clarity)
diamonds_mp_by_clarity <- summarise(diamonds_by_clarity, mean_price = mean(price))

diamonds_by_color <- group_by(diamonds, color)
diamonds_mp_by_color <- summarise(diamonds_by_color, mean_price = mean(price))

## Create two bar plots on one output image using the grid.arrange() function from the package gridExtra.

library(gridExtra)

bp_clarity <- ggplot(aes(clarity, mean_price), data = diamonds_mp_by_clarity) +
  geom_bar(stat = 'identity')

bp_color <- ggplot(aes(color, mean_price), data = diamonds_mp_by_color) +
  geom_bar(stat = 'identity')

mp_by_clarity_vs_color <- grid.arrange(bp_clarity, bp_color)

