setwd(dir = "/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/RAD21_degron/contact_distance/R2/Dimerization/R1/CTCF/")

df <- read.table("C-C_contact_distance.tab",sep = "\t", header = FALSE)
colnames(df) <- c("value", "type")

result <- df %>%
  mutate(
    interval_start = floor(value / 100) * 100,
    x = interval_start + 50
  ) %>%
  group_by(type) %>%  # 按类型分组
  count(x, name = "count") %>%
  arrange(type, x) %>%
  mutate(
    total = sum(count),  # 每组的总数
    frequency = count / total
  ) %>%
  ungroup()  # 取消分组

result <- result %>% 
  mutate(frequency = if_else(type == 'dTAG', frequency / 2.73, frequency))

# png("heatmap_cis_dis1k_17list.png", units = "in", width = 10, height = 10, res = 300, bg = "transparent")
pdf("C-C_contact_probability_norm.pdf", width = 4.5, height = 2.5, bg = "transparent")

result %>% 
  ggplot(aes(x=log10(x), y=log10(frequency))) +
  # geom_line(aes(color=type), linewidth=1.2)+
  geom_smooth(aes(color=type), method="loess", se=FALSE, span=0.6, linewidth=1.2) +
  
  # geom_point() +
  # geom_line(aes(color=type), linewidth=1.2)+
  # geom_density(aes(color=df[,2]), size=1.0) +
  scale_color_manual(
    limits = c("DMSO","dTAG"),
    values = c("DMSO"="#b12425",
               "dTAG"="#386CAF")
  ) +
  guides(color = guide_legend(
    title = NULL,
    # label.hjust = unit(0,"cm"),
    keywidth = 0.6,
    # keyheight = unit(0, "cm"),
    ncol = 1,
  ))+
  # labs(title=expression(""*Delta*"RAD21")) +
  labs(title=expression(atop(Delta*"RAD21", "CTCF contacts"))) +
  xlab("Distance (kb)") + 
  ylab("Contact probability") + 
  coord_cartesian(
    xlim = c(2, 6.5),
    ylim = c(-1.5, -4.2)
  ) +
  scale_x_continuous(
    # limits = c(2, 7),
    breaks = c(2, 3, 4, 5, 6),
    # breaks = c(-1, 0, 1, 2, 3, 4, 5),
    # labels = c(0.1, 1, 10, 100, 1000, 10000, 100000),
    # labels = expression(10^{-1}, 10^{0}, 10^{1}, 10^{2}, 10^{3}, 10^{4}, 10^{5}),
    # labels = math_format(10^.x),
    # labels = function(x) math_format(10^{.x})(x - 3),
    
    labels = c("0.1", "1", "10", "100", "1000"),
    expand = expansion(mult = c(0, .0))
  ) +
  scale_y_continuous(
    # limits = c(-1, -5),
    # breaks = c(0, 0.2, 0.4, 0.6, 0.8),
    # labels = c(0, 0.2, 0.4, 0.6, 0.8),
    # limits = c(-2, 0),
    
    breaks = c(-1, -2, -3, -4),
    labels = math_format(10^.x),
    expand = c(0, 0)
  ) +
  theme(axis.text = element_text(color = "black", size = 14), 
        # face = "bold",
        axis.title = element_text(color = "black", size = 14),
        # axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5),
        panel.border = element_blank(), 
        panel.grid = element_blank(),
        panel.background = element_blank(), 
        legend.position = c(0.5,0.6),
        # legend.key.width = unit(0, "cm"),
        legend.text = element_text(color = "black",size = 14),
        legend.title = element_text(color = "black",size = 14),
        rect = element_rect(fill = NA, linewidth=0, color = NA),
        plot.background = element_rect(fill = NA, linewidth=0, color = NA),
        legend.background = element_rect(fill = NA, linewidth=0, color = NA),
        legend.key = element_rect(fill = NA, linewidth=0, color = NA),
        plot.title = element_text(
          # face = "bold", 
          # color = "black", 
          size = 15,
          hjust = 0.5,
          margin = margin(t = 0, b = -10)  # 上下边距
        )
  )

dev.off()
