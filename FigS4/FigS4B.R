setwd("/mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/CTCF_motif_annotation/")

library(fmsb)
library(tidyverse)
df <- read.table("CTCF-CTCF_contact_freq.tab", sep = "\t", header = FALSE)

df_long <- df %>% 
  select(1,2,4) 

colnames(df_long) <- c("category", "value", "group")

# 转为宽表格
dat <- df_long %>%
  pivot_wider(
    names_from = category,
    values_from = value,
    id_cols = group
  )%>%
  rename(
    tandemF = `++`,
    divergent = `-+`,
    convergent = `+-`,
    tandemR = `--`
  )%>%
  column_to_rownames(var = "group")

# dat <- data.frame(
#   row.names = c('DMSO spec', 'common', 'dTAG spec'),
#   convergent = c(898, 296, 497),
#   tandemF = c(1237, 670, 648),
#   divergent = c(1090, 526, 609),
#   tandemR = c(1170, 648, 526)
# )

rowsum = rowSums(dat)
dat <- dat/rowsum

max_min <- data.frame(
  convergent = c(0.6, 0),
  tandemF = c(0.6, 0),
  divergent = c(0.6, 0),
  tandemR = c(0.6, 0)
)
rownames(max_min) <- c("Max", "Min")
df <- rbind(max_min, dat)


# png("FragmentLengthVsDistance_delZF3.png", units = "in", width = 2.8, height = 2.1, res = 300, bg = "white")
pdf("radar_CTCF-CTCF_contact_freq.pdf", width = 4.5, height = 4.5, bg = "transparent")

radarchart(df, 
           # maxmin = FALSE,
           axistype=1,
           seg = 3,
           # custom polygon
           pcol=c("#b12425", "#386CAF","#9f79d3"),
           # pfcol=rgb(0.2,0.5,0.5,0.5),
           plwd=c(2.5, 2.5),
           plty=c(1,1),
           # custom the grid
           cglcol="grey",
           cglty=1,
           axislabcol="black",
           caxislabels=c('0', '20%', '40%', '60%'),
           cglwd=1,
           # custom labels
           vlcex=1,
           centerzero=TRUE,
           vlabels=c('Convergent', 'Tandem F','Divergent','Tandem R'),
           title = 're-HiChIP'
             # expression(paste(Delta, "RAD21"))
)

legend(
  # 设置legend位置
  # x = "topleft",
  x=0.2,
  y=1.2,
  
  legend = rownames(df[-c(1,2),]),
  horiz = FALSE,
  bty = "n",
  pch = 20 ,
  col = c( "#b12425", "#386CAF","#9f79d3"),
  text.col = "black",
  cex = 1,
  pt.cex = 1.5,
  
  # legend = c("Common", "RAD21+CTCF+","RAD21-CTCF+")
)


dev.off()