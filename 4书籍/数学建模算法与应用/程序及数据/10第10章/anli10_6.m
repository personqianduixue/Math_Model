clc,clear
load x.txt   %原始的x组的数据保存在纯文本文件x.txt中
load y.txt   %原始的y组的数据保存在纯文本文件y.txt中
p=size(x,2);q=size(y,2);
x=zscore(x);y=zscore(y);   %标准化数据
n=size(x,1);  %观测数据的个数
%下面做典型相关分析，a1,b1返回的是典型变量的系数，r返回的是典型相关系数
%u1,v1返回的是典型变量的值，stats返回的是假设检验的一些统计量的值
[a1,b1,r,u1,v1,stats]=canoncorr(x,y)
%下面修正a1,b1每一列的正负号,使得a,b每一列的系数和为正
%对应的，典型变量取值的正负号也要修正
a=a1.*repmat(sign(sum(a1)),size(a1,1),1) 
b=b1.*repmat(sign(sum(b1)),size(b1,1),1)
u=u1.*repmat(sign(sum(a1)),size(u1,1),1)
v=v1.*repmat(sign(sum(b1)),size(v1,1),1)
x_u_r=x'*u/(n-1)   %计算x,u的相关系数
y_v_r=y'*v/(n-1)   %计算y,v的相关系数
x_v_r=x'*v/(n-1)   %计算x,v的相关系数
y_u_r=y'*u/(n-1)   %计算y,u的相关系数
ux=sum(x_u_r.^2)/p   %x组原始变量被u_i解释的方差比例
ux_cum=cumsum(ux)    %x组原始变量被u_i解释的方差累积比例
vx=sum(x_v_r.^2)/p   %x组原始变量被v_i解释的方差比例
vx_cum=cumsum(vx)    %x组原始变量被v_i解释的方差累积比例
vy=sum(y_v_r.^2)/q   %y组原始变量被v_i解释的方差比例
vy_cum=cumsum(vy)    %y组原始变量被v_i解释的方差累积比例
uy=sum(y_u_r.^2)/q   %y组原始变量被u_i解释的方差比例
uy_cum=cumsum(uy)    %y组原始变量被u_i解释的方差累积比例
val=r.^2             %典型相关系数的平方，M1或M2矩阵的非零特征值
