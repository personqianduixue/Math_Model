clear;clc;
A=load('S_xy_BU.mat');
UA=load('BioD.mat');
UVA=load('AV_DeD_BioUD.mat');
len1=length(UA.node1);
%C=load('C.mat');
C=zeros(len1,4);
%len1=length(C.C);
D=zeros(len1,4);
C(:,1)=UA.node1;
C(:,2)=UA.node2;
len=length(A.S_xy);
index=1:len;
B=zeros(sum(index),4);
i=1;
k=1;
while i<len+1 
     B(k:k+len-i,1)=i*ones(len+1-i,1);
    B(k:k+len-i,2)=i:len;
    B(k:k+len-i,3)=A.S_xy(i,i:len);
    B(k:k+len-i,4)=UVA.AV_DeD(i,i:len);
    k=k+1+len-i;
    i=i+1;
end
B(:,1:2)=B(:,1:2)-1;
[B1 B2]=find(isnan(B));
B(B1,:)=[];
len2=length(B);
%[tf1 loc1]=ismember(B(:,1),C(:,1));
%[tf2 loc2]=ismember(B(:,2),C(:,2));
%len2=length(loc1);
%j=1;
%jj=1;
%while j<len2+1
    %if loc1(j)~0
    %if loc1(j)==loc2(j);
        %D(jj,:)=B(j,:);
       % jj=jj+1;
   % end
   % end
    %j=j+1;
%end
%j=1;
%k=1;
%while j<len2+1
    %while k<length(D);
    %if B(j,1:2)-C(k,1:2)==zeros(1,2);
        %D(k,:)=B(j,:);
       %  k=k+1;
    %end
    %end
   % j=j+1;
%    






        
    
   
        