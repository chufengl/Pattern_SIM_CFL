#!/bin/bash

#SBATCH --job-name=sim_TAB_gen_ni
#SBATCH -p serial
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 1-12:00
#SBATCH --mem-per-cpu=32000    
##SBATCH --array=19,20%8

##SBATCH -A chufengl
#SBATCH -o sim_TAB_gen_ni_%A.out
#SBATCH -e sim_TAB_gen_ni_%A.err
##SBATCH --mail-type=ALL
#SBATCH --mail-type=ALL        # notifications for job done & fail
#SBATCH --mail-user=chufengl@asu.edu # send-to address

module load matlab/2016a


matlab -nodesktop  -r "addpath('/home/chufengl/test_folder/MOF_pat_sim','-end'); TAB_gen_ni;exit"
