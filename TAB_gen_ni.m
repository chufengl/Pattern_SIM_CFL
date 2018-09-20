alpha=90;
s=sqrt(1/sind(alpha));
lp=[25.9322,25.9322*s,6.8365*s,alpha,90.00,120.00];

%lp=[9.0214,15.735,18.816,90.00,90.00,90.00];

a=[lp(1);0;0];
b=[lp(2)*cosd(lp(6));lp(2)*sind(lp(6));0];
c=[0;lp(3)*cosd(lp(4));lp(3)*sind(lp(4))];


limit_up=30;%upper limit of Miller indices.
sf_list=zeros((limit_up+1)^3,3);
sf_counter=1;
for h=0:limit_up
for k=0:limit_up
for l=0:limit_up
sf_list(sf_counter,:)=[h,k,l];
sf_counter=sf_counter+1;
end
end
end
sf_list1=sf_list;

A=zeros(3);

aa=a;
bb=b;
cc=c;
A(:,1)=cross(bb,cc)/dot(aa,cross(bb,cc));
A(:,2)=cross(cc,aa)/dot(aa,cross(bb,cc));
A(:,3)=cross(aa,bb)/dot(aa,cross(bb,cc));
%-------------------------------------------

res=[40,1];
sf_list=[sf_list1,1e5*ones(size(sf_list1,1),1),zeros(size(sf_list1,1),1)];
for l=1:size(sf_list,1)
HKL=sf_list(l,1:3).';
XYZ=A*HKL;
sf_list(l,size(sf_list,2))=1/sqrt(XYZ.'*XYZ);
end
[temp,ind]=sort(sf_list(:,size(sf_list,2)),'descend');
sf_list=sf_list(ind,:);
[row1]=find(sf_list(:,size(sf_list,2))<=res(1),1);
[row2]=find(sf_list(:,size(sf_list,2))<=res(2),1);
if isempty(row2)
row2=size(sf_list,1);
else
end
sf_list=sf_list(row1:row2,:);
sf_list_ext=zeros(8*size(sf_list,1),size(sf_list,2));
row_counter=1;
for l=1:size(sf_list,1)
H=sf_list(l,1);
K=sf_list(l,2);
L=sf_list(l,3);
if H==0
if K==0
if L==0
sf_list_ext(row_counter,:)=sf_list(l,:);
row_counter=row_counter+1;
else
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[0,0,-L,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+2;
end
else
if L==0
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[0,-K,0,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+2;
else
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[0,K,-L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+2,:)=[0,-K,L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+3,:)=[0,-K,-L,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+4;
end
end
else
if K==0
if L==0
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[-H,0,0,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+2;
else
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[H,0,-L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+2,:)=[-H,0,L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+3,:)=[-H,0,-L,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+4;
end
else
if L==0
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[H,-K,0,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+2,:)=[-H,K,0,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+3,:)=[-H,-K,0,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+4;
else
sf_list_ext(row_counter,:)=sf_list(l,:);
sf_list_ext(row_counter+1,:)=[H,K,-L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+2,:)=[H,-K,L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+3,:)=[-H,K,L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+4,:)=[H,-K,-L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+5,:)=[-H,K,-L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+6,:)=[-H,-K,L,sf_list(l,4:size(sf_list,2))];
sf_list_ext(row_counter+7,:)=[-H,-K,-L,sf_list(l,4:size(sf_list,2))];
row_counter=row_counter+8;
end
end
end
end
sf_list_ext=sf_list_ext(1:row_counter-1,:);
global sf_list;
sf_list=sf_list_ext;

%TAB_size=0.9e7;m_start=1;m_end=1185;
%TAB=zeros(TAB_size,10);
%-----------------------------------------
%
%TAB_row_counter=1;
%m=m_start;
%while (m<=(size(sf_list,1)-1))&&(m<=m_end)


%HKL1=sf_list(m,1:3).';

%n=m+1;
%while n<=size(sf_list,1)&& (TAB_row_counter<=TAB_size)
%HKL2=sf_list(n,1:3).';
%[L1,L2,LR,Ang]=LRA(A,HKL1,HKL2);
%TAB(TAB_row_counter,1:3)=HKL1.';
%TAB(TAB_row_counter,4:6)=HKL2.';
%TAB(TAB_row_counter,7:10)=[L1,L2,LR,Ang];
%TAB_row_counter=TAB_row_counter+1;
%n=n+1;
%end
%m=m+1;
%end
%TAB=TAB((1:TAB_row_counter-1),:);
%NAME_file=['TAB_',num2str(alpha),'.mat'];
save('MOF_sf_list.mat','sf_list');
