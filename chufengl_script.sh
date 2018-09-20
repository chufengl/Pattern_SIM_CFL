#!/bin/bash


#SBATCH -p serial
#SBATCH -n 28
#SBATCH -N 1
#SBATCH -t 1-12:00
##SBATCH -A chufengl
#SBATCH -o slurm.%j.out
#SBATCH -e slurm.%j.err
#SBATCH --mail-user=chufengl@asu.edu
#SBATCH --mail-type=ALL

module load matlab/2015a

#cd /home/chufengl/test_floder/matlab on saguaro test codes

matlab -nodesktop  < pattern_sim_main_saguaro_14.m

#job = batch('pattern_sim_main_saguaro','Pool',10)
#wait(job)
#load(job,)
#delete(job)
#clear job
