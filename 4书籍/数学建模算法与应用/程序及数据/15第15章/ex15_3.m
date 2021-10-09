clc,clear
x0=[41,49,61,78,96,104]; %原始序列
n=length(x0); 
x1=cumsum(x0)  %计算1次累加序列
a_x0=diff(x0)' %计算1次累减序列
z=0.5*(x1(2:end)+x1(1:end-1))'; %计算矩阵序列
B=[-x0(2:end)',-z,ones(n-1,1)]; 
u=B\a_x0   %最小二乘法拟合参数
x=dsolve('D2x+a1*Dx+a2*x=b','x(0)=c1,x(5)=c2');  %求边值问题的符号解
x=subs(x,{'a1','a2','b','c1','c2'},{u(1),u(2),u(3),x1(1),x1(6)});
yuce=subs(x,'t',0:n-1); %求已知数据点1次累加序列的预测值
x=vpa(x,6) %显示6位数字的符号解
x0_hat=[yuce(1),diff(yuce)]; %求已知数据点的预测值
x0_hat=round(x0_hat) %四舍五入取整数
epsilon=x0-x0_hat    %求残差
delta=abs(epsilon./x0)  %求相对误差
