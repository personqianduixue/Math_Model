%% testFor_DCT
% for classificaton
close all;
clear;
clc;
%% 载入数据
load wine_test;
%% 提取数据
% ...
%% 原始数据可视化
% figure;
% boxplot(train_data,'orientation','horizontal');
% grid on;
% title('Visualization for original data');
% figure;
% for i = 1:length(train_data(:,1))
%     plot(train_data(i,1),train_data(i,2),'r*');
%     hold on;
% end
% grid on;
% title('Visualization for 1st dimension & 2nd dimension of original data');
%% 归一化预处理
[train_scale,test_scale] = scaleForSVM(train_data,test_data,0,1);
%% 归一化后可视化
% figure;
% for i = 1:length(train_scale(:,1))
%     plot(train_scale(i,1),train_scale(i,2),'r*');
%     hold on;
% end
% grid on;
% title('Visualization for 1st dimension & 2nd dimension of scale data');
%% dct

% [train_dct,test_dct] = DCTforSVM(train_data,test_data);

train_dct = dct(train_scale');
test_dct = dct(test_scale');

train_dct = train_dct';
test_dct = test_dct';

%% 参数c和g寻优选择
[bestacc,bestc,bestg] = SVMcgForClass(train_data_labels,train_dct,-10,10,-10,10)
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
%% 分类预测
model = svmtrain(train_data_labels, train_dct,cmd);
[ptrain_label, train_acc] = svmpredict(train_data_labels, train_dct, model);
train_acc
[ptest_label, test_acc] = svmpredict(test_data_labels, test_dct, model);
test_acc


