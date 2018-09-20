%% find spot splitting for image pieces.
%----------------------------------------------------------------------

function [peak_candi_counter,peak_candi] = SPF_piece(Int_p,NB_s,N_pix_sch,ADC_thld)

[Int_p_v,ind]=pix_sort(Int_p);

peak_candi=zeros(N_pix_sch,3);
peak_candi_counter=0;

for k=1:N_pix_sch
    I_cen=Int_p_v(k);
    if I_cen>=ADC_thld
        r_cen=ind(k,1);
        c_cen=ind(k,2);
        max_valid=NB_com(r_cen,c_cen,NB_s,Int_p);
        if max_valid
            peak_candi_counter=peak_candi_counter+1;
            peak_candi(peak_candi_counter,:)=[r_cen,c_cen,I_cen];
        end
    else
        continue
    end
    
   
   
end
peak_candi=peak_candi(1:peak_candi_counter,:);
end

%----------------------------------------------------------------------
