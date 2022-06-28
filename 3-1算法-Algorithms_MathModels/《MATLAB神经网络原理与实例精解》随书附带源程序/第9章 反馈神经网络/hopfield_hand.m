% hopfield_hand.m
%% 清理
close all
clear,clc

%% 
disp('吸引子坐标为:');
c1=[-1,1]						% 第一个平衡点
c2=[1,-1]						% 第二个平衡点

% 计算权值矩阵
w=zeros(2,2);
for i=1:2
   for j=1:2
      if (i~=j)
         w(i,j)=1/2*(c1(i)*c1(j) + c2(i)*c2(j)); 
      end
   end
end

% 阈值向量
b=[0,0];

disp('权值矩阵为');
w
disp('阈值向量为');
b

% 网络初始值
rng(0);
y=rand(1,2)*2-1;
y(y>0)=1;
y(y<=0)=-1;

% 循环迭代
disp('开始迭代');
while 1
    % 保存上一次的网络状态值
    disp('网络状态值:');
    tmp = y
    
    % 更新第一个神经元
    y_new1 = y * w(:,1) + b(1);
    fprintf('第一个神经元由 %d 更新为 %d \n', y(1), y_new1);
    y=[y_new1, y(2)];
    
    % 更新第二个神经元
    y_new2 = y * w(:,2) + b(2);
    fprintf('第二个神经元由 %d 更新为 %d \n', y(2), y_new2);
    y=[y(1), y_new2];
    
    % 如果状态值不变，则结束迭代
    if (tmp == y)
        break;
    end
    
end


