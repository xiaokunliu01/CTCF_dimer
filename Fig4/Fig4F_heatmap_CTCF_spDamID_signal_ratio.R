setwd(dir = "/home/lxk/private/DNase-C/dimer_paper/fig4/spDamID/enrichment/R3/")

library(ggplot2)
library(reshape2)

df <- read.table("DCAC_DCSAC_count_norm.bed", sep = "\t", header = FALSE)
colnames(df) <- c("chr", "start", "end", "name", "score", "strand", "NT", "Swap")
# df <- df %>% mutate(Index = row_number())

# 计算 (NT - Swap) / (NT + 1)，按NT列排序，然后选择相关列
df_sorted <- df %>%
  filter(NT>0) %>%
  arrange(NT) %>%  # 按NT列从小到大排序
  mutate(Ratio = (NT - Swap) / (NT)) %>%  # 计算比值
  select(7:9)  # 选择NT、Swap和Ratio列
  
  
# 提取第4、5、6列并转换为长格式
long_df <- df_sorted %>%
  select(3) %>%
  mutate(row_id = 1:n())  %>%  # 添加行ID
  pivot_longer(cols = -row_id,  # 将非row_id列转换为长格式
               names_to = "Sample", 
               values_to = "Expression")

# png("interaction_footprint_5p.png", units = "in", width = 5, height = 5, res = 300, bg = "transparent")
pdf("fig4_heatmap_40bp_ratio.pdf", width = 0.43, height = 3.3, bg = "transparent")

# 绘制热图
ggplot(long_df, aes(x = Sample, y = row_id, fill = Expression)) +
  geom_tile(width = 0.5, height = 0.8) +
  scale_fill_gradient2(
    low = "blue",
    mid = "white",
    high = "red",
    midpoint = 0,
    limits = c(-1, 1),
    # na.value = "#b12425",
    breaks = c(-1, 0, 1),
  ) +
  # scale_fill_gradient2(
  #   low = "#313695",      # 深蓝
  #   mid = "#ffffbf",      # 淡黄
  #   high = "#a50026",     # 深红
  #   midpoint = 0,
  #   name = "Expression"
  # ) +
  coord_cartesian(
    # xlim = c(0, 1.5),
    # ylim = c(0, 1.5)
  ) +
  scale_x_discrete(
    position = "top",
    # limits  = c(-dis, dis),
    # breaks = seq(-dis, dis, bin),
    labels = c("1-Swap/NT"),
    expand = c(0,0)
  ) +
  scale_y_continuous(
    expand = c(0,0)
  ) +
  labs(
    title = "CTCF spDamID", 
    x = NULL, 
    y = NULL, 
    # fill = "Expression"
    )+
theme(
  axis.text = element_text(color = "black",size = 12), #face = "bold",
  axis.title = element_text(color = "black",size = 12),
  axis.title.y = element_blank(),
  axis.text.y = element_blank(),
  axis.ticks = element_blank(),
  panel.border = element_blank(), 
  panel.grid = element_blank(),
  legend.title = element_blank(),
  legend.text = element_text(size = 12),
  panel.background = element_blank(), 
  legend.position = "bottom",
  rect = element_rect(fill = NA, linewidth=0, color = NA),
  plot.background = element_rect(fill = NA, linewidth=0, color = NA),
  legend.background = element_rect(fill = NA, linewidth=0, color = NA),
  legend.key = element_rect(fill = NA, linewidth=0, color = NA),
  plot.title = element_text(
    # face = "bold", 
    # color = "black", 
    # size = 16, 
    hjust = 0.5),
  legend.key.width = unit(0.15, "cm"),
  legend.key.height = unit(0.3, "cm"),
  legend.margin = margin(-5, 0, -5, 0),
)

dev.off()
