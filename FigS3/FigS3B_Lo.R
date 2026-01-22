setwd("/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/figS3/S3B/")

library(tidyverse)

df <- read.table("DamID_CTCFmotif_profile.tab", sep = "\t", header = F, skip = 2)
df <- df %>% select(-c(1, 2))

df <- as.data.frame(t(df))
dis <- seq(-1000,990,10)
df <- cbind(dis, df)


# tiff("enrichment_Hi_C_scale.tiff", units = "in", width = 4, height = 3, res = 300, bg = "transparent")
pdf("enrichment_nosignal.pdf", width = 3.0, height = 2.5, bg = "transparent")

ggplot(data = df, mapping = aes(x = dis)) + 
  geom_line(aes(y = df[,3], color = "NT"), linewidth = 1.2) +
  geom_line(aes(y = df[,5], color = "Swap"), linewidth = 1.2) +
  scale_color_manual(
    limits = c("NT", 
               "Swap"
    ),
    values = c(
      "NT" = "#b12425",
      "Swap" = "#386CAF"
    ),
    labels = c(
      "NT", 
      "Swap"
    )
  ) + 
  guides(
    color=guide_legend(
      nrow=2, 
      byrow=TRUE,
      # label.hjust = 1,
      keywidth = 0.7
    )
  ) +
  xlab("Distance from CTCF motif (bp)") + 
  ylab("DamID signal") +
  labs(title = "Lo Dam") +
  coord_cartesian(
    xlim = c(-1000,1000)
  ) +
  scale_x_continuous(
    # limits = c(-500, 500),
    expand =  expansion(mult = c(0.0, .055))
    ) +
  scale_y_continuous(
    limits = c(0, 0.8),
    breaks = seq(0,0.8,0.2),
    # name = "DNase-C enrichment",
    # sec.axis = sec_axis(~. *5, name="DNase-seq enrichment"),
    expand = c(0,0)
  ) + 
  theme(
    axis.text = element_text(color = "black",size = 13), #face = "bold",
    axis.title = element_text(color = "black",size = 13),
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 13),
    panel.background = element_blank(), 
    # legend.position = "top",
    legend.position = c(0.8,0.8),
    rect = element_rect(fill = NA, linewidth=0, color = NA),
    plot.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key = element_rect(fill = NA, linewidth=0, color = NA),
    # plot.margin = margin(t = 0, r = 0, b = 0, l = 0, unit = "pt")
    plot.title = element_text(
      hjust = 0.5,          # 水平对齐：0=左, 0.5=中, 1=右
      # vjust = 0.5,          # 垂直对齐
      size = 14,            # 字体大小
      # face = "bold",        # 字体样式：bold, italic, plain
      # color = "darkblue",   # 字体颜色
      margin = margin(t = 0, b = 10)  # 上下边距
    ),
  ) 


dev.off()

