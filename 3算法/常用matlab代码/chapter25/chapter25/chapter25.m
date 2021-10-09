%% Matlab神经网络43个案例分析

% 神经网络变量筛选—基于MIV的神经网络变量筛选
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

% 产生x3 x4（噪声）
x=rand(1,301);
x3=(x-0.5)*1.5*2;
x4=(x-0.5)*1.5*2;

% 按照函数先求得相应的函数值，作为网络的输出。
F =20+x1.^2-10*cos(2*pi*x1)+x2.^2-10*cos(2*pi*x2);

%设置网络输入输出值
p=[x1;x2;x3;x4];
t=F;


%% 变量筛选 MIV算法的初步实现（增加或者减少自变量）

p=p';
[m,n]=size(p);
yy_temp=p;

% p_increase为增加10%的矩阵 p_decrease为减少10%的矩阵
for i=1:n
    p=yy_temp;
    pX=p(:,i);
    pa=pX*1.1;
    p(:,i)=pa;
    aa=['p_increase'  int2str(i) '=p;'];
    eval(aa);
end


for i=1:n
    p=yy_temp;
    pX=p(:,i);
    pa=pX*0.9;
    p(:,i)=pa;
    aa=['p_decrease' int2str(i) '=p;'];
    eval(aa);
end


%% 利用原始数据训练一个正确的神经网络
nntwarn off;
p=yy_temp;
p=p';
% bp网络建立
net=newff(minmax(p),[8,1],{'tansig','purelin'},'traingdm');
% 初始化bp网络
net=init(net);
% 网络训练参数设置
net.trainParam.show=50;
net.trainParam.lr=0.05;
net.trainParam.mc=0.9;
net.trainParam.epochs=2000;

% bp网络训练
net=train(net,p,t);


%% 变量筛选 MIV算法的后续实现（差值计算）

% 转置后sim

for i=1:n
    eval(['p_increase',num2str(i),'=transpose(p_increase',num2str(i),');'])
end

for i=1:n
    eval(['p_decrease',num2str(i),'=transpose(p_decrease',num2str(i),');'])
end


% result_in为增加10%后的输出 result_de为减少10%后的输出
for i=1:n
    eval(['result_in',num2str(i),'=sim(net,','p_increase',num2str(i),');'])
end

for i=1:n
    eval(['result_de',num2str(i),'=sim(net,','p_decrease',num2str(i),');'])
end

for i=1:n
    eval(['result_in',num2str(i),'=transpose(result_in',num2str(i),');'])
end

for i=1:n
    eval(['result_de',num2str(i),'=transpose(result_de',num2str(i),');'])
end

%% MIV的值为各个项网络输出的MIV值 MIV被认为是在神经网络中评价变量相关的最好指标之一，其符号代表相关的方向，绝对值大小代表影响的相对重要性。


for i=1:n
    IV= ['result_in',num2str(i), '-result_de',num2str(i)];
    eval(['MIV_',num2str(i) ,'=mean(',IV,')'])
    
end
