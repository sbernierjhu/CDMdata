#load in a bunch of useful packages
library(tidyverse)
library(RColorBrewer)
library(SMBanalysis)
library(extrafont)
library(ggrepel)
library(cowplot)
#font_import()
#loadfonts(device="win")       #Register fonts for Windows bitmap output
#fonts()

#function for pulling colors from RColorBrewer
f <- function(pal) brewer.pal(brewer.pal.info[pal, "maxcolors"], pal)

#change folder of data as appropriate
datalocation <- getwd()

#load the data
ThreeDSCdata <- read.delim(paste(datalocation, "/","3DSC data Figure 9.csv", sep = ""),header = TRUE,sep = ",",na.strings = "N/A",stringsAsFactors = TRUE,skip = 0)
McQueendata<-read.delim(paste(datalocation, "/","New data Figure 9.csv", sep = ""),header = TRUE,sep = ",",na.strings = "N/A",stringsAsFactors = TRUE,skip = 0)
data<-rbind(ThreeDSCdata %>% select(CM,Tc,origin),McQueendata%>% select(CM,Tc,origin))

#"Dome" fit implementation
df <- data.frame(CM=seq(0,0.75,0.01))
df <- df %>% mutate(D1=48+22.53*CM-1057*CM^2-15860*CM^3,D2=-482.2+5077*CM-18620*CM^2+33650*CM^3-23630*CM^4)

#make the plot
plot<-ggplot(data = data,aes(x = CM, y = Tc)) +
  geom_point() + 
  geom_line(data=df,aes(x=CM,y=D1),color=f("Dark2")[1],linewidth=1) +
  geom_line(data=df,aes(x=CM,y=D2),color=f("Dark2")[1],linewidth=1) +
  scale_color_manual(values=c("Black"))+
  xlab("Cubic deviation metric (unitless)") + 
  scale_x_continuous(breaks=seq(0,0.75,0.25),expand = c(0, 0),labels=c("0","0.25","0.5","0.75"))+
  ylab("Superconducting critical temperature Tc (K)") + 
  scale_y_continuous(breaks=seq(0,150,25),expand = c(0, 0))+
  coord_cartesian(ylim = c(0, 150),xlim=c(0,0.75))+
  theme(text=element_text(color="black",family="Helvetica", size=14),
        panel.background = element_rect(fill = "white"),
        panel.grid.major.y = element_blank(),panel.grid.major.x = element_blank(),
        panel.grid.minor.y = element_blank(), panel.grid.minor.x = element_blank(),
        axis.text=element_text(color="black",family="Helvetica", size=12),
        axis.title=element_text(color="black",family="Helvetica", size=12),
        axis.line=element_line(color="black"),
        legend.position = "inside",legend.position.inside=c(0.2,0.8)
  )+guides(color=guide_legend(title = "Data origin"))

#save the plot
ggsave(file="Figure 9.png", plot=plot, width=6, height=5)