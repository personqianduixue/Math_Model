clc
%% 不适用遗传算法
%% 使用随机权值和阈值 
inputnum=size(P,1);       % 输入层神经元个数
outputnum=size(T,1);      % 输出层神经元个数
%% 新建BP网络
net=newff(minmax(P),[hiddennum,outputnum],{'tansig','logsig'},'trainlm');
%% 设置网络参数：训练次数为1000，训练目标为0.01，学习速率为0.1
net.trainParam.epochs=1000;
net.trainParam.goal=0.01;
LP.lr=0.1;
%% 训练网络以
net=train(net,P,T);
%% 测试网络
disp(['1、使用随机权值和阈值 '])
disp('测试样本预测结果：')
Y1=sim(net,P_test)
err1=norm(Y1-T_test);     %测试样本的仿真误差
err11=norm(sim(net,P)-T); %训练样本的仿真误差
disp(['测试样本的仿真误差:',num2str(err1)])
disp(['训练样本的仿真误差:',num2str(err11)])


%% 使用遗传算法
%% 使用优化后的权值和阈值
inputnum=size(P,1);       % 输入层神经元个数
outputnum=size(T,1);      % 输出层神经元个数
%% 新建BP网络
net=newff(minmax(P),[hiddennum,outputnum],{'tansig','logsig'},'trainlm');
%% 设置网络参数：训练次数为1000，训练目标为0.01，学习速率为0.1
net.trainParam.epochs=1000;
net.trainParam.goal=0.01;
LP.lr=0.1;
%% BP神经网络初始权值和阈值
w1num=inputnum*hiddennum; % 输入层到隐层的权值个数
w2num=outputnum*hiddennum;% 隐层到输出层的权值个数
w1=bestX(1:w1num);   %初始输入层到隐层的权值
B1=bestX(w1num+1:w1num+hiddennum);  %初始隐层阈值
w2=bestX(w1num+hiddennum+1:w1num+hiddennum+w2num); %初始隐层到输出层的阈值
B2=bestX(w1num+hiddennum+w2num+1:w1num+hiddennum+w2num+outputnum); %输出层阈值
net.iw{1,1}=reshape(w1,hiddennum,inputnum);
net.lw{2,1}=reshape(w2,outputnum,hiddennum);
net.b{1}=reshape(B1,hiddennum,1);
net.b{2}=reshape(B2,outputnum,1);
%% 训练网络以
net=train(net,P,T);
%% 测试网络
disp(['2、使用优化后的权值和阈值'])
disp('测试样本预测结果：')
Y2=sim(net,P_test)
err2=norm(Y2-T_test);
err21=norm(sim(net,P)-T);
disp(['测试样本的仿真误差:',num2str(err2)])
disp(['训练样本的仿真误差:',num2str(err21)])

