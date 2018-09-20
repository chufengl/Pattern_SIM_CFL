#!/bin/bash


#SBATCH -p serial
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 1-12:00
##SBATCH -A chufengl
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
#SBATCH --mail-user=chufengl@asu.edu
#SBATCH --mail-type=ALL

module load matlab/2015a

#cd /home/chufengl/test_floder/matlab on saguaro test codes

matlab -nodesktop  -r "mat2h5('/home/chufengl/test_folder/MOF_pat_sim/MOF_batch13','MOF_2C_Zn_edge',1,40)"
