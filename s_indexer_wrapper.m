%%Matlab sparse indexing wrapper.


addpath('/home/chufengl/test_folder/sparse indexing source codes','-end');
poolobj=parpool('local',12);
end_id=plist_counter(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)]);
Base_name=BN_pre($SLURM_ARRAY_TASK_ID);
[all_solution,index_rate]=run_batch(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)],[Base_name,num2str($SLURM_ARRAY_TASK_ID),'e'],1,end_id);
[abc_star_out,com_counter]=abc_star_compute(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)]),stream_out(['/home/chufengl/test_folder/run',num2str($SLURM_ARRAY_TASK_ID)],'/home/chufengl/test_folder');
delete(poolobj);
exit