---
layout: post
title:  "Grouped bar chart"
date:   2016-04-02 23:48:30 +0200
categories: r ggplot2 reshape2 melt
---

# Grouped bar chart

{% highlight r %}
require("ggplot2")
require("reshape2")

# first, generate some data
x = seq(from=1, to=7)
a = c(58, 42, 61, 47, 32, 12, 20)
b = c(38, 28, 54, 51, 35, 63, 57)
df <- data.frame(
    x = x,
    a = a,
    b = b
)

# melt the data frame for plotting
df.melted <- melt(df, id.vars='x')

# do the plotting
plot <- ggplot(df.melted, aes(x, value)) + 
geom_bar(aes(fill = variable), position = "dodge", stat="identity") + 
# add common x axis label
xlab("A and B grouped bar chart")

# then save to file
ggsave(plot, file = "output.png", width = 8, height = 8, type = "cairo-png")

{% endhighlight %}

# Result

![The output image](/assets/grouped-bar-chart.png)

# Melting

The stucture of the original `df`:

```` html
  x  a  b
1 1 58 38
2 2 42 28
3 3 61 54
4 4 47 51
5 5 32 35
6 6 12 63
7 7 20 57

````

And the `df.melted`:

````
   x variable value
1  1        a    58
2  2        a    42
3  3        a    61
4  4        a    47
5  5        a    32
6  6        a    12
7  7        a    20
8  1        b    38
9  2        b    28
10 3        b    54
11 4        b    51
12 5        b    35
13 6        b    63
14 7        b    57

````

The structure have changed. Of course you don't store data in a relational database in this manner, but it is necessary for this grouped plotting. `reshape2`'s `melt` function do this specifying the common variable (x in the example).

# References
[Stackoverflow post][stackof]

[stackof]: http://stackoverflow.com/a/18162330/4737417
