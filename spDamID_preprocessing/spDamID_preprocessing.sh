mv DCTCF_raw_1.fq.gz DCTCF_R1.fq.gz
mv DCTCF_raw_2.fq.gz DCTCF_R2.fq.gz
for i in DCTCF;do
	trim_galore -q 20 -j 7 --phred33 --stringency 3 --length 20 -e 0.1 --paired ${i}_R*fq.gz -o ./
	/usr/bin/Rscript ${i}.r
	cutadapt -u 6 -o  ${i}_R1_val_1_GTCT_cut.fq ${i}_R1_val_1_GTCT.fq
	cutadapt -u 6 -o  ${i}_R2_val_2_GTCT_cut.fq ${i}_R2_val_2_GTCT.fq
	bowtie2 -p 20 --no-unal --no-mixed  --no-discordant --dovetail --very-sensitive --score-min L,0,-0.4 -X 1000 -x /ssd/index/bowtie2/hg38XX -1 ${i}_R1_val_1_GTCT_cut.fq -2 ${i}_R2_val_2_GTCT_cut.fq | samtools view -bh -q 10 > ${i}_q10.bam
	samtools sort -@ 40 -o ${i}_q10.sort.bam ${i}_q10.bam
	java -jar /mnt/disk1/6/share/software/picard.jar MarkDuplicates -REMOVE_DUPLICATES true --VALIDATION_STRINGENCY SILENT -I ${i}_q10.sort.bam -O ${i}_q10_markdup_DIS10k.bam -M ${i}_DIS10k.metrics --OPTICAL_DUPLICATE_PIXEL_DISTANCE 10000 --MAX_OPTICAL_DUPLICATE_SET_SIZE 300000 --TAGGING_POLICY All > ${i}_DIS10k.log 2>&1
	samtools sort -@ 30 -n -o ${i}_q10.sortn.bam ${i}_q10_markdup_DIS10k.bam
	bedtools bamtobed -i ${i}_q10_markdup_DIS10k.bam | sort -k1,1 -k2,2n -k3,3n -S 25G| awk '$1!~/chr[CLMT]/' | awk '{if($6=="+") print $1"\t"$2-2"\t"$2+2; else print $1"\t"$3-2"\t"$3+2 }'|awk '{if ($2>0) print $0}' > ${i}_q10_unique.bed.start.end
        bedtools getfasta -fi /home/whh/private/DamID/hg38.fa -bed ${i}_q10_unique.bed.start.end -tab > ${i}.start.end.tab
        grep -i "gatc" ${i}.start.end.tab > ${i}.start.end.gatc.tab
        awk -F '\t' '{print$1}' OFS='\t' ${i}.start.end.gatc.tab |  awk -F ':' '{print$1,$2}' OFS='\t' | awk -F '-' '{print$1,$2}' OFS='\t' > ${i}.start.end.gatc.tab.bed
	num=$(cat ${i}.start.end.gatc.tab.bed | awk 'END{print FNR}')
	genomeCoverageBed -bg -i ${i}.start.end.gatc.tab.bed -g /ssd/genome/hg38_chromsize.txt | awk -va=$num '{$4=$4*1000000/a;print}' OFS='\t' > ${i}.bdg
	bedGraphToBigWig ${i}.bdg /ssd/genome/hg38_chromsize.txt ${i}.bw
done
