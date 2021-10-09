% 问题三

clear;
close all;
clc;

load('problem3.mat');
%% 计算排队长度
M =2;L = 0.120;N0 = 12;
kj = 160;km = 59;
shangyous(1) = shangyou(1);
xiayous(1) = xiayou(1);
%计算累计数
for i = 2:size(shangyou,1)
   shangyous(i) = sum(shangyou(1:i,1)); 
   xiayous(i) = sum(xiayou(1:i,1));
end


for i = 2:size(shangyou,1)
   D(i) = 1000*(N0+shangyous(i)-xiayous(i)-km*L*M)/(M*(kj-km));
   if N0+shangyous(i)-xiayous(i)>= kj*L*M
      D(i)  = 120;
   else
       if N0+shangyous(i)-xiayous(i)<= km*L*M
           D(i) = 0;
       end
   end
end

% plot(1:size(shangyou,1),D,':*',1:size(shangyou,1),length,'--o');
% grid on;
% legend('模型计算长度','统计计算的长度');


%% 将时间单独作为一个输入，通行能力和上游车流结合为一个输入（通行能力是成本型）
B = [max(shangyou),min(xiayou)];
W = [min(shangyou),max(xiayou)];

%相对偏差
r(:,1) = abs(shangyou-B(1))./(max(shangyou)-min(shangyou));
r(:,2) = abs(B(2)-xiayou)./(max(xiayou)-min(xiayou));

del(:,1) = abs(shangyou-W(1))./(max(shangyou)-min(shangyou));
del(:,2) = abs(W(2)-xiayou)./(max(xiayou)-min(xiayou));

for i = 1:2
    c(i) = (r(:,i)'*del(:,i))./(norm(r(:,i))*norm(del(:,i)));
end

%权重
w(1) = c(1)/sum(c);
w(2) = c(2)/sum(c);


%无量纲化后加权求和
P(:,1) = (shangyou-min(shangyou))./(max(shangyou)-min(shangyou));
P(:,2) = (max(xiayou)-xiayou)./(max(xiayou)-min(xiayou));

score = P*w';

%  plot3(score(1:81),time(1:81),length(1:81)','ro');
%  grid on;
%  xlabel('得分');ylabel('持续时间'):zlabel('排队长度');
%% 神经网络拟合
p=[score(1:81)';time(1:81)'];  %输入数据矩阵
t=length(1:81)';         %目标数据矩阵

%利用premnmx函数对数据进行归一化
[pn,PS1]=mapminmax(p); % 对于输入矩阵p和输出矩阵t进行归一化处理
[tn,PS2]=mapminmax(t); % 对于输入矩阵p和输出矩阵t进行归一化处理
dx=[-1,1;-1,1];   %归一化处理后最小值为-1，最大值为1

%BP网络训练
net=newff(dx,[2,5,1],{'tansig','tansig','purelin'},'traingdx'); %建立模型，并用梯度下降法训练．
net.trainParam.show=1000;               %1000轮回显示一次结果
net.trainParam.Lr=0.05;                 %学习速度为0.05
net.trainParam.epochs=50000;           %最大训练轮回为50000次
net.trainParam.goal=0.65*10^(-2);     %均方误差

net=train(net,pn,tn);                   %开始训练，其中pn,tn分别为输入输出样本

%利用原始数据对BP网络仿真
[m1,m2] = meshgrid(linspace(0.25,0.86,1040),0:1:1039);
test = [reshape(m1,1,size(m1,1)*size(m1,2));reshape(m2,1,size(m2,1)*size(m2,2))];
pn1 = mapminmax('apply',test,PS1);
an=sim(net,pn1);           %用训练好的模型进行仿真
a=mapminmax('reverse',an,PS2); % 把仿真得到的数据还原为原始的数量级；
a = reshape(a,size(m1,1),size(m1,2));
a(find(a<0)) = 0;
figure;
mesh(m1,m2,a);
grid on;
xlabel('得分');ylabel('持续时间'):zlabel('排队长度');