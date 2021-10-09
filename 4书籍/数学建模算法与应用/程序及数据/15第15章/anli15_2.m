clc,clear
syms x y
syms z positive  %由于导弹在空中，定义符号变量z为正
format long g  %长小数的数据显示格式
a=load('daodan.txt'); %把原始的全部数据保存到纯文本文件daodan.txt中
d=a(:,[2:end]);  %提取3个测距仪到观测点的距离，a的第一列为时间
n=size(a,1); sol=[]; %sol为保存观测点坐标的矩阵，这里初始化
for i=1:n
eq1=x^2+y^2+z^2-d(i,1)^2;  %定义非线性方程组的符号方程的左端项
eq2=x^2+(y-4500)^2+z^2-d(i,2)^2;
eq3=(x+2000)^2+(y-1500)^2+z^2-d(i,3)^2; 
[xx,yy,zz]=solve(eq1,eq2,eq3);  %求x,y,z的符号解。
sol=[sol;double([xx,yy,zz])];  %数据类型转换，符号数据无法进行插值运算
end
sol %显示求得的10个点的坐标
pp1=csape(a(:,1),sol(:,1))  %求x(t)的插值函数
xishu1=pp1.coefs(end,:)  %显示x(t)最后一个区间的三次样条函数的系数
pp2=csape(a(:,1),sol(:,2))  %求y(t)的插值函数
xishu2=pp2.coefs(end,:)  %显示y(t)最后一个区间的三次样条函数的系数
pp3=csape(a(:,1),sol(:,3))  %求z(t)的插值函数
xishu3=pp3.coefs(end,:)  %显示z(t)最后一个区间的三次样条函数的系数
