clc,clear
p1=6/14;p2=8/14;
a=[24.8   24.1   26.6  23.5   25.5  27.4
-2.0  -2.4   -3.0   -1.9   -2.1   -3.1]';
b=[22.1  21.6   22.0  22.8   22.7  21.5   22.1   21.4
-0.7  -1.4   -0.8  -1.6   -1.5  -1.0  -1.2  -1.3]';
n1=6;n2=8;
mu1=mean(a);mu2=mean(b); %计算两个总体样本的均值向量,注意得到的是行向量
cov1=cov(a);cov2=cov(b);  %计算两个总体样本的协方差矩阵
k=log(p2/p1)+0.5*log(det(cov1)/det(cov2))+...
    0.5*(mu1*inv(cov1)*mu1'-mu2*inv(cov2)*mu2')  %计算K值
syms x1 x2
x=[x1 x2];
wx=-0.5*x*(inv(cov1)-inv(cov2))*x.'+(mu1*inv(cov1)-mu2*inv(cov2))*x.';
wx=vpa(wx,6);  
wx=simple(wx)   %化简并显示判别函数
ahat=subs(wx,{x1,x2},{a(:,1),a(:,2)})'  %计算总体1样本的判别函数值
bhat=subs(wx,{x1,x2},{b(:,1),b(:,2)})'  %计算总体2样本的判别函数值
sol1=(ahat>=k),sol2=(bhat<k)  %回代，计算误判
