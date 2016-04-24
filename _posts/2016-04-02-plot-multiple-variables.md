---
layout: post
title:  "Plot multiple variables with ggplot2"
date:   2016-04-02 13:58:30 +0200
categories: r ggplot2
---
# Plot multiple variables with ggplot2
{% highlight r %}
plot = ggplot(df, aes(x)) + 
  geom_line(aes(y = y1, colour = "y1")) + 
  geom_line(aes(y = y2, colour = "y2"))
{% endhighlight %}

# Result

![The output image](/assets/output.png)

# Full example
{% highlight r %}
library("ggplot2")

# first, generate some data
x  = seq(from=1, to=10)
y1 = seq(from=1, to=10)
y2 = seq(from=20, to=1, by=-2)
df <- data.frame(
    x = x,
    y1 = y1,
    y2 = y2
)

# do the plotting with two variables
plot = ggplot(df, aes(x)) + 
    geom_line(aes(y = y1, colour = "y1")) + 
    geom_line(aes(y = y2, colour = "y2"))

# then save to file
ggsave(plot, file = "output.png", width = 8, height = 8, type = "cairo-png")

{% endhighlight %}

# References
[Stackoverflow post][stackof]

[stackof]: http://stackoverflow.com/a/3780353/4737417
