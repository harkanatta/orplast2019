library(magick)
library(tidyverse)


DF1 <- read.csv("skjol/cozer.txt")
DF2 <- read.csv("skjol/cozer2.txt")
DF3 <- data.frame(x=seq(DF2$x[1],DF2$x[2],((DF2$x[2]-DF2$x[1])/26)),y=seq(DF2$y[1],DF2$y[2],((DF2$y[2]-DF2$y[1])/26)))

litura="#cb5600"
liturb="#28c1ff"
mycol <- rgb(211, 211, 211, max = 255, alpha = 125)
yLab="Fjöldi plastagna"

png("img/cozer.png", width = 1050, height = 1050, pointsize = 26)
plot(DF2,type='n', xlab='Log (lengd, mm)',ylab=yLab,yaxt='n')
rect(log(1),0,log(5),max(DF2)+1000000,col = mycol, lty = 3)
points(DF3,pch=22,bg=litura)
points(DF1,pch=21,bg=liturb)
axis(3,at=c(log(1),log(5)),labels = c("1 mm","5 mm"))
#abline(v = c(log(1),log(5)), col = "lightgray", lty = 3)
box()
legend("bottomleft",c("Áætlaður fjöldi","Talningar"),pch=c(22,21),pt.bg=c(litura,liturb),bg='transparent')
dev.off()



plot_img <- image_read("img/cozer.png")

travolta_ims <- image_read("https://i.imgur.com/e1IneGq.jpg") 

frames <- lapply(travolta_ims, function(frame) {
  image_composite(plot_img, frame, gravity = "SouthWest", offset = "+100+0")
})

Reduce(c, frames) %>% 
  image_animate() %>% 
  image_write_gif("img/animated_plot.gif", delay=0.1, progress=FALSE)


