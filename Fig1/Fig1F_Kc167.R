setwd("/home/lxk/private/DNase-C/dimer_paper/fig1/Kc167/DNase-C/R4/fig1f/")

library(tidyverse)

df <- read.table("fig1f.tab", sep = "\t", header = F)
df[,1] <- factor(df[,1], levels = c("hh", "ht", "th", "tt"))

# png("cis_trans_frequency.png", units = "in", width = 5, height = 4, res = 300, bg = "transparent")
pdf("fig1f.pdf", width = 2.8, height = 2.6, bg = "transparent")

ggplot(data = df, mapping = aes(x = df[,4], y = df[,3], fill= df[,1])) + 
  geom_col(width = 0.5) +
  geom_hline(aes(yintercept=0.25), linetype="dashed", linewidth=0.7) +
  geom_hline(aes(yintercept=0.5), linetype="dashed", linewidth=0.7) +
  geom_hline(aes(yintercept=0.75), linetype="dashed", linewidth=0.7) +
  coord_cartesian(
    ylim = c(0,1)
  ) +
  scale_x_discrete(
    limits = c("<=20","<=10","<=3"),
    labels = c(expression(""<="20"), expression(""<="10"), expression(""<="3")),
    expand = c(0,0)
  ) +
  scale_y_continuous(
    breaks = c(0,0.25,0.5,0.75,1),
    labels = c("0","25","50","75","100"),
    expand = c(0,0)
  ) +
  xlab("d1 & d2 (bp)") + 
  ylab("Proportion (%)") + 
  labs(title = "Kc167\nFootprint-C") +
  # expression(bolditalic("in situ") * bold(" Hi-C"))
  scale_fill_manual(
    limits = c("hh", "ht", "th", "tt"),
    values = c("hh" = "#fc9533", "ht" = "#9f79d3", "th" = "#386CAF", "tt" = "#b12425"),
    labels = c("3'-3'", "3'-5'", "5'-3'", "5'-5'"),
  ) +
  theme(
    panel.border = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text.x = element_text(color = "black", 
                               size = 12, 
                               angle = 0, 
                               hjust = 0.5,
                               vjust = 1
                               ),
    axis.text.y = element_text(color = "black", size = 12),
    axis.title = element_text(color = "black", size = 12),
    # plot.title = element_text(hjust = 0.5),
    plot.title = element_text(
      hjust = 0.5,          # 水平对齐：0=左, 0.5=中, 1=右
      # vjust = 0.5,          # 垂直对齐
      # size = 14,            # 字体大小
      # face = "bold",        # 字体样式：bold, italic, plain
      # color = "darkblue",   # 字体颜色
      margin = margin(t = 0, b = 10)  # 上下边距
    ),
    legend.position = "right",
    legend.title = element_blank(),
    legend.text = element_text(size = 12), #face = "bold",
    # legend.spacing.y = unit(10, "lines"),
    rect = element_rect(fill = NA, linewidth=0, color = NA),
    plot.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key.height = unit(0.5, "cm"),
    legend.key.width = unit(0.5, "cm")
    # plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
  )

dev.off()