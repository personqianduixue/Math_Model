% perception_hand.m  demo 实例
%% 清理
clear,clc
close all

%%
n=0.2;                  % 学习率
w=[0,0,0]; 
P=[ -9,  1, -12, -4,   0, 5;...
   15,  -8,   4,  5,  11, 9];
d=[0,1,0,0,0,1];        % 期望输出

P=[ones(1,6);P];
MAX=20;                 % 最大迭代次数为20次
%% 训练
i=0;
while 1
    v=w*P; 
    y=hardlim(v);       % 实际输出
    %更新
    e=(d-y);
    ee(i+1)=mae(e);
    if (ee(i+1)<0.001)   % 判断
        disp('we have got it:');
        disp(w);
        break;
    end
    % 更新权值和偏置
    w=w+n*(d-y)*P';
    
    if (i>=MAX)         % 达到最大迭代次数，退出
        disp('MAX times loop');
        disp(w);
        disp(ee(i+1));
       break; 
    end
    i= i+1;
end


%% 显示
figure;
subplot(2,1,1);         % 显示待分类的点和分类结果
plot([-9 ,  -12  -4    0],[15, 4   5   11],'o');
hold on;
plot([1,5],[-8,9],'*');
axis([-13,6,-10,16]);
legend('第一类','第二类');
title('6个坐标点的二分类');
x=-13:.2:6;
y=x*(-w(2)/w(3))-w(1)/w(3);
plot(x,y);
hold off;

subplot(2,1,2);         % 显示mae值的变化
x=0:i;
plot(x,ee,'o-');
s=sprintf('mae的值(迭代次数:%d)', i+1);
title(s);
