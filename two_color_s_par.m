%two_color_s_par.m

parfor k=1:N_pix
    x0=(k-(N_pix+1)/2)*pixelsize*1e-6;
   for l=1:N_pix
        y0=(l-(N_pix+1)/2)*pixelsize*1e-6;
        x_p1=k01*x0/sqrt(x0^2+y0^2+L^2);
        y_p1=k01*y0/sqrt(x0^2+y0^2+L^2);
        z_p1=k01*(1-L/sqrt(x0^2+y0^2+L^2));
        
         x_p2=k02*x0/sqrt(x0^2+y0^2+L^2);
         y_p2=k02*y0/sqrt(x0^2+y0^2+L^2);
         z_p2=k02*(1-L/sqrt(x0^2+y0^2+L^2));
        
       for m=1:N_M
            Q=Q_X*reshape(Q_M(m,:,:),3,3);
            XYZ1=Q*[x_p1,y_p1,z_p1].';
            [HKL,HKL_in,sf]=general_sf(A,XYZ1,res,sf_list);
            DeltaHKL=HKL-HKL_in;
            Pat1(l,k,m)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^1*(pixelsize*1e-6/L)^2*exp(-(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)/(2*(MF*0.1/Msize)^2))*(10*Msize/lp(1))^3*Msize;%Gaussian model with normalization prefactor.
             XYZ2=Q*[x_p2,y_p2,z_p2].';
             [HKL,HKL_in,sf]=general_sf(A,XYZ2,res,sf_list);
             DeltaHKL=HKL-HKL_in;
             Pat2(l,k,m)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^1*(pixelsize*1e-6/L)^2*exp(-(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)/(2*(MF*0.1/Msize)^2))*(10*Msize/lp(1))^3*Msize;%Gaussian model with normalization prefactor.
            
        end
    end
%     DIS=[num2str((((k-1)*N_pix+(l-1))*N_M+m)/(N_pix^2*N_M)),' has been completed.'];
%             
%             disp(DIS)
end
