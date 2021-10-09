% 灰色预测
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clear
syms a b;
c=[a b]';
A=[174	179	183	189	207 234	220.5 256	270	285];
B=cumsum(A);  % 原始数据累加
n=length(A);
for i=1:(n-1)
    C(i)=(B(i)+B(i+1))/2;  % 生成累加矩阵
end
% 计算待定参数的值
D=A;D(1)=[];
D=D';
E=[-C;ones(1,n-1)];
c=inv(E*E')*E*D;
c=c';
a=c(1);b=c(2);
% 预测后续数据
F=[];F(1)=A(1);
for i=2:(n+10)
    F(i)=(A(1)-b/a)/exp(a*(i-1))+b/a ;
end
G=[];G(1)=A(1);
for i=2:(n+10)
    G(i)=F(i)-F(i-1); %得到预测出来的数据
end 
t1=1995:2004;
t2=1995:2014;
G, a, b % 输出预测值，发展系数和灰色作用量

plot(t1,A,'ko', 'LineWidth',2)
hold on
plot(t2,G,'k', 'LineWidth',2)
xlabel('年份', 'fontsize',12)
ylabel('污水量/亿吨','fontsize',12)
set(gca,  'LineWidth',2);
