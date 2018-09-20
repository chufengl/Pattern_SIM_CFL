% "two_color_randori.m" generates the two-color pattern using Gaussian peak
% profile.

function [] = two_color_randori(Npattern,PATH,NAME_sf,lp,Xsize,Msize,MF,Mosaicity,E_ph1,E_ph2,I0,R_beam,res,pixelsize,L,SCA)
%myCluster = parcluster('local')
%myCluster.NumWorkers = 28
%saveProfile(myCluster);
%myCluster


poolobj=parpool('local',28)

%PATH='/Users/chufeng/Desktop/I3C structure files/I3C_1C_Zn';
logfile=fullfile(PATH,'pattern_log.txt');
fileID=fopen(logfile,'a');
fprintf(fileID,'\n\n\n\n\nTwo Color MOF simulated patterns using Gaussian peak profile at Zn edge.\r\n');
fprintf(fileID,['\nNpattern=%4.0f;\r\nNAME_sf=%20s;\r\nlp=[%6.2f,%6.2f,%6.2f,%6.2f,%6.2f,%6.2f];\r\nXsize=%7fnm;\r\nmosaic block size=%7fnm;\r\n',...
    'MF=%3.2e;\r\nmosaicity=%7.4fdegrees;\r\nphoton energy1=%7.2fKeV;\r\nphoton energy2=%7.2fKeV;\r\nphoton flux=%7.2e;\r\nbeam radius=%7.2fum;\r\n'... 
    'resolution limit=%7.3fAngstroms;\r\npixel size=%7.2fum;\r\ncamera length=%7.4fm;\r\nMax scattering angle=%7.4fdegrees\n\n'],Npattern,NAME_sf,lp,Xsize,Msize,MF,Mosaicity,E_ph1,E_ph2,I0,R_beam,res,pixelsize,L,SCA);
%sf_file=fullfile(PATH,NAME_sf)
global sf_list;
%sf_list1=importdata(sf_file);
%if isfield(sf_list1,'textdata')==0
%    sf_list=sf_list1;
%else
%    sf_list=sf_list1.data;
%end
load('sf_list.mat');
sf_list(1:5,:)

%generate random orientations.
phi_M=random('uniform',-175,175,[Npattern,1]);
theta_M=random('uniform',2,88,[Npattern,1]);
alpha_M=random('uniform',-175,175,[Npattern,1]);
Ori_X_M=[phi_M,theta_M,alpha_M];


for NP=1:Npattern

tic
    Ori_X=Ori_X_M(NP,:);
    two_color_s
    
    FNAME=['MOF_2C_Zn_edge',num2str(NP),'.mat'];
    
    matfile=fullfile(PATH,FNAME);
    save(matfile,'Int_C1','Int_C2','Int_2C','Xsize','NAME_sf','lp','Ori_X','I0','R_beam','res','pixelsize','L','MF','Mosaicity','Msize');
    
    
    fprintf(fileID,'%20s\r\ncrystal orientation=[%5.2f,%5.2f,%5.2f]\n',FNAME,Ori_X(1),Ori_X(2),Ori_X(3));
    
    
    DIS=[num2str(NP),' OF ',num2str(Npattern),' PATTERNS COMPLETED.'];
    
    disp(DIS)
toc    
end






fclose(fileID);

delete(poolobj)

end
