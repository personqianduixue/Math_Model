%% BP神经网络的预测——人脸识别

%% 清除环境变量
clear all
clc

%% 人脸特征向量提取 
% 人数
M = 10;
% 人脸朝向类别数
N = 5; 
% 特征向量提取
pixel_value = feature_extraction(M,N);

%% 训练集/测试集产生
% 产生图像序号的随机序列
rand_label = randperm(M*N);  
% 人脸朝向标号
direction_label = [1 0 0;1 1 0;0 1 0;0 1 1;0 0 1];
% 训练集
train_label = rand_label(1:30);
P_train = pixel_value(train_label,:)';
dtrain_label = train_label - floor(train_label/N)*N;
dtrain_label(dtrain_label == 0) = N;
T_train = direction_label(dtrain_label,:)';
% 测试集
test_label = rand_label(31:end);
P_test = pixel_value(test_label,:)';
dtest_label = test_label - floor(test_label/N)*N;
dtest_label(dtest_label == 0) = N;
T_test = direction_label(dtest_label,:)';

%% 创建BP网络
net = newff(minmax(P_train),[10,3],{'tansig','purelin'},'trainlm');
% 设置训练参数
net.trainParam.epochs = 1000;
net.trainParam.show = 10;
net.trainParam.goal = 1e-3;
net.trainParam.lr = 0.1;

%% 网络训练
net = train(net,P_train,T_train);

%% 仿真测试
T_sim = sim(net,P_test);
for i = 1:3
    for j = 1:20
        if T_sim(i,j) < 0.5
            T_sim(i,j) = 0;
        else
            T_sim(i,j) = 1;
        end
    end
end
T_sim
T_test