library(ggplot2)
library(openxlsx)
library(ggmap)
library(cowplot)
library(rgdal)

###  Read in CSV  ###

setwd('') ###SET TO YOUR LOCAL DIRECTORY CONTAINING THE CSV FILE

locations=read.csv('fig1_locations.csv')
locations=as.data.frame(locations)

locations$Lat=as.numeric(as.character(locations$Lat))
locations$Lon=as.numeric(as.character(locations$Lon))

###  Make world plot and histogram  ###

# Colorblind friendly color palette:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for line and point colors, add 
scale_colour_manual(values=cbPalette)

bbox <- c(left = -169, bottom = -56, right = 180, top = 75)
mp=ggmap(get_stamenmap(bbox, zoom = 3, maptype="terrain-background"))
mp <- mp+ geom_point(data=locations, aes(x=Lon, y=Lat, colour=factor(Type)) , size=2) + 
  geom_jitter() +scale_color_manual(values=cbPalette)
mp= mp+ theme(legend.position="none")+labs(x="", y="")
mp

hist=ggplot(data=locations, aes(x=locations$Type))+
  geom_histogram(stat="count",colour="black", aes(fill=factor(locations$Type)))+scale_fill_manual(values=cbPalette)
hist=hist+theme(legend.position="none")+labs(x="", y="Number of Locations")

hist
