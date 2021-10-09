clc,clear
x0=[71.1 72.4 72.4 72.1 71.4 72.0 71.6]'; %注意这里为列向量
n=length(x0);
lamda=x0(1:n-1)./x0(2:n)  %计算级比
range=minmax(lamda')  %计算级比的范围
x1=cumsum(x0);  %累加运算
B=[-0.5*(x1(1:n-1)+x1(2:n)),ones(n-1,1)];
Y=x0(2:n);
u=B\Y  %拟合参数u(1)=a,u(2)=b
x=dsolve('Dx+a*x=b','x(0)=x0'); %求微分方程的符号解
x=subs(x,{'a','b','x0'},{u(1),u(2),x0(1)}); %代入估计参数值和初始值
yuce1=subs(x,'t',[0:n-1]); %求已知数据的预测值
y=vpa(x,6)   %其中的6表示显示6位数字
yuce=[x0(1),diff(yuce1)]  %差分运算，还原数据
epsilon=x0'-yuce    %计算残差
delta=abs(epsilon./x0')  %计算相对误差
rho=1-(1-0.5*u(1))/(1+0.5*u(1))*lamda'  %计算级比偏差值，u(1)=a
