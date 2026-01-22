setwd(dir = "/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig1/Kc167/DNase-C/R4/")

library(tidyverse)

df <- read.table("/home/lxk/ad1/DNaseC/total/Kc167/dimer/CTCF2+/interaction_footprint.tab",sep = "\t", header = F)
df <- df %>% filter(df[,6]<=50 & df[,7]<=50 & df[,8]>=100)

# png("interaction_footprint_50-_FL.png", units = "in", width = 3, height = 2, res = 300, bg = "transparent")
pdf("interaction_footprint_50-_FL.pdf", width = 2.5, height = 2.0, bg = "transparent")

ggplot(data = df, mapping = aes(x=abs(df[,6])+abs(df[,7]), y=df[,9], fill=df[,9], color=df[,9])) + 
  geom_violin() + #scale = "count"
  xlab("L1 + L2 (bp)") + 
  ylab(NULL) + 
  labs(title = "Kc167\nFootprint-C") + 
  scale_x_continuous(
    limits = c(0,100),
    breaks=seq(0,100,25),
    expand = expansion(mult = c(0.05, .02))
    ) +
  scale_y_discrete(
    limits = c("tt","th","ht","hh"),
    labels = c("5'-5'", "5'-3'", "3'-5'", "3'-3'"),
    # expand = c(0,0)
    ) +
  scale_color_manual(
    values = c(
      "tt" = "#b12425",
      "ht" = "#9f79d3",
      "th" = "#386CAF",
      "hh" = "#fc9533"
      )
    ) +
  scale_fill_manual(
    values = c(
      "tt" = "#b12425",
      "ht" = "#9f79d3",
      "th" = "#386CAF",
      "hh" = "#fc9533"
      )
    ) +
  theme(
    # panel.border = element_blank(), 
    panel.grid = element_blank(),
    panel.background = element_blank(),
    # axis.text.x = element_text(color = "black", size = 12, angle = 45, hjust = 1, vjust = 1),
    axis.text = element_text(color = "black", size = 10), #face = "bold",
    axis.title = element_text(color = "black", size = 10),
    legend.position = "none",
    legend.title = element_blank(), 
    legend.text = element_text(size = 10),
    rect = element_rect(fill = NA, linewidth=0, color = NA),
    plot.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.background = element_rect(fill = NA, linewidth=0, color = NA),
    legend.key = element_rect(fill = NA, linewidth=0, color = NA),
    plot.title = element_text(
      # face = "bold", 
      # color = "black", 
      # size = 16, 
      hjust = 0.5),
    panel.border = element_rect(
      color = "black",
      fill = NA,
      linewidth = 1,
      linetype = "solid"  # 或 "dashed", "dotted"
    )
  )

dev.off()
