% 脚本 使用newff函数实现性别识别 正确率
% main_newff.m

%% 清理
clear,clc
rng('default')
rng(2)

%% 读入数据
xlsfile='student.xls';
[data,label]=getdata(xlsfile);

%% 划分数据
[traind,trainl,testd,testl]=divide(data,label);

%% 创建网络
net=feedforwardnet(3);
net.trainFcn='trainbfg';

%% 训练网络
net=train(net,traind',trainl);

%% 测试
test_out=sim(net,testd');
test_out(test_out>=0.5)=1;
test_out(test_out<0.5)=0;
rate=sum(test_out==testl)/length(testl);
fprintf('  正确率\n   %f %%\n', rate*100);


