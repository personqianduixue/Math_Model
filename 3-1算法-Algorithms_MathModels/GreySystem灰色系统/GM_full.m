%% 灰色预测模型
clear; clc;
syms a b;
%c中储存灰参数
c=[a b]';
%A是已知的一些数据
A=[];
A=input('输入需要预测的一组数据:(如[174 179...285])\n');
% 方便测试：[174 179 183 189 207 234 220.5 256 270 285]
nnext=input('请输入需要预测后面几个数据：');
%B是原数据一阶累加生成序列
B=cumsum(A);
n=length(A);

%级比检验，看是否可以使用灰色预测
lamda=A(1: n-1) ./ A(2: n);
range=minmax(lamda);   % 返回向量或者矩阵中的最大值与最小值，判断是否在要求范围之内
ex='exp(-2/(n+1))';
low=subs(ex,'n',n);
ex='exp(2/(n+1))';
up=subs(ex,'n',n);
if (range(1)>=low)&&(range(2)<=up)
    disp('可以使用灰色预测模型');
end

%C是累加矩阵(均值数列)
for i=1:(n-1);
    C(i)=(B(i)+B(i+1))/2;
end

%% 计算待定参数的值
D=A;
D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=(E*E')\E*D;
c=c';
a=c(1)
b=c(2)

%% 预测后续数据
temp=dsolve('Dx+a*x=b', 'x(0) = x0');
temp=subs(temp, {'a', 'b', 'x0'}, {a,b,B(1)});
F=double(subs(temp, 't', 0:n+nnext-1))

%G是已知结果+预测结果
G=[];
G(1)=A(1);
for i=2:(n+nnext)
    G(i)=F(i)-F(i-1);
end
disp('已知数据和得到的预测结果如下:');
disp(G);
%画出图像
t1=1:n;
t2=1:n+nnext;
plot(t1,A,'o',t2,G)

%% 进行检验
% 残差
epsilon=A-G(1:n);
% 相对误差
delta=abs(epsilon./A);
disp('已知数据和预测数据之间的相对误差为:');
disp(delta);
% 级比偏差
rho=1-(1-0.5*a)/(1+0.5*a)*lamda;
% 原始数据均值
mean1=mean(A);
%原始数据方差
var1=var(A);
% 残差的均值
mean2=mean(epsilon);
% 残差的方差
var2=var(epsilon);
%方差比
scale=var2/var1;
disp('方差比为：(与给定的C0比较，scale<C0时合格)');
disp(scale);
% 小误差概率
pp=0.6745*var1;
p=length(find(abs(epsilon)<pp))/length(epsilon);
disp('小误差概率为：');
disp(p);
disp('请按照灰色模型精度检验对照表检验模型精度');
