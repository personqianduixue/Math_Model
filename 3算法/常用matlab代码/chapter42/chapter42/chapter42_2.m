%% Matlab神经网络43个案例分析

% 并行运算与神经网络-基于CPU/GPU的并行神经网络运算
% by 王小川(@王小川_matlab)
% http://www.matlabsky.com
% Email:sina363@163.com
% http://weibo.com/hgsz2003
 

%% 清空环境变量
clear all
clc
warning off

%% 打开matlabpool
matlabpool open
poolsize=matlabpool('size');

%% 加载数据
load bodyfat_dataset
inputs = bodyfatInputs;
targets = bodyfatTargets;

%% 创建一个拟合神经网络
hiddenLayerSize = 10;   % 隐藏层神经元个数为10
net = fitnet(hiddenLayerSize);  % 创建网络

%% 指定输入与输出处理函数(本操作并非必须)
net.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
net.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};

%% 设置神经网络的训练、验证、测试数据集划分
net.divideFcn = 'dividerand';  % 随机划分数据集
net.divideMode = 'sample';  %  划分单位为每一个数据
net.divideParam.trainRatio = 70/100; %训练集比例
net.divideParam.valRatio = 15/100; %验证集比例
net.divideParam.testRatio = 15/100; %测试集比例

%% 设置网络的训练函数
net.trainFcn = 'trainlm';  % Levenberg-Marquardt

%% 设置网络的误差函数
net.performFcn = 'mse';  % Mean squared error

%% 设置网络可视化函数
net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};

%% 单线程网络训练
tic
[net1,tr1] = train(net,inputs,targets);
t1=toc;
disp(['单线程神经网络的训练时间为',num2str(t1),'秒']);

%% 并行网络训练
tic
[net2,tr2] = train(net,inputs,targets,'useParallel','yes','showResources','yes');
t2=toc;
disp(['并行神经网络的训练时间为',num2str(t2),'秒']);

%% 网络效果验证
outputs1 = sim(net1,inputs);
outputs2 = sim(net2,inputs);
errors1 = gsubtract(targets,outputs1);
errors2 = gsubtract(targets,outputs2);
performance1 = perform(net1,targets,outputs1)
performance2 = perform(net2,targets,outputs2)

%% 神经网络可视化
figure, plotperform(tr1);
figure, plotperform(tr2);
figure, plottrainstate(tr1);
figure, plottrainstate(tr2);
figure,plotregression(targets,outputs1);
figure,plotregression(targets,outputs2);
figure,ploterrhist(errors1);
figure,ploterrhist(errors2);

matlabpool close