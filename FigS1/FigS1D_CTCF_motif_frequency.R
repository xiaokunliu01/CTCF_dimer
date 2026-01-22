# K562 Footprint-C data
setwd("/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/figS1/C_motif_frequency/")

library(tidyverse)

# png("CTCF_motif_frequency.png", units = "in", width = 4, height = 3, res = 300, bg = "transparent")
pdf("CTCF_motif_frequency.pdf", width = 2, height = 2.5, bg = "transparent")

DNase_single <- (44799 * 2 + 3366094) / (138329802 * 2)
DNase_both <- 44799 / 138329802

MNase_single <- (40859 * 2 + 1801761)/(47397402 * 2)
MNase_both <- 40859 / 47397402

df_1 <- data.frame(
  HiC = c("DNase", "MNase"), 
  single = c(DNase_single*100, MNase_single*100),
  both = c(DNase_both*1000*2.3, MNase_both*1000*2.3)
)

df <- df_1 %>% pivot_longer(
    cols = c('single', 'both'),
    names_to = "type",
    values_to = "frequency"
)

df$type <- factor(df$type, levels=c("single", "both"))

p <- ggplot(data = df, mapping = aes(x = HiC, y = frequency, fill = type)) + 
  geom_col(width = 0.7, position = "dodge") +
  scale_x_discrete( 
    limits = c("DNase", "MNase"),
    # breaks=seq(-200,200,50),
    expand = c(0,0)
  ) +
  scale_y_continuous(
    limits = c(0, 2.0),
    breaks = c(0, 0.5, 1.0, 1.5, 2.0),
    expand = c(0,0),
    sec.axis = sec_axis(~. /2.3, 
                        # name = expression(paste("pair frequency"," (\u0089)")),
                        name = "pair frequency (\u0089)",
                        breaks = c(0, 0.21, 0.42, 0.63, 0.84)
                        )
  ) +
  scale_fill_discrete(
    limits = c("single", "both"),
    type = c("#386CAF", "#fc9533")
  )+
  xlab("") + 
  ylab("single frequency (%)") + 
  labs(title = "") + 
  theme(
    panel.border = element_blank(),
    panel.grid = element_blank(),
    panel.background = element_blank(),
    axis.text.x = element_text(color = "black", size = 10, 
                               # angle = 45, hjust = 1, vjust = 1
                               ),
    axis.text.y.left = element_text(color = "#386CAF", size = 10),
    axis.title.y.left = element_text(color = "#386CAF", size = 10),
    axis.text.y.right = element_text(color = "#fc9533", size = 10),
    axis.title.y.right = element_text(color = "#fc9533", size = 10, angle = 90),
    axis.title.x = element_text(color = "black", size = 10),
    legend.position = "none",
    legend.title = element_blank(),
    legend.text = element_text( size = 10), #face = "bold",
    rect = element_rect(fill = NA, size=0, color = NA),
    plot.background = element_rect(fill = NA, size=0, color = NA),
    legend.background = element_rect(fill = NA, size=0, color = NA),
    legend.key = element_rect(fill = NA, size=0, color = NA),
  )
p

dev.off()
