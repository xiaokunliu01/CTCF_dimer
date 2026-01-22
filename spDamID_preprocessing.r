R1f <- file("DCTCF_R1_val_1.fq.gz", "r")
R1 <- readLines(R1f, n = 4)
R2f <- file("DCTCF_R2_val_2.fq.gz", "r")
R2 <- readLines(R2f, n = 4)
while(length(R1) != 0 & length(R2) != 0) {
  if(substr(R1[2],3,6) == "GTCT" | substr(R2[2],3,6) == "GTCT"){
    cat(R1, file = "DCTCF_R1_val_1_GTCT.fq", sep = '\n', append = T)
    cat(R2, file = "DCTCF_R2_val_2_GTCT.fq", sep = '\n', append = T)
  }
  R1 <- readLines(R1f, n = 4)
  R2 <- readLines(R2f, n = 4)
}
