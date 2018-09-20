%% compare pix value against the Neighbourhood
%----------------------------------------------------------------------
function [max_valid] = NB_com(r_cen,c_cen,NB_s,Int_p)
    I_cen=Int_p(r_cen,c_cen);
    com_counter=0;
    for l=(r_cen-NB_s):(r_cen+NB_s)
        for m=(c_cen-NB_s):(c_cen+NB_s)
            
            if (l>0)*(m>0)*(l<=size(Int_p,1))*(m<=size(Int_p,2))==0
                break
            else
                I_NB=Int_p(l,m);
                if I_cen>=I_NB
                    com_counter=com_counter+1;
                else
                    %max_valid=0;
                    break
                    
                end
                
            end
            

            
        end
    end
    if com_counter==((2*NB_s+1)^2)
        max_valid=1;
    else
        max_valid=0;
    end
    
    
    
end
