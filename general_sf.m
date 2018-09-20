% "general_sf.m" is to general structure factors for a certain lattice from
% the corresponding imported structure factor list.

function [HKL,HKL_in,sf]=general_sf(A,XYZ,res,sf_list)

%global sf_list;
HKL=A\XYZ;
HKL_in=round(HKL);


if mod(-HKL_in(1)+HKL_in(2)+HKL_in(3),3)~=0
   
      sf=0;
else 
if (XYZ.'*XYZ)<=(1/res)^2
    
    
    ind=find((sf_list(:,1)==abs(HKL_in(1)))&(sf_list(:,2)==abs(HKL_in(2)))&(sf_list(:,3)==abs(HKL_in(3))));
    
    if isempty(ind)==1
        sf=0;
    elseif size(ind,1)==1
        sf=sf_list(ind,4);
    else
        disp(num2str(ind))
        error('the HKL found in the structure factor list is not unique!!PLS CHECK!')
    end
    
else
   sf=0;
end
end
end
