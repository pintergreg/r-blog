---
layout: post
title:  "Two y axis with different scales"
date:   2016-04-03 10:48:30 +0200
categories: r 
---
It is said that generally it's not a good idea to create a plot with two y axis but with different scales<sup>[1](#ref1)</sup>. So ggplot2 does not really support it basicly, there is only a hackish way to achieve it<sup>[2](#ref2)</sup>. But as the `grid` package was not available (for R version 3.2.3), I tried something else.

{% highlight r %}
# first, generate some data
x = seq(from=1, to=7)
a = c(58, 42, 61, 47, 32, 12, 20)
b = c(38, 28, 54, 51, 35, 63, 57)
df <- data.frame(
    x = x,
    y1 = a,
    y2 = b
)
# define the file to save (it has to be done before plotting)
png(file = "output_f.png", type = "cairo")

# create the first plot with line type, color deepskyblue4, scale 0..100 and some axis labels
plot(df$x, df$y1, type="l",
	col="deepskyblue4",
	xlab="x", ylab="a",
	ylim=c(0, 100)
)

# unites the plots 
par(new=TRUE)
         
# create the second plot with line type, color firebrick and scale 20..70
# axis labels are empty, because they would be overlapped with the first ones
# that would also happen with the axis ticks so xaxt and yaxt paramters are needed
plot(df$x, df$y2, type="l",
	col="firebrick",
	xaxt="n", yaxt="n",
	xlab="", ylab="",
	ylim=c(20, 70)
)
   
# makes the scales of the second plot visible
axis(4)

# add title to the plot
title(main = "the title")

# add legend to the plot
legend("topleft", col=c("deepskyblue4","firebrick"), bty="n", lty=1, legend=c("a", "b"))

{% endhighlight %}

# Result

![The output image]({{ site.baseurl }}/assets/two-y-axis.png)

# Summary

And the reason why two axis is not advised: at `x=3` *b* seems to be higher, but it is actually not! **b** is 54, and **a** is 61...

# References
1. <a name="ref1">[Two y axes][kieranhealy-blogpost]
2. <a name="ref2">[Dual axis in ggplot2][ggplot2-hack]
3. <a name="ref3">[Two y axes - code on GitHub][kieranhealy-github]

[ggplot2-hack]: https://rpubs.com/kohske/dual_axis_in_ggplot2
[kieranhealy-blogpost]: https://kieranhealy.org/blog/archives/2016/01/16/two-y-axes/
[kieranhealy-github]: https://github.com/kjhealy/two-y-axes/blob/master/two-y-axes.r
[dev-off]: http://www.inside-r.org/r-doc/grDevices/dev.off
