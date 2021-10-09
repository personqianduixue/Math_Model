%% 深度学习案例：人类行为的分类
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 下载数据
if false %~exist('UCI HAR Dataset','file')
    downloadSensorData;
end
if ~exist('rawSensorData_train.mat','file') && ~exist('rawSensorData_test.mat','file')
    LoadSensorData;
end
load rawSensorData_train

%% 定义深度学习结构
allRawDataDL = cat(3, body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, total_acc_x_train, total_acc_y_train, total_acc_z_train);
C = num2cell(allRawDataDL, [2 3]);
C = cellfun(@squeeze, C, 'UniformOutput', false);
trainingData = table(C);
trainingData.activity = categorical(trainActivity);
% class(trainingData{:,1}) % should be cell

layers = [imageInputLayer([128 6])
            convolution2dLayer(3, 2)
            reluLayer
            maxPooling2dLayer([12 2], 'Stride', 1)
            fullyConnectedLayer(5)
            softmaxLayer
            classificationLayer()];
        
options = trainingOptions('sgdm','MaxEpochs',15, ...
	'InitialLearnRate',0.005);

convnet = trainNetwork(trainingData, layers, options);

%% 训练深度网络
load rawSensorData_test
%
allRawDataTestDL = cat(3, body_gyro_x_test, body_gyro_y_test, body_gyro_z_test, total_acc_x_test, total_acc_y_test, total_acc_z_test);
Ctest = num2cell(allRawDataTestDL, [2 3]);
Ctest = cellfun(@squeeze, Ctest, 'UniformOutput', false);
testData = table(Ctest);
testData.activity = categorical(testActivity);
Y_test = classify(convnet, testData(:,1));
accuracy_test = sum(Y_test == testActivity)/numel(testActivity) %#ok<*NOPTS>
cm = confusionmat(testActivity, Y_test);

% Display in a table
test_results = array2table(cm, ...
    'RowNames', {'Walking', 'ClibmingStairs', 'Sitting', 'Standing', 'Laying'}, ...  
    'VariableNames', {'Walking', 'ClibmingStairs', 'Sitting', 'Standing', 'Laying'})

