% example5_4.m
%% 清理
clear,clc
close all

%% 定义数据
P=-5:5;                         % 输入：11个标量
d=3*P-7;
randn('state',2);	
d=d+randn(1,length(d))*1.5     % 期望输出：加了噪声的线性函数

P=[ones(1,length(P));P]        % P加上偏置
lp.lr = 0.01;                  % 学习率
MAX = 150;                     % 最大迭代次数
ep1 = 0.1;                     % 均方差终止阈值
ep2 = 0.0001;                  % 权值变化终止阈值
%% 初始化
w=[0,0];
 
%% 循环更新
 for i=1:MAX
    fprintf('第%d次迭代：\n', i)
    e=d-purelin(w*P);          % 求得误差向量
    ms(i)=mse(e);              % 均方差
    ms(i)
    if (ms(i) < ep1)           % 如果均方差小于某个值，则算法收敛
        fprintf('均方差小于指定数而终止\n');
       break; 
    end
    
    dW = learnwh([],P,[],[],[],[],e,[],[],[],lp,[]);    % 权值调整量
    if (norm(dW) < ep2)        % 如果权值变化小于指定值，则算法收敛
       fprintf('权值变化小于指定数而终止\n');
       break;
    end
    w=w+dW                     % 用dW更新权值    
    
 end
 
%% 显示
fprintf('算法收敛于：\nw= (%f,%f),MSE: %f\n', w(1), w(2), ms(i));
figure;
subplot(2,1,1);                % 绘制散点和直线
plot(P(2,:),d,'o');title('散点与直线拟合结果');
xlabel('x');ylabel('y');
axis([-6,6,min(d)-1,max(d)+1]);
x1=-5:.2:5;
y1=w(1)+w(2)*x1;
hold on;plot(x1,y1);
subplot(2,1,2);                % 绘制均方差下降曲线
semilogy(1:i,ms,'-o');
xlabel('迭代次数');ylabel('MSE');title('均方差下降曲线');
web -broswer http://www.ilovematlab.cn/forum-222-1.html
