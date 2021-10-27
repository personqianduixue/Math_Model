clear;
clc;
dq1=xlsread('筛选.xls','欠发达');
zhn=dq1(:,2);
zkn=dq1(:,3);
for j=1:length(zhn)
     if(isnan(zhn(j))==1)
        zhn(j)=0;
     end
end
n1=sum(zhn);%载货车数
for j=1:length(zkn)
     if(isnan(zkn(j))==1)
        zkn(j)=0;
     end
end
n2=sum(zkn); %载客车数
[m,n]=size(dq1);
x=zeros(m,9);
x(:,1)=0.8*maxmin(dq1(:,4))+0.2*maxmin(dq1(:,5));
x(:,2)=0.5*maxmin(dq1(:,6))+0.5*maxmin(dq1(:,7));
x(:,3)=maxmin(dq1(:,9)+dq1(:,10));
x(:,4)=0.5*maxmin(dq1(:,11))+0.5*maxmin(dq1(:,12));
x(:,5)=maxmin(dq1(:,13));
x(:,6)=maxmin(dq1(:,15)+dq1(:,16)+dq1(:,17)+dq1(:,18));
x(:,7)=maxmin(dq1(:,19)+dq1(:,20)+dq1(:,21)+dq1(:,22));
x(:,8)=-0.1*maxmin(dq1(:,23))+0.9*maxmin(dq1(:,24));
x(:,9)=maxmin(dq1(:,26));


