%% LVQ神经网络的预测——人脸识别

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
direction_label = repmat(1:N,1,M);
% 训练集
train_label = rand_label(1:30);
P_train = pixel_value(train_label,:)';
Tc_train = direction_label(train_label);
% 测试集
test_label = rand_label(31:end);
P_test = pixel_value(test_label,:)';
Tc_test = direction_label(test_label);

%% 计算PC
for i = 1:5
    rate{i} = length(find(Tc_train == i))/30;
end

%% LVQ1算法
[w1,w2] = lvq1_train(P_train,Tc_train,20,cell2mat(rate),0.01,5);
result_1 = lvq_predict(P_test,Tc_test,20,w1,w2);

%% LVQ2算法
[w1,w2] = lvq2_train(P_train,Tc_train,20,0.01,5,w1,w2);
result_2 = lvq_predict(P_test,Tc_test,20,w1,w2);