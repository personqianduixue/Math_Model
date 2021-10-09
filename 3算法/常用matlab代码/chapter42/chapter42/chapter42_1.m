%% Matlab神经网络43个案例分析

% 并行运算与神经网络-基于CPU/GPU的并行神经网络运算
% by 王小川(@王小川_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
% 本代码为示例代码脚本，建议不要整体运行，运行时注意备注提示。


%% CPU并行
%% 标准单线程的神经网络训练与仿真过程
[x,t]=house_dataset;
net1=feedforwardnet(10);
net2=train(net1,x,t);
y=sim(net2,x);

%% 打开MATLAB workers
matlabpool open
% 检查worker数量
poolsize=matlabpool('size')

%% 设置train与sim函数中的参数“Useparallel”为“yes”。
net2=train(net1,x,t,'Useparallel','yes')
y=sim(net2,x,'Useparallel','yes')

%% 使用“showResources”选项证实神经网络运算确实在各个worker上运行。
net2=train(net1,x,t,'useParallel','yes','showResources','yes');
y=sim(net2,x,'useParallel','yes','showResources','yes');

%% 将一个数据集进行随机划分，同时保存到不同的文件
for i=1:matlabpool('size')
x=rand(2,1000);
save(['inputs' num2str(i)],'x')
t=x(1,:).*x(2,:)+2*(x(1,:)+x(2,:)) ;
save(['target' num2str(i)],'t');
clear x t
end

%% 实现并行运算加载数据集　
for i=1:matlabpool('size')
    data=load(['inputs' num2str(i)],'x')
    xc{i}=data.x
    data=load(['target' num2str(i)],'t')
    tc{i}=data.t;
    clear data
end
net2=configure(net2,xc{1},tc{1});
net2=train(net2,xc,tc);
yc=sim(net2,xc)

%% 得到各个worker返回的Composite结果
for i=1:matlabpool('size')
    yi=yc{i}
end

%% GPU并行
count=gpuDeviceCount
gpu1=gpuDevice(1)
gpuCores1=gpu1.MultiprocessorCount*gpu1.SIMDWidth
net2=train(net1,x,t,'useGPU','yes')
y=sim(net,x,'useGPU','yes')
net1.trainFcn='trainscg';
net2=train(net1,x,t,'useGPU','yes','showResources','yes');
 y=sim(net2,x, 'useGPU','yes','showResources','yes');
