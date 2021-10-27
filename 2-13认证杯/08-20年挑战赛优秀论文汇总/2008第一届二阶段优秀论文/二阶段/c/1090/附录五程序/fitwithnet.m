function [net,ps,ts] = fitwithnet(p,t)
% 由MATLAB工具箱生成

rand('seed',1.101461854E9) %产生随机数，

% Normalize Inputs and Targets
[normInput,ps] = mapminmax(p);  %规范输入输出
[normTarget,ts] = mapminmax(t);

% Create Network
numInputs = size(p,1);
numHiddenNeurons = 40;  % 隐藏层神经元数目
numOutputs = size(t,1);
net = newff(minmax(normInput),[numHiddenNeurons,20,numOutputs],{'tansig','tansig','purelin'},'trainlm');

% 将数据分别分割成训练，测试，验证数据
testPercent = 0.20;  %测试数据为20%
validatePercent = 0.20;  % 验证数据为%20
[trainSamples,validateSamples,testSamples] = dividevec(normInput,normTarget,testPercent,validatePercent);
net.trainParam.epochs = 1500;  
net.trainParam.goal = 0;
%训练
[net,tr] = train(net,trainSamples.P,trainSamples.T,[],[],validateSamples,testSamples);

 % 模拟网络，分别就训练，验证，测试置入网络进行仿真
[normTrainOutput,Pf,Af,E,trainPerf] = sim(net,trainSamples.P,[],[],trainSamples.T);
[normValidateOutput,Pf,Af,E,validatePerf] = sim(net,validateSamples.P,[],[],validateSamples.T);
[normTestOutput,Pf,Af,E,testPerf] = sim(net,testSamples.P,[],[],testSamples.T);

% 返回原标准解
trainOutput = mapminmax('reverse',normTrainOutput,ts);
validateOutput = mapminmax('reverse',normValidateOutput,ts);
testOutput = mapminmax('reverse',normTestOutput,ts);

% 作图，将回归拟合结果以图形式表示
figure
postreg({trainOutput,validateOutput,testOutput}, ...
  {t(:,trainSamples.indices),t(:,validateSamples.indices),t(:,testSamples.indices)});
