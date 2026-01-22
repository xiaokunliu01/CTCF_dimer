setwd("/home/lxk/private/DNase-C/dimer_paper/fig1/293T/HiChIP_bio-dNTP/")
library(tidyverse)
library(Cairo)

# df <- data.frame(
#   dis =     c(50,   45.0, 40.0, 35.0, 30.0, 25.0, 20.0, 15.0, 10.0, 5.0),
#   biodNTP = c(36.0, 36.7, 38.0, 39.7, 41.8, 43.7, 45.8, 48.8, 53.6, 72.8),
#   linker =  c(36.5, 36.9, 37.5, 38.4, 39.7, 40.7, 42.6, 48.4, 56.6, 89.4)
# )

df <- data.frame(
  dis =     c(40.0, 35.0, 30.0, 25.0, 20.0),
  biodNTP = c(38.0, 39.7, 41.8, 43.7, 45.8),
  linker =  c(37.5, 38.4, 39.7, 40.7, 42.6)
)

df <- df %>%
  pivot_longer(
    cols = c("biodNTP", "linker"),
    names_to = "type",
    values_to = "proportion"      
  )

df$dis <- factor(df$dis, levels = c("40", "35", "30", "25", "20"))

# CairoPDF("bio_vs_link.pdf", width = 2.5, height = 2, bg = "transparent", family ="Arial")
# png("con_tt_bias_bio_vs_link.png", units = "in", width = 2.5, height = 2.5, res = 300, bg = "transparent")
pdf("bio_vs_link.pdf", width = 2.0, height = 2.3, bg = "transparent")

ggplot(data = df, mapping = aes(x=dis, y=proportion, color=type)) + 
  geom_line(aes(group=type), size = 1) + 
  geom_point(size = 3) +
  labs(title = "5'-5'") + 
  xlab("d1 & d2 (bp)") + 
  ylab("Proportion (%)") + 
  scale_y_continuous(
    limits = c(37, 45.8),
    expand = expansion(mult = c(0.02, .04))
    ) +
  scale_x_discrete(
    # limits = c(40, 35, 30, 25, 20),
    # breaks = c(40, 35, 30, 25, 20),
    # labels = c("≤ 20",  '≤ 25', '≤ 30', '≤ 35', '≤ 40'),
    labels = c(expression(""<="40"),
               expression(""<="35"),
               expression(""<="30"),
               expression(""<="25"),
               expression(""<="20") # “小于等于20”
               ),
    expand = expansion(mult = c(0.07, .045))
    ) +
  guides(
    color = guide_legend(
      ncol = 1,
      keywidth = 0.01,
      )
    ) +  
  scale_color_manual(
    values = c("biodNTP"="#b12425", "linker"="#386CAF"),
    limits = c("biodNTP","linker"),
    labels = c("no linker","linker")
  ) +
  theme(
    axis.text = element_text(color = "black",size = 12), #face = "bold",
    axis.title = element_text(color = "black",size = 12),
    axis.text.x = element_text(color = "black", 
                               size = 12, 
                               angle = 45, 
                               hjust = 1,
                               vjust = 1
    ),
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 12),
    panel.background = element_blank(), 
    # legend.position = "top",
    legend.position = c(0.4,0.8),
    rect = element_rect(fill = NA, size=0, color = NA),
    plot.background = element_rect(fill = NA, size=0, color = NA),
    legend.background = element_rect(fill = NA, size=0, color = NA),
    legend.key = element_rect(fill = NA, size=0, color = NA),
    # plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
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
