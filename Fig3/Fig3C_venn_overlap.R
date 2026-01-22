setwd(dir = "/home/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/")

library(VennDiagram)


# 假设已知的数量
only_A <- 1455  # 仅属于A的
only_B <- 4554   # 仅属于B的
overlap_AB <- 52253 # A与B的交集

# 绘制韦恩图（核心函数）
venn_plot <- draw.pairwise.venn(
  area1 = only_A + overlap_AB, # A的总大小
  area2 = only_B + overlap_AB, # B的总大小
  cross.area = overlap_AB,     # 交集大小
  category = c("RAD21-CTCF+", "RAD21+CTCF+"), # 集合名称
  fill = c("#386CAF", "#b12425"), # 填充色
  alpha = 0.5, # 透明度
  # cat.pos = c(0, 0), # 标签位置（角度）
  # ext.text = FALSE, # 禁用外部比例文本
  # ind = FALSE, # 不显示区域标签
  lwd = c(0,0),
  
  # 位置和大小控制
  euler.d = TRUE,        # 使用欧拉图（推荐）
  scaled = TRUE,         # 根据面积缩放
  
  # 数字标签字体
  # cex = 1.5,                    # 数字字体大小
  # fontface = "bold",            # 粗体
  # fontfamily = "Arial",     # 字体族
  label.col = "black",          # 数字颜色
  
  # 类别标签字体
  # cat.cex = 1.5,                # 类别标签字体大小
  # cat.fontface = "bold", # 粗斜体
  # cat.fontfamily = "Arial", # 字体族
  cat.col = "black", # 类别标签颜色
  # cat.pos = c(-35, 35),         # 标签位置角度
  # cat.dist = c(0.1, 0.1),       # 距离圆心距离
)

# 显示图形
grid.newpage() # 清空当前图形页面
grid.draw(venn_plot)

# 保存图形（例如为PNG）
# png("venn_diagram.png", width = 800, height = 600, res = 150)
pdf("vennplot.pdf", width = 1.7, height = 1.7, bg = "transparent")
grid.draw(venn_plot)
dev.off()
