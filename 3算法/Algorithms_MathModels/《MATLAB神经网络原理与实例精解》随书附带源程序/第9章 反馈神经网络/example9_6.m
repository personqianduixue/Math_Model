% example9_6.m
% 清理
close all
clear,clc
% 原始数据
data =[0.4413	0.4707	0.6953	0.8133;...
       0.4379	0.4677	0.6981	0.8002;...
       0.4517	0.4725	0.7006	0.8201;...
       0.4557	0.4790	0.7019	0.8211;...
       0.4601	0.4811	0.7101	0.8298;...
       0.4612	0.4845	0.7188	0.8312;...
       0.4615	0.4891	0.7201	0.8330];
rng('default')
rng(2);

for i=1:4
    P=[data(1:3,i),data(2:4,i),data(3:5,i)];
    T=[data(4,i),data(5,i),data(6,i)];
    
    net=elmannet(1:3,20);           	% 创建Elman网络
    net=init(net);                  	% 初始化
    net=train(net,P,T);             	% 训练
    
                                 	% 测试
    test_P=data(4:6,i);
    y(i)=sim(net,test_P);           	% 仿真
end
fprintf('真实值:\n');
disp(data(7,:));
fprintf('预测值:\n');
disp(y);
fprintf('误差:\n');
disp((y-data(7,:))./y);
fprintf('平均误差mse：\n');
disp(mean(abs(y-data(7,:))))
web -broswer http://www.ilovematlab.cn/forum-222-1.html