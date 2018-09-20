%"two_color_s.m" is a segment of "two_color_randori.m"

%global lp Xsize Msize Mosaicity E_ph I0 R_beam res pixelsize L SCA Ori_X;
lamda1=12.4/E_ph1;
k01=1/lamda1;

lamda2=12.4/E_ph2;
k02=1/lamda2;


%detector parameters

N_pix=2*round(L*tan(SCA/180*pi)/(pixelsize*1e-6))+1;

N_M=round((Xsize/Msize)^3);% number of mosaic blocks in a crystal.



Qua_X=zeros(1,4);% quaternion
Qua_X(1)=cos(Ori_X(3)/180*pi/2);
Qua_X(2)=sin(Ori_X(2)/180*pi)*cos(Ori_X(1)/180*pi)*sin(Ori_X(3)/180*pi/2);
Qua_X(3)=sin(Ori_X(2)/180*pi)*sin(Ori_X(1)/180*pi)*sin(Ori_X(3)/180*pi/2);
Qua_X(4)=cos(Ori_X(2)/180*pi)*sin(Ori_X(3)/180*pi/2);
Q_X=zeros(3,3);% rotation matrix in terms of quaternion.
Q_X(1,1)=1-2*Qua_X(3)^2-2*Qua_X(4)^2;
Q_X(1,2)=2*Qua_X(2)*Qua_X(3)+2*Qua_X(1)*Qua_X(4);
Q_X(1,3)=2*Qua_X(2)*Qua_X(4)-2*Qua_X(1)*Qua_X(3);
Q_X(2,1)=2*Qua_X(2)*Qua_X(3)-2*Qua_X(1)*Qua_X(4);
Q_X(2,2)=1-2*Qua_X(2)^2-2*Qua_X(4)^2;
Q_X(2,3)=2*Qua_X(3)*Qua_X(4)+2*Qua_X(1)*Qua_X(2);
Q_X(3,1)=2*Qua_X(2)*Qua_X(4)+2*Qua_X(1)*Qua_X(3);
Q_X(3,2)=2*Qua_X(3)*Qua_X(4)-2*Qua_X(1)*Qua_X(2);
Q_X(3,3)=1-2*Qua_X(2)^2-2*Qua_X(3)^2;
R_X=Q_X.';
A=zeros(3);



% the following is true only for orthorhombic,cubic,hexagonal lattices, if not, should
% modify non-zero non-diagonal elements of A.
llp(1)=random('normal',lp(1),lp(1)*0.005);
llp(2)=random('normal',lp(2),lp(2)*0.005);
llp(3)=random('normal',lp(3),lp(3)*0.005);


aa=[llp(1);0;0];
bb=[llp(2)*cosd(lp(6));llp(2)*sind(lp(6));0];
cc=[0;llp(3)*cosd(lp(4));llp(3)*sind(lp(4))];

A(:,1)=cross(bb,cc)/dot(aa,cross(bb,cc));
A(:,2)=cross(cc,aa)/dot(aa,cross(bb,cc));
A(:,3)=cross(aa,bb)/dot(aa,cross(bb,cc));

%Generate orientations for mosaic blocks
Ori_M=zeros(N_M,4);
Ori_M(:,1)=(1:1:N_M).';
phi_M=(random('uniform',-180,180,[N_M,1])).';
theta_M=(random('uniform',0,90,[N_M,1])).';
alpha_M=(random('uniform',-Mosaicity,Mosaicity,[N_M,1])).';
Ori_M(:,2)=phi_M;
Ori_M(:,3)=theta_M;
Ori_M(:,4)=alpha_M;
Qua_M=zeros(N_M,4);% quaternion
Qua_M(:,1)=cos(Ori_M(:,4)/180*pi/2);
Qua_M(:,2)=sin(Ori_M(:,3)/180*pi).*cos(Ori_M(:,2)/180*pi).*sin(Ori_M(:,4)/180*pi/2);
Qua_M(:,3)=sin(Ori_M(:,3)/180*pi).*sin(Ori_M(:,2)/180*pi).*sin(Ori_M(:,4)/180*pi/2);
Qua_M(:,4)=cos(Ori_M(:,3)/180*pi).*sin(Ori_M(:,4)/180*pi/2);
Q_M=zeros(N_M,3,3);% rotation matrix in terms of quaternion.
Q_M(:,1,1)=1-2*Qua_M(:,3).^2-2*Qua_M(:,4).^2;
Q_M(:,1,2)=2*Qua_M(:,2).*Qua_M(:,3)+2*Qua_M(:,1).*Qua_M(:,4);
Q_M(:,1,3)=2*Qua_M(:,2).*Qua_M(:,4)-2*Qua_M(:,1).*Qua_M(:,3);
Q_M(:,2,1)=2*Qua_M(:,2).*Qua_M(:,3)-2*Qua_M(:,1).*Qua_M(:,4);
Q_M(:,2,2)=1-2*Qua_M(:,2).^2-2*Qua_M(:,4).^2;
Q_M(:,2,3)=2*Qua_M(:,3).*Qua_M(:,4)+2*Qua_M(:,1).*Qua_M(:,2);
Q_M(:,3,1)=2*Qua_M(:,2).*Qua_M(:,4)+2*Qua_M(:,1).*Qua_M(:,3);
Q_M(:,3,2)=2*Qua_M(:,3).*Qua_M(:,4)-2*Qua_M(:,1).*Qua_M(:,2);
Q_M(:,3,3)=1-2*Qua_M(:,2).^2-2*Qua_M(:,3).^2;
R_M=permute(Q_M,[1 3 2]);


