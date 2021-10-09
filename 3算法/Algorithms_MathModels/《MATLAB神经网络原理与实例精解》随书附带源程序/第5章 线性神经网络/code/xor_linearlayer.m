% xor_linearlayer.m
%% 清理
close all
clear,clc

%% 定义变量
P1=[0,0,1,1;0,1,0,1]            	% 原始输入向量
p2=P1(1,:).^2;
p3=P1(1,:).*P1(2,:);
p4=P1(2,:).^2;
P=[P1(1,:);p2;p3;p4;P1(2,:)]    	% 添加非线性成分后的输入向量
d=[0,1,1,0]                     	% 期望输出向量
lr=maxlinlr(P,'bias')			% 根据输入矩阵求解最大学习率

%% 线性网络实现
net=linearlayer(0,lr);          	% 创建线性网络
net=train(net,P,d);             	% 线性网络训练


%% 显示
disp('网络输出')                	% 命令行输出
Y1=sim(net,P)
disp('网络二值输出');
YY1=Y1>=0.5
disp('最终权值：')
w1=[net.iw{1,1}, net.b{1,1}]
                    
plot([0,1],[0,1],'o','LineWidth',2);    % 图形窗口输出        
hold on;
plot([0,1],[1,0],'d','LineWidth',2);
axis([-0.1,1.1,-0.1,1.1]);
xlabel('x');ylabel('y');
title('线性神经网络用于求解异或逻辑');
x=-0.1:.1:1.1;y=-0.1:.1:1.1;
N=length(x);
X=repmat(x,1,N);
Y=repmat(y,N,1);Y=Y(:);Y=Y';
P=[X;X.^2;X.*Y;Y.^2;Y];
yy=net(P);
y1=reshape(yy,N,N);
[C,h]=contour(x,y,y1,0.5,'b');
clabel(C,h);
legend('0','1','线性神经网络分类面');



