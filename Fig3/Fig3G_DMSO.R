setwd("/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/RAD21_degron/contact_distance/orientation_with_distance/R4/DMSO/")

library(tidyverse)

df <- read.table("orientation_with_distance.tab", sep = "\t", header = FALSE)


# png("CTCF_motif_frequency.png", units = "in", width = 4, height = 3, res = 300, bg = "transparent")
pdf("orientation_with_distance.pdf", width = 2.8, height = 2.8, bg = "transparent")

ggplot(data = df, mapping = aes(x = df[,4], y = df[,3], color = df[,1], group = df[,1])) + 
  geom_point(size= 2) +
  geom_line(size= 1.2) +
  scale_color_manual(
    values = c("Con"="#386CAF",
               "Div"="#7FC87F",
               "TandemF"="#9f79d3",
               "TandemR"=rgb(1,0.6,0.2)
               ),
    limits = c("Con", "Div", "TandemF", "TandemR"),
    labels = c("Convergent", "Divergent", "Tandem F", "Tandem R")
  ) +
  guides(
    color = guide_legend(
      byrow = TRUE, # 确保按行排列，垂直间距生效
      nrow = 2 # 图例分两行显示
    )
  ) +
  scale_x_discrete(
    limits = c("0.1-10kb", "10-50kb", "50-500kb", "500kb-5Mb", "≥5Mb"),
    breaks = c("0.1-10kb", "10-50kb", "50-500kb", "500kb-5Mb", "≥5Mb"),
    labels = c("0.1-10 kb", "10-50 kb", "50-500 kb", "0.5-5 Mb", expression("">="5 Mb")),
    expand = expansion(mult = c(0.04, .04))
  ) +
  scale_y_continuous(
    # limits = c(0, 1),
    breaks = c(0, 25, 50, 75, 100),
    expand = expansion(mult = c(0.02, .0))
  ) +
  coord_cartesian(
    ylim = c(0, 100)
  ) +
  xlab("Distance") + 
  ylab("Proportion (%)") + 
  labs(title = "DMSO") + 
  theme(
    # axis.text = element_text(color = "black",size = 10), #face = "bold",
    axis.title = element_text(color = "black",size = 12),
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 12),
    panel.background = element_blank(), 
    # legend.position = "top",
    legend.position = c(0.53,0.9),
    rect = element_rect(fill = NA, size=0, color = NA),
    plot.background = element_rect(fill = NA, size=0, color = NA),
    legend.background = element_rect(fill = NA, size=0, color = NA),
    legend.key = element_rect(fill = NA, size=0, color = NA),
    legend.key.width = unit(10, "pt"),
    legend.spacing.y = unit(0, "pt"),
    # plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
    
    axis.text.x = element_text(color = "black", 
                               size = 12, 
                               angle = 45, 
                               hjust = 1,
                               vjust = 1.1
                               ),
    axis.text.y = element_text(color = "black", size = 12),
    plot.title = element_text(
      hjust = 0.5,          # 水平对齐：0=左, 0.5=中, 1=右
      # vjust = 0.5,          # 垂直对齐
      # size = 14,            # 字体大小
      # face = "bold",        # 字体样式：bold, italic, plain
      # color = "darkblue",   # 字体颜色
      margin = margin(t = 0, b = 10)  # 上下边距
    ),
    ) 

dev.off()
