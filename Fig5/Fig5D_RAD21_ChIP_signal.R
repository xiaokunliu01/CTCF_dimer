setwd("/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig5/ChIP/RAD21")

library(tidyverse)


# df <- read.table("ChIP_SMC1_C2D5_all_CTCFmotif_Mm_profile.csv", sep = ",", header = F)
# df <- as.data.frame(t(data.frame(df, row.names = 1)))

df <- read.table("ChIP_RAD21_C2D5_all_CTCFmotif_profile.tab", sep = "\t", header = FALSE, skip = 2)
df <- as.data.frame(t(data.frame(df[,-2], row.names = 1)))
bins <- seq(from = -1000, to = 995, by = 5)
df <- cbind(bins, df)


pdf("RAD21_spike_in.pdf", width = 3.2, height = 2.5, bg = "transparent")
# png("RAD21_spike_in.png", units = "in", width = 2.8, height = 2.8, res = 300, bg = "white")

ggplot(data = df, mapping = aes(x = bins)) + 
  geom_line(aes(y = df[,2]/1, color = "blk"), size = 1.2) +
  geom_line(aes(y = df[,3]/0.88, color = "Y226A; F228A"), size = 1.2) +
  geom_line(aes(y = df[,4]/0.39, color = "del 232-265"), size = 1.2) +
  geom_line(aes(y = df[,5]/0.61, color = "hCTCF"), size = 1.2) +
  scale_color_manual(
    limits = c("hCTCF", "del 232-265", "Y226A; F228A", "blk"),
    values = c(
      "blk" = "#fc9533",
      "Y226A; F228A" = "#9f79d3",
      "del 232-265" = "#7FC87F",
      "hCTCF" = "#b12425"
      ),
    labels = c("FL", expression(Delta*"(233-265)"), "Y226A; F228A", "no vec")
    ) + 
  guides(
    color=guide_legend(
      # labels = c("DNase-C", expression(paste(italic('in situ'), ' Hi-C')), "Micro-C", "BL-Hi-C", "Hi-TrAC"),
      nrow=5,
      byrow=TRUE,
      # label.hjust = 1,
      keywidth = 0.45
      )
    ) +
  xlab("Distance from CTCF motif (bp)") + 
  ylab("ChIP signal") +
  labs(title = "RAD21 ChIP") +
  coord_cartesian(
    ylim = c(0, 4)
  ) +
  scale_x_continuous(
    limits = c(-1000, 1000), 
    expand =  expansion(mult = c(0, .055))
  ) +
  scale_y_continuous(
    # limits = c(0, 45),
    # breaks = seq(0,45,15),
    # name = "DNase-C enrichment",
    # sec.axis = sec_axis(~. *5, name="DNase-seq enrichment"),
    expand = expansion(mult = c(.055, 0))
  ) + 
  theme(
    axis.text = element_text(color = "black",size = 16), #face = "bold",
    axis.title = element_text(color = "black",size = 16),
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(
      size = 16,
      margin = margin(r = 10, l = 1) # 增大标签右侧边距，即增大与符号的距离
    ),
    panel.background = element_blank(), 
    legend.position = c(0.91,0.65),
    rect = element_rect(fill = NA, linewidth=0, color = NA),
    plot.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key = element_rect(fill = NA, linewidth=0, color = NA),
    # plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
    plot.title = element_text(
      hjust = 0.5,          # 水平对齐：0=左, 0.5=中, 1=右
      # vjust = 0.5,          # 垂直对齐
      size = 17,            # 字体大小
      # face = "bold",        # 字体样式：bold, italic, plain
      # color = "darkblue",   # 字体颜色
      margin = margin(t = 0, b = 10)  # 上下边距
    ),
    legend.spacing.x = unit(0.8, "cm")
  )
dev.off()

