clc, clear
load data2  %分别加载xi的观测值x0，yi的观测值y0
mf=@(cs,xdata)1/sqrt(2*pi)/cs(2)*exp(-(xdata-cs(1)).^2/cs(2)^2/2);
% yc=mf([2,1],1)  %测试匿名函数
cs=lsqcurvefit(mf,rand(2,1),x0,y0)  %拟合参数的初始值是任意取的
