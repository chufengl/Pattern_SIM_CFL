%sim_peaklist_maker.m generates the peak list according to the SPIND
%format.
function [] = sim_peak_list_maker(PATH,Basename,start_id,end_id)

%Basename='I3C_1C_Zn_edge';
addpath('./');
cd(PATH)

for l=start_id:end_id 
    load([Basename,num2str(l),'.mat']);
    [peak_candi_counter,peak_candi] = SPF_piece(Int_1C,1,1e6,1);
    plist=zeros(size(peak_candi,1),6);
    plist(:,1:2)=peak_candi(:,1:2)-851*ones(size(peak_candi,1),2);
    plist(:,3)=peak_candi(:,3);
    plist(:,4)=plist(:,3);
    plist(:,5)=9.61e3*ones(size(peak_candi,1),1);
    plist(:,6)=zeros(size(peak_candi,1),1);
    fileID=fopen([Basename,num2str(l),'.txt'],'w');
    fprintf(fileID,'%e %e %e %e %e %e\n',plist.');
    
    
    fclose(fileID);
end

end
