% and_linearlayer.m
%% 清理
close all
clear,clc

%% 定义变量
P=[0,0,1,1;0,1,0,1]			% 输入向量
d=[0,0,0,1]				% 期望输出向量
lr=maxlinlr(P,'bias')			% 根据输入矩阵求解最大学习率

%% 线性网络实现
net1=linearlayer(0,lr); 		% 创建线性网络
net1=train(net1,P,d);   		% 线性网络训练

%% 感知器实现
net2=newp([-1,1;-1,1],1,'hardlim');     % 创建感知器
net2=train(net2,P,d);   		% 感知器学习

%% 显示
disp('线性网络输出')     		% 命令行输出
Y1=sim(net1,P)
disp('线性网络二值输出');
YY1=Y1>=0.5
disp('线性网络最终权值：')
w1=[net1.iw{1,1}, net1.b{1,1}]
disp('感知器输出')
Y2=sim(net2,P)
disp('感知器二值输出');
YY2=Y2>=0.5
disp('感知器最终权值：')
w2=[net2.iw{1,1}, net2.b{1,1}]

plot([0,0,1],[0,1,0],'o');          % 图形窗口输出
hold on;
plot(1,1,'d');
x=-2:.2:2;
y1=1/2/w1(2)-w1(1)/w1(2)*x-w1(3)/w1(2);   % 1/2是区分0和1的阈值
plot(x,y1,'-');
y2=-w2(1)/w2(2)*x-w2(3)/w2(2);      % hardlim函数以0为阈值，分别输出0或1
plot(x,y2,'--');
axis([-0.5,2,-0.5,2])
xlabel('x');ylabel('ylabel');
title('线性神经网络与感知器用于求解与逻辑')
legend('0','1','线性神经网络分类面','感知器分类面');

