setwd(dir = "/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/")

library(dplyr)
library(ggplot2)
library(scales)  # 需要加载scales包
library(ggtext)

df <- read.table("distance.tab",sep = "\t", header = FALSE)
colnames(df) <- c("value", "type")
df <- df %>% 
  mutate(value = log10(value))  # 以10为底的对数

# 按组计算密度
density_by_group <- df %>%
  group_by(type) %>%
  do({
    dens <- density(.$value)
    data.frame(x = dens$x, y = dens$y)
  })

# density_by_group <- density_by_group %>% 
#     mutate(y = if_else(type == 'R-C+', y / 1, y))

# png("heatmap_cis_dis1k_17list.png", units = "in", width = 10, height = 10, res = 300, bg = "transparent")
pdf("interaction_distance.pdf", width = 3.5, height = 2.5, bg = "transparent")

density_by_group %>% 
  ggplot(aes(x=x, y=y)) +
  geom_line(aes(color=type), size=1.2)+
  # geom_density(aes(color=df[,2]), size=1.0) +
  scale_color_manual(
    limits = c("R+C+", "R-C+", "common"),
    values = c("R+C+"="#b12425", "R-C+"="#386CAF", "common"="#9f79d3"),
    labels = c("RAD21<span style='color:red;'>+</span>CTCF+", "RAD21<span style='color:red;'>-</span>CTCF+", "common")
  ) +
  guides(color = guide_legend(
    title = "",
    # label.hjust = unit(0,"cm"),
    keywidth = unit(0.3,"cm"),
    # keyheight = unit(0, "cm"),
    ncol = 1,
    # label.theme = element_text(size = 13)
  ))+
  xlab("Distance (kb)") + 
  ylab("Density") +   
  coord_cartesian(
    xlim = c(3, 6)
  ) +
  scale_x_continuous(
    # limits = c(2, 8.4),
    breaks = c(3, 4, 5, 6),
    # breaks = c(-1, 0, 1, 2, 3, 4, 5),
    # labels = c(0.1, 1, 10, 100, 1000, 10000, 100000),
    # labels = expression(10^{-1}, 10^{0}, 10^{1}, 10^{2}, 10^{3}, 10^{4}, 10^{5}),
    # labels = function(x) math_format(10^{.x})(x - 3),
    # labels = math_format(10^.x),
    labels = c("1", "10", "100", "1000"),
    expand = expansion(mult = c(0.05, 0.1))
  ) +
  scale_y_continuous(
    limits = c(0, 1.0),
    breaks = c(0, 0.2, 0.4, 0.6, 0.8, 1.0),
    labels = c("0", "0.2", "0.4", "0.6", "0.8", "1.0"),
    expand = expansion(mult = c(0.05, .05))
  ) +
  theme(axis.text = element_text(color = "black", size = 14), 
        # face = "bold",
        axis.title = element_text(color = "black", size = 14),
        # axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
        panel.border = element_blank(), 
        panel.grid = element_blank(),
        panel.background = element_blank(), 
        legend.position = c(0.36,0.87),
        # legend.key.width = unit(0, "cm"),
        # legend.text = element_text(color = "black",size = 15),
        legend.title = element_text(color = "black",size = 14),
        legend.text = element_markdown(
          size = 14,            # 字体大小
          # face = "bold",        # 字体样式：bold, italic, plain
          color = "black",   # 字体颜色
          # margin = margin(t = 0, b = 10)  # 上下边距
        ),
        rect = element_rect(fill = NA, size=0, color = NA),
        plot.background = element_rect(fill = NA, size=0, color = NA),
        legend.background = element_rect(fill = NA, size=0, color = NA),
        legend.key = element_rect(fill = NA, size=0, color = NA),
  )


dev.off()

