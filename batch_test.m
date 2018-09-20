%batch_test.m

function [] = batch_test(Npattern,PATH,NAME_sf,lp,Xsize,Msize,MF,Mosaicity,E_ph1,I0,R_beam,res,pixelsize,L,SCA)
global sf_list;
sf_list1=importdata(NAME_sf);
if isfield(sf_list1,'textdata')==0
    sf_list=sf_list1;
else
    sf_list=sf_list1.data;
end

save('sf_list.mat','sf_list');


end
