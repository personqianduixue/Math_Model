clear;
clc;
A=xlsread('各地区9个指标得分');
B=xlsread('各地区9个指标得分','较发达地区');
C=xlsread('各地区9个指标得分','中度发达');
D=xlsread('各地区9个指标得分','欠发达');
 e=[A' B' C' D']';
 [m,n]=size(e);
 f=zeros(m,9);%排序指标
 pj=zeros(4,9);%各级指标
 
 for i=1:9
     f(:,i)=sort(e(:,i+1));
 pj(1,i)=f(floor(0.8*m),i);
  pj(2,i)=f(floor(0.6*m),i);
   pj(3,i)=f(floor(0.4*m),i);
    pj(4,i)=f(floor(0.2*m),i);
 end
 pj
 
 
 
 