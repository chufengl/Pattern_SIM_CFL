%% sort the image according to pix value from max to min
%----------------------------------------------------------------------
function [Int_p_v,ind]=pix_sort(Int_p)
Int_p_v=reshape(Int_p,[],1);
[Int_p_v,ind_v]=sort(Int_p_v,'descend');
ind_c=floor((ind_v-ones(size(ind_v)))/size(Int_p,1))+ones(size(ind_v));
ind_r=ind_v-(ind_c-ones(size(ind_v)))*size(Int_p,1);
ind=[ind_r,ind_c];
end


%----------------------------------------------------------------------

