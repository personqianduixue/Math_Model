%% 分类方法示例程序
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc, clear all, close all
%% 导入数据及数据预处理 
load bank.mat
% 将分类变量转换成分类数组
names = bank.Properties.VariableNames;
category = varfun(@iscellstr, bank, 'Output', 'uniform');
for i = find(category)
    bank.(names{i}) = categorical(bank.(names{i}));
end
% 跟踪分类变量
catPred = category(1:end-1);
% 设置默认随机数生成方式确保该脚本中的结果是可以重现的
rng('default');
% 数据探索----数据可视化
figure(1)
gscatter(bank.balance,bank.duration,bank.y,'kk','xo')
xlabel('年平均余额/万元', 'fontsize',12)
ylabel('上次接触时间/秒', 'fontsize',12)
title('数据可视化效果图', 'fontsize',12)
set(gca,'linewidth',2);

% 设置响应变量和预测变量
X = table2array(varfun(@double, bank(:,1:end-1)));  % 预测变量
Y = bank.y;   % 响应变量
disp('数据中Yes & No的统计结果：')
tabulate(Y)
%将分类数组进一步转换成二进制数组以便于某些算法对分类变量的处理
XNum = [X(:,~catPred) dummyvar(X(:,catPred))];
YNum = double(Y)-1;

%% 设置交叉验证方式
% 随机选择40%的样本作为测试样本
cv = cvpartition(height(bank),'holdout',0.40);
% 训练集
Xtrain = X(training(cv),:);
Ytrain = Y(training(cv),:);
XtrainNum = XNum(training(cv),:);
YtrainNum = YNum(training(cv),:);
% 测试集
Xtest = X(test(cv),:);
Ytest = Y(test(cv),:);
XtestNum = XNum(test(cv),:);
YtestNum = YNum(test(cv),:);
disp('训练集：')
tabulate(Ytrain)
disp('测试集：')
tabulate(Ytest)

%% 最近邻
% 训练分类器
knn = ClassificationKNN.fit(Xtrain,Ytrain,'Distance','seuclidean',...
                            'NumNeighbors',5);
% 进行预测
[Y_knn, Yscore_knn] = knn.predict(Xtest);
Yscore_knn = Yscore_knn(:,2);
% 计算混淆矩阵
disp('最近邻方法分类结果：')
C_knn = confusionmat(Ytest,Y_knn)

%% 贝叶斯
% 设置分布类型
dist = repmat({'normal'},1,width(bank)-1);
dist(catPred) = {'mvmn'};
% 训练分类器
Nb = NaiveBayes.fit(Xtrain,Ytrain,'Distribution',dist);
% 进行预测
Y_Nb = Nb.predict(Xtest);
Yscore_Nb = Nb.posterior(Xtest);
Yscore_Nb = Yscore_Nb(:,2);
% 计算混淆矩阵
disp('贝叶斯方法分类结果：')
C_nb = confusionmat(Ytest,Y_Nb)

%% 神经网络
% 设置神经网络模式及参数
hiddenLayerSize = 5;
net = patternnet(hiddenLayerSize);
% 设置训练集、验证机和测试集
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
% 训练网络
net.trainParam.showWindow = false;
inputs = XtrainNum';
targets = YtrainNum';
[net,~] = train(net,inputs,targets);
% 用测试集数据进行预测
Yscore_nn = net(XtestNum')';
Y_nn = round(Yscore_nn);
% 计算混淆矩阵
disp('神经网络方法分类结果：')
C_nn = confusionmat(YtestNum,Y_nn)

%% Logistic
% 训练分类器
glm = fitglm(Xtrain,YtrainNum,'linear', 'Distribution','binomial',...
    'link','logit','CategoricalVars',catPred, 'VarNames', names);
% 用测试集数据进行预测
Yscore_glm = glm.predict(Xtest);
Y_glm = round(Yscore_glm);
% 计算混淆矩阵
disp('Logistic方法分类结果：')
C_glm = confusionmat(YtestNum,Y_glm)

%% 判别分析
% 训练分类器
da = ClassificationDiscriminant.fit(XtrainNum,Ytrain);
% 进行预测
[Y_da, Yscore_da] = da.predict(XtestNum); 
Yscore_da = Yscore_da(:,2);
% 计算混淆矩阵
disp('判别方法分类结果：')
C_da = confusionmat(Ytest,Y_da)

%% 支持向量机(SVM)
% 设置最大迭代次数
opts = statset('MaxIter',45000);
% 训练分类器
svmStruct = svmtrain(Xtrain,Ytrain,'kernel_function','linear','kktviolationlevel',0.2,'options',opts);
% 进行预测
Y_svm = svmclassify(svmStruct,Xtest);
Yscore_svm = svmscore(svmStruct, Xtest);
Yscore_svm = (Yscore_svm - min(Yscore_svm))/range(Yscore_svm);
% 计算混淆矩阵
disp('SVM方法分类结果：')
C_svm = confusionmat(Ytest,Y_svm)

%% 决策树
% 训练分类器
t = ClassificationTree.fit(Xtrain,Ytrain,'CategoricalPredictors',catPred);
% 进行预测
Y_t = t.predict(Xtest);
% 计算混淆矩阵
disp('决策树方法分类结果：')
C_t = confusionmat(Ytest,Y_t)

%% 通过ROC曲线来比较方法
methods = {'KNN','NBayes','NNet', 'GLM',  'LDA', 'SVM'};
scores = [Yscore_knn, Yscore_Nb, Yscore_nn, Yscore_glm, Yscore_da,  Yscore_svm];
%绘制ROC曲线
figure
auc= zeros(6); hCurve = zeros(1,6);
for ii=1:6;
  [rocx, rocy, ~, auc(ii)] = perfcurve(Ytest, scores(:,ii), 'yes');
  hCurve(ii,:) = plot(rocx, rocy, 'k','LineWidth',2); hold on;
end
legend(hCurve(:,1), methods)
set(gca,'linewidth',2);
grid on;
title('各方法ROC曲线', 'fontsize',12); 
xlabel('假阳率 [ = FP/(TN+FP)]', 'fontsize',12); 
ylabel('真阳率 [ = TP/(TP+FN)]', 'fontsize',12);
% 绘制各方法分类正确率
figure;
bar(auc); set(gca,'YGrid', 'on','XTickLabel',methods); 
xlabel('方法简称', 'fontsize',12); 
ylabel('分类正确率', 'fontsize',12);
title('各方法分类正确率','fontsize',12);
set(gca,'linewidth',2);
 