%calculate the intensity on detector pixels

Pat1=zeros(N_pix,N_pix,N_M);
Pat2=zeros(N_pix,N_pix,N_M);

% parfor k=1:N_pix
%     x0=(k-(N_pix+1)/2)*pixelsize*1e-6;
%    for l=1:N_pix
%         y0=(l-(N_pix+1)/2)*pixelsize*1e-6;
%         x_p1=k01*x0/sqrt(x0^2+y0^2+L^2);
%         y_p1=k01*y0/sqrt(x0^2+y0^2+L^2);
%         z_p1=k01*(1-L/sqrt(x0^2+y0^2+L^2));
%         
% %         x_p2=k02*x0/sqrt(x0^2+y0^2+L^2);
% %         y_p2=k02*y0/sqrt(x0^2+y0^2+L^2);
% %         z_p2=k02*(1-L/sqrt(x0^2+y0^2+L^2));
%         
%        for m=1:N_M
%             Q=Q_X*reshape(Q_M(m,:,:),3,3);
%             XYZ1=Q*[x_p1,y_p1,z_p1].';
%             [HKL,HKL_in,sf]=general_sf(A,XYZ1,res,sf_list);
%             DeltaHKL=HKL-HKL_in;
%             Pat1(l,k,m)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^1*(pixelsize*1e-6/L)^2*exp(-(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)/(2*(MF*0.1/Msize)^2))*(10*Msize/lp(1))^3*Msize;%Gaussian model with normalization prefactor.
% %             XYZ2=Q*[x_p2,y_p2,z_p2].';
% %             [HKL,HKL_in,sf]=general_sf(A,XYZ2,res);
% %             DeltaHKL=HKL-HKL_in;
% %             Pat2(l,k,m)=I0/(pi*(R_beam*1e-6)^2)*(2.82e-15)^2*sf^1*(pixelsize*1e-6/L)^2*exp(-(DeltaHKL(1)^2/lp(1)^2+DeltaHKL(2)^2/lp(2)^2+DeltaHKL(3)^2/lp(3)^2)/(2*(MF*0.1/Msize)^2))*(10*Msize/lp(1))^3*Msize;%Gaussian model with normalization prefactor.
%             
%         end
%     end
% %     DIS=[num2str((((k-1)*N_pix+(l-1))*N_M+m)/(N_pix^2*N_M)),' has been completed.'];
% %             
% %             disp(DIS)
% end

%job = batch('one_color_s_par','Profile','local','Matlabpool',10);
%wait(job);
%load(job);
%delete(job);
%clear job

%job=batch('one_color_s_par','Pool',10);
two_color_s_par
%wait(job)
%load(job)


Int_C1=reshape(sum(Pat1,3),N_pix,N_pix);
Int_C2=reshape(sum(Pat2,3),N_pix,N_pix);
Int_2C=Int_C1+Int_C2;
%Int_1C=Int_C1; % modified from "two_color" script.
% figure
% pcolor(log(Int_2C))
% axis square
% colormap jet
% colorbar
% shading interp
% 
% figure;pcolor(Int_2C);axis square;colormap gray;colorbar;shading interp;caxis([0 1]);
%delete(job)
%clear job
