setwd(dir = "/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/figS1/vplot/DNaseC_293T_DNase/")
library(tidyverse)
library(colorspace)
# png("FragmentLengthVsDistance_K562_FA_DHS_q220.png", units = "in", width = 5, height = 3, res = 300, bg = "transparent")
pdf("FragmentLengthVsDistance_CTCF_motif.pdf", width = 3.2, height = 3, bg = "transparent")

df <- read.table("FragmentLengthVsDistance_CTCF_motif.csv", sep = ";", header = F)
# df_line1 <- data.frame(x = c(0, -40), y = c(0, 75))
# df_line2 <- data.frame(x = c(0, 40), y = c(0, 75))
# df_line3 <- data.frame(x = c(-53.33, 53.33), y = c(0, 0))

ggplot(df, aes(x=df[,2], y=df[,1])) + 
  stat_density_2d(geom = "tile", aes(fill = after_stat(density)^1), contour = FALSE, n=200) +
  scale_fill_gradient2(low = "white", high = "dodgerblue4") +
  # geom_point(alpha = 1/20, size = 1/1, color = "dodgerblue4") +
  # geom_abline(intercept = 0, slope = 1.875, color="red", size = 1.2) +
  # geom_abline(intercept = 0, slope = -1.875, color="red", size = 1.2) +
  # geom_vline(xintercept = -53.33, color="red", size = 1.2) +
  # geom_vline(xintercept = 53.33, color="red", size = 1.2) +
  annotate("text", x=-60, y=10, label="DNase", colour = "red", size=4.5) +
  # CTCF motif 64.4%
  # DHS 65.2%
  xlab("Distance from dDHS (bp)") + ylab("Fragment Length (bp)") + 
  labs(title = "Footprint-C 1D") +
  coord_cartesian(
    xlim = c(-80, 80),
    ylim = c(0, 100),
  ) +
  scale_x_continuous( 
    breaks=seq(-80,80,40),
    expand = expansion(mult = c(0, .03))
  ) +
  scale_y_continuous(
    # breaks=seq(0,150,50),
    expand = c(0,0)) +
  theme(
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text = element_text(color = "black", size = 12), #face = "bold",
    axis.title = element_text(color = "black", size = 12),
    legend.position = "none",
    legend.title = element_blank(), 
    legend.text = element_text(size = 12),
    rect = element_rect(fill = NA, size=0, color = NA),
    plot.background = element_rect(fill = NA, size=0, color = NA),
    legend.background = element_rect(fill = NA, size=0, color = NA),
    legend.key = element_rect(fill = NA, size=0, color = NA),
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


