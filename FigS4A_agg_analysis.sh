#!/bin/bash

awk '{if(NR==1 || $30==0) print $0}' ../diff_dloops.txt > common_loop.txt

# RAD21
cLoops2 agg -d /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/RAD21_CTCF_samp/ -o RAD21_CTCF_RAD21_spec -loops /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/diff_RAD21_CTCF_samp_specific_dloops.txt -loop_norm -p 80 -loop_vmin 0 -loop_vmax 10

cLoops2 agg -d /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/RAD21_CTCF_samp/ -o RAD21_CTCF_noRAD21_spec -loops /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/diff_noRAD21_CTCF_samp_specific_dloops.txt -loop_norm -p 80 -loop_vmin 0 -loop_vmax 10

cLoops2 agg -d /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/RAD21_CTCF_samp/ -o RAD21_CTCF_common -loops common_loop.txt -loop_norm -p 80 -loop_vmin 0 -loop_vmax 10


# noRAD21

cLoops2 agg -d /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/noRAD21_CTCF_samp/ -o noRAD21_CTCF_RAD21_spec -loops /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/diff_RAD21_CTCF_samp_specific_dloops.txt -loop_norm -p 80 -loop_vmin 0 -loop_vmax 10

cLoops2 agg -d /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/noRAD21_CTCF_samp/ -o noRAD21_CTCF_noRAD21_spec -loops /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/diff_noRAD21_CTCF_samp_specific_dloops.txt -loop_norm -p 80 -loop_vmin 0 -loop_vmax 10

cLoops2 agg -d /mnt/disk1/6/lxk/private/DNase-C/dimer_paper/fig3/reHiChIP/overlap/R3/noRAD21_CTCF_samp/ -o noRAD21_CTCF_common -loops common_loop.txt -loop_norm -p 80 -loop_vmin 0 -loop_vmax 10