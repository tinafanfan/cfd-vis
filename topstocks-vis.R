
library(ggplot2)
setwd("~/Documents/5_Projects/CFD_demo")
data <- read.csv(file = "demo_for_CFD.csv", header = T)
data$pn <- ifelse(data$Stock>0, "p", "n")
data$pn <- as.factor(data$pn)
lim_u <- max(data$Stock)
lim_l <- min(data$Stock)


p <- ggplot(data = data, aes(x = reorder(Company, Stock), 
                        y = Stock,
                        fill = pn))+ 
    geom_bar(position="dodge",
             stat="identity")+
    scale_y_continuous(limits=c(-5,12), breaks = seq(-5,12,1))+
    scale_fill_manual(values=c("#96A48E", "#A47C80"))+
    facet_grid(~Asset.Class, scales="free_x", space = "free_x") +
    labs(title = "Top Performers Over the Past 24 Hours",
         subtitle = "Last Updated November 20, 2020 at 3:30 GMT",
         # caption = "",
         x = "Stock Symbol") +
    theme(
        panel.grid.major.y = element_line(colour = "grey95"),
        panel.grid.minor.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.background = element_rect(fill="white"),
        panel.border = element_rect(colour = "black", fill=NA),
        
        plot.margin = margin(0.5, 0.5, 0.5, 0.5, "cm"),
        
        
          legend.position = "none",
        
          axis.text.x=element_text(angle = 90, hjust=0.95), # 股票代號靠上
          axis.title.y=element_blank(),
        axis.ticks.length = unit(0, "mm"),
        
          legend.text = element_text(size=14),
          legend.title = element_text(size=14),
          legend.key = element_blank(),
          
          plot.title = element_text(color = "Black", size = 24, face = "bold",hjust = 0.5),
          plot.subtitle = element_text(color = "Grey40", size = 16, hjust = 0.5),
        
          strip.background = element_rect(color="black", fill="White",  linetype=0),
          strip.text.x = element_text(size = 12, color = "black", face = "bold"
          )) 

png(paste0("CFD_demo.png"), width = 250, height = 150, units = "mm", res = 300)
plot.new()
print(p)
dev.off()
