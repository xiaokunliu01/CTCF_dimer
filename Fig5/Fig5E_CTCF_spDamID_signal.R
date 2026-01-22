setwd("/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig5/spDamID/enrichment/R3/")

library(tidyverse)

df <- read.table("DamID_CTCFmotif_profile.tab", sep = "", header = FALSE, skip = 2)
df <- as.data.frame(t(data.frame(df, row.names = 1)))
dis <- seq(-1000,980,20)
df <- cbind(dis, df)


# tiff("enrichment_Hi_C_scale.tiff", units = "in", width = 4, height = 3, res = 300, bg = "transparent")
pdf("enrichment.pdf", width = 3.8, height = 2.5, bg = "transparent")

ggplot(data = df, mapping = aes(x = dis)) + 
  geom_line(aes(y = df[,2], color = "Full-length"), linewidth = 1.2) +
  geom_line(aes(y = df[,3], color = "d233-265"), linewidth = 1.2) +
  geom_line(aes(y = df[,4], color = "D only"), linewidth = 1.2) +
  geom_line(aes(y = df[,5], color = "AM only"), linewidth = 1.2) + 
  scale_color_manual(
    limits = c("Full-length", 
               "d233-265",
               "D only",
               "AM only"
    ),
    values = c(
      "Full-length" = "#b12425",
      "d233-265" = "#386CAF",
      "D only" = "#FCBF85",
      "AM only" = "#BDADD3"
    ),
    labels = c(
      "FL", 
      expression(Delta*"(233-265)"),
      "D only",
      "AM only"
    )
  ) + 
  guides(
    color=guide_legend(
      nrow=2, 
      byrow=FALSE,
      # label.hjust = 1,
      keywidth = 0.5
    )
  ) +
  xlab("Distance from CTCF motif (bp)") + 
  ylab("DamID signal") +
  labs(title = "CTCF spDamID") +
  coord_cartesian(
    xlim = c(-500,500),
    ylim = c(0, 0.6)
  ) +
  scale_x_continuous(
    limits = c(-500, 500),
    expand =  expansion(mult = c(0.0, .055))
    ) +
  scale_y_continuous(
    # limits = c(0, 0.5),
    breaks = seq(0,0.6,0.2),
    # name = "DNase-C enrichment",
    # sec.axis = sec_axis(~. *5, name="DNase-seq enrichment"),
    expand = expansion(mult = c(.055, 0))
  ) + 
  theme(
    axis.text = element_text(color = "black",size = 13), #face = "bold",
    axis.title = element_text(color = "black",size = 13),
    panel.border = element_blank(), 
    panel.grid = element_blank(),
    legend.title = element_blank(),
    legend.text = element_text(size = 13,margin = margin(r = 20,l=1)),
    panel.background = element_blank(), 
    # legend.position = "top",
    legend.position = c(0.5,0.9),
    rect = element_rect(fill = NA, size=0, color = NA),
    plot.background = element_rect(fill = NA, size=0, color = NA),
    legend.background = element_rect(fill = NA, size=0, color = NA),
    legend.key = element_rect(fill = NA, size=0, color = NA),
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

