%% LVQ神经网络的预测——人脸识别

%% 清除环境变量
clear all
clc
warning off

%% 人脸特征向量提取 
% 人数
M = 10;
% 人脸朝向类别数
N = 5; 
% 特征向量提取
pixel_value = feature_extraction(M,N);
% 归一化
pixel_value = premnmx(pixel_value);

%% 训练集/测试集产生
% 产生图像序号的随机序列
rand_label = randperm(M*N);  
% 人脸朝向标号
direction_label = repmat(1:N,1,M);
% 训练集
rand_train = rand_label(1:30);
Train = pixel_value(rand_train,:);
Train_label = direction_label(rand_train)';
% 测试集
rand_test = rand_label(31:end);
Test = pixel_value(rand_test,:);
Test_label = direction_label(rand_test)';
% SVM模型
model = svmtrain(Train_label,Train,'-c 2 -g 0.05');
% 仿真测试
[predict_label,accuracy] = svmpredict(Test_label,Test,model);
result_svm = [Test_label';predict_label']
