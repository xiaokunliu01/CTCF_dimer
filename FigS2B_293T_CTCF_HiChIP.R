setwd(dir = "/home/lxk/private/DNase-C/dimer_paper/fig1/293T/CTCF_HiChIP/R2/")
library(dplyr)
library(tidyverse)
library(ggpubr)
library(ggpointdensity)
library(viridis)

df <- read.table("/mnt/disk1/6/lxk/private/HiChIP/total/293T/dimer_CTCF/interaction_footprint.tab", sep = "\t", header = F)

m=1
dis=50
bin=25
TF="Distance from motif (bp)"
xyintercept=0

df = df %>% filter(df[,6]<=50 & df[,7]<=50 & abs(df[,4])<=50 & abs(df[,5])<=50 & df[,8]>=100)

df <- df %>%
  mutate(
    # 处理TandemF行：将第三列(V3)的值取负
    V3 = ifelse(V1 == "TandemF", -V3, V3),
    
    # 处理TandemR行：将第二列(V2)的值取负
    V2 = ifelse(V1 == "TandemR", -V2, V2),
    
    # 处理Div行：将第二列(V2)和第三列(V3)的值都取负
    V2 = ifelse(V1 == "Div", -V2, V2),
    V3 = ifelse(V1 == "Div", -V3, V3)
  )

# png("interaction_footprint_5p.png", units = "in", width = 5, height = 5, res = 300, bg = "transparent")
pdf("interaction_footprint_5p_dis3p_-50.pdf", width = 2.5, height = 2.8, bg = "transparent")

ggplot(df, aes(x=df[,3], y=df[,2])) +
  geom_pointdensity(adjust = 4, size = 0.1, method='kde2d') +
  scale_color_gradient(low = "white", 
                       high = "dodgerblue4", 
                       # limits = c(0,0.000237), 
                       na.value="dodgerblue4"
                       ) +
  # scale_color_viridis() + 
  # stat_density_2d(geom = "tile", aes(fill = ..density..^m), contour = FALSE, n = 200) +
  # scale_fill_gradient2(low = "white", high = "dodgerblue4") +
  
  # 在 ggplot2 中，annotate(geom = "text") 的 size 参数默认以 毫米（mm） 为单位，
  # 而 theme() 中的 element_text(size) 以 磅（pt） 为单位。
  # 1 pt ≈ 0.3528 mm
  # annotate("text", x=-35, y=40, label="5' - 5'", colour = "red",size = 12*0.3528) + 
  # annotate("text", x=35, y=40, label="5' - 3'",size = 12*0.3528) + 
  # annotate("text", x=-35, y=-40, label="3' - 5'",size = 12*0.3528) + 
  # annotate("text", x=35, y=-40, label="3' - 3'",size = 12*0.3528) + 
  
  annotate("text", x=-35, y=45, label="31.4%", colour = "red",size = 12*0.3528) + 
  annotate("text", x=35, y=45, label="24.5%",size = 12*0.3528) + 
  annotate("text", x=-35, y=-45, label="25.1%",size = 12*0.3528) + 
  annotate("text", x=35, y=-45, label="19.0%",size = 12*0.3528) + 
  
  geom_hline(yintercept = -xyintercept, linetype="dashed", colour="#A9A9A9")+
  geom_vline(xintercept = xyintercept, linetype="dashed", colour="#A9A9A9")+
  xlab(TF) +
  ylab(TF) +
  labs(title = "HEK293T\nCTCF HiChIP") +
  scale_x_continuous(
    limits  = c(-dis, dis),
    breaks = seq(-dis, dis, bin),
    labels = c("-50", "", "0", "", "50"),
    expand =  expansion(mult = c(0, .01))
  ) +
  scale_y_continuous(
    limits = c(-dis, dis),
    breaks = seq(-dis, dis, bin),
    labels = c("-50", "", "0", "", "50"),
    expand = c(0,0)
  ) +
  theme(
    axis.text = element_text(color = "black",size = 12), #face = "bold",
    axis.title = element_text(color = "black",size = 12),
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 12),
    panel.background = element_blank(), 
    legend.position = "none",
    rect = element_rect(fill = NA, size=0, color = NA),
    plot.background = element_rect(fill = NA, size=0, color = NA),
    legend.background = element_rect(fill = NA, size=0, color = NA),
    legend.key = element_rect(fill = NA, size=0, color = NA),
    plot.title = element_text(
      # face = "bold", 
      # color = "black", 
      # size = 16, 
      hjust = 0.5)
  )


# ggarrange(con2, div2, ff2, rr2, ncol = 2, nrow =2)
# ggarrange(con2)
dev.off()
