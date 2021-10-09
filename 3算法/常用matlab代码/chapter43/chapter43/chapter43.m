%% Matlab神经网络43个案例分析

% 神经网络高效编程技巧-基于MATLAB R2012b新版本特性的探讨
% by 王小川(@王小川_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
% 注意代码为演示脚本，请根据备注分块运行

%% 典型的前向神经网络
[x,t]=house_dataset;
net1=feedforwardnet(10);
net2=train(net1,x,t);
y=net2(x);

%% 设置reduction
net=train(net1,x,t,'reduction',10);
y=net(x,'reduction',10)

%% 神经网络并行运算
% CPU并行
matlabpool open
numWorkers = matlabpool('size')

[x,t]=house_dataset;
net=feedforwardnet(10);
net=train(net,x,t,'useparallel','yes')
y=sim(net,x,'useparallel','yes')

% GPU并行
net=train(net,x,t,'useGPU','yes')
y=sim(net,x,'useGPU','yes')

%% Elliot S函数的使用
n=-10:0.01:10;
a1=elliotsig(n);
a2=tansig(n);
h=plot(n,a1,n,a2);
legend(h,'ELLIOTSIG','TANSIG','location','NorthWest')


n = rand(1000,1000);
tic, for i=1:100, a = elliotsig(n); end, elliotsigTime = toc
tic, for i=1:100, a = tansig(n); end, tansigTime = toc
speedup = tansigTime / elliotsigTime

%% 神经网络负载均衡
[x,t] = house_dataset;
Xc = Composite;
Tc = Composite;
Xc{1} = x(:, 1:100); % First 100 samples of x
Tc{1} = t(:, 1:100); % First 100 samples of t
Xc{2} = x(:, 101:506); % Rest samples of x
Tc{2} = t(:, 101:506); % Rest samples of t

%% 代码组织更新
help nnprocess
help nnweight
help nntransfer
help nnnetinput
help nnperformance
help nndistance
  
