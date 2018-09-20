%"mat2h5.m" converts matlab data files to h5 files.
function []= mat2h5(PATH,FNAME_com,startfileID,endfileID)

File_v=startfileID:endfileID;
for k=File_v
    tic 
    FNAME_mat=[FNAME_com,num2str(k),'.mat'];
    FNAME_h5=[FNAME_com,num2str(k),'.h5'];
    matfile=fullfile(PATH,FNAME_mat);
    h5file=fullfile(PATH,FNAME_h5);
    load(matfile);
    h5create(h5file,'/photon_energy_eV',[1 1]);
    E_ph=9600;
    h5write(h5file,'/photon_energy_eV',E_ph);
    h5create(h5file,'/data',size(Int_2C),'Datatype','int16');
    h5write(h5file,'/data',int16(1e3*Int_2C));
    toc
disp([num2str(k),' patterns out of ',num2str(size(File_v,2)),' completed.']);

end
end

