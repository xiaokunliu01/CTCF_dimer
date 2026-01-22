setwd("/home/lxk/private/DNase-C/dimer_paper/figS1/FR/R3/")

library(tidyverse)

df <- read.table("MicroC_K562_FR.tab", sep = "\t", header = F)
# 在读取数据后，绘图前添加这行代码
df[,1] <- factor(df[,1], levels = c("--", "-+", "++", "+-"))

# png("cis_trans_frequency.png", units = "in", width = 5, height = 4, res = 300, bg = "transparent")
pdf("MicroC_K562_FR.pdf", width = 3, height = 2.5, bg = "transparent")

ggplot(data = df, mapping = aes(x = df[,4], y = df[,3], fill= df[,1])) + 
  geom_col(width = 0.5) +
  geom_hline(aes(yintercept=0.25), linetype="dashed", size=0.7) +
  geom_hline(aes(yintercept=0.5), linetype="dashed", size=0.7) +
  geom_hline(aes(yintercept=0.75), linetype="dashed", size=0.7) +
  scale_x_discrete(
    labels = c("0-0.1", "0.1-0.2", "0.2-0.3", "0.3-0.4", "0.4-0.5", "0.5-0.6", "0.6-0.7", "0.7-0.8", "0.8-0.9", "0.9-1.0"),
    expand = c(0,0)
  ) +
  scale_y_continuous(
    # breaks=seq(0,150,50),
    expand = c(0,0)
  ) +
  xlab("Distance (kb)") + 
  ylab("Proportion") + 
  labs(title = expression("Micro-C")) + 
  guides(fill = guide_legend(
    label.hjust = 0,
    # label.vjust = 0,
    ncol = 4,
    # keywidth = 0.6,
    # keyheight = 0.3
  )) +
  scale_fill_manual(
    limits = c("--", "-+", "++", "+-"),
    values = c("--" = "#fc9533", "-+" = "#b12425", "++" = "#9f79d3", "+-" = "#386CAF"),
    labels = c("RR","RF","FF","FR"),
  ) + 
  theme(
    panel.border = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text.x = element_text(color = "black", 
                               size = 10, 
                               angle = 45, 
                               hjust = 1,
                               vjust = 1.05
                               ),
    axis.text.y = element_text(color = "black", size = 10),
    axis.title = element_text(color = "black", size = 11),
    # plot.title = element_text(hjust = 0.5),
    plot.title = element_text(
      hjust = 0.5,          # 水平对齐：0=左, 0.5=中, 1=右
      # vjust = 0.5,          # 垂直对齐
      # size = 14,            # 字体大小
      # face = "bold",        # 字体样式：bold, italic, plain
      # color = "darkblue",   # 字体颜色
      margin = margin(t = 0, b = 25)  # 上下边距
    ),
    legend.position = c(0.5, 1.18),
    legend.title = element_blank(),
    legend.text = element_text(size = 10), #face = "bold",
    rect = element_rect(fill = NA, linewidth=0, color = NA),
    plot.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key.height = unit(0.4, "cm"),
    legend.key.width = unit(0.4, "cm")
    # plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
  )

dev.off()