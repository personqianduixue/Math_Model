clear all;
close all;
clc
X1=[1 1 1 1, 1 0 0 1, 1 1 1 1, 1 0 0 1];  %识别模式
X2=[0 1 0 0, 0 1 0 0, 0 1 0 0, 0 1 0 0];
X3=[1 1 1 1, 1 0 0 1, 1 0 0 1, 1 1 1 1];
X=[X1;X2;X3];
Y1=[1 0 0];                           %输出模式           
Y2=[0 1 0];
Y3=[0 0 1];
Yo=[Y1;Y2;Y3];
n=16; %输入层神经元个数
p=8;  %中间层神经元个数
q=3;  %输出神经元个数
k=3 ;%训练模式个数
a1=0.2; b1=0.2; %学习系数，
%rou=0.5;%动量系数，
emax=0.01; cntmax=100;%最大误差，训练次数
[w,v,theta,r,t,mse]=bptrain(n,p,q,X,Yo,k,emax,cntmax,a1,b1);%调用函数bptrain训练网络
X4=[1 1 1 1, 1 0 0 1, 1 1 1 1, 1 0 1 1 ];
disp('模式X1的识别结果：')%测试并显示对图形的识别结果
c1=bptest(p,q,n,w,v,theta,r,X1)
disp('模式X2的识别结果：')
c2=bptest(p,q,n,w,v,theta,r,X2)
disp('模式X3的识别结果：')
c3=bptest(p,q,n,w,v,theta,r,X3)
disp('模式X4的识别结果：')
c4=bptest(p,q,n,w,v,theta,r,X4)
c=[c1;c2;c3;c4];
for i=1:4
    for j=1:3
       if c(i,j)>0.5
          c(i,j)=1;
      elseif c(i,j)<0.2
       c(i,j)=0;
       end
    end
end
disp('模式X1~X4的识别结果：')
c