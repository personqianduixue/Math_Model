%% Matlab神经网络43个案例分析

% RBF网络的回归--非线性函数回归的实现
% by 王小川(@王小川_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 
%% 清空环境变量
clc
clear

%% 产生输入 输出数据 
% 设置步长 
interval=0.01;

% 产生x1 x2
x1=-1.5:interval:1.5;
x2=-1.5:interval:1.5;

% 按照函数先求得相应的函数值，作为网络的输出。
F =20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2); 

%% 网络建立和训练
% 网络建立 输入为[x1;x2],输出为F。Spread使用默认。
net=newrbe([x1;x2],F)

%% 网络的效果验证

% 我们将原数据回带，测试网络效果：
ty=sim(net,[x1;x2]);

% 我们使用图像来看网络对非线性函数的拟合效果
figure
plot3(x1,x2,F,'rd');
hold on;
plot3(x1,x2,ty,'b-.');
view(113,36)
title('可视化的方法观察准确RBF神经网络的拟合效果')
xlabel('x1')
ylabel('x2')
zlabel('F')
grid on 

