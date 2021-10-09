function [predict_label,accuracy] = SVC(train_label,train_data,test_label,test_data,Method_option)
% SVC 
%
% by faruto
% Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto
% last modified 2011.06.08
% Èô×ªÔØÇë×¢Ã÷£º
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2011. 
% Software available at http://www.matlabsky.com
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm
%%
% ====================input==================
% Method_option.plotOriginal = 0 or 1
% Method_option.scale = 0 or 1
% Method_option.plotScale = 0 or 1
% Method_option.pca = 0 or 1
% Method_option.type = 1[grid] or 2[ga] or 3[pso]
%
% ====================output=================

%%
if nargin < 5
    Method_option.plotOriginal = 1;
    Method_option.scale = 1;
    Method_option.plotScale = 1;
    Method_option.pca = 1;
    Method_option.type = 1;
end
if nargin == 2
    test_label = train_label;
    test_data = train_data;
end
%%
TrainL = train_label;
Train = train_data;
TestL = test_label;
Test = test_data;
%% plotOriginal
if Method_option.plotOriginal == 1
    figure;
    boxplot(Train,'orientation','horizontal');
    grid on;
    title('Visualization for train set data');
    figure;
    for i = 1:length(Train(:,1))
        plot(Train(i,1),Train(i,2),'r*');
        hold on;
    end
    grid on;
    title('Visualization for 1st dimension & 2nd dimension of train set data');
end
%% scale
if Method_option.scale == 1
    [Train,Test] = scaleForSVM(Train,Test,0,1);
end
%% Method_option.plotScale
if Method_option.plotScale == 1
    figure;
    for i = 1:length(Train(:,1))
        plot(Train(i,1),Train(i,2),'r*');
        hold on;
    end
    grid on;
    title('Visualization for 1st dimension & 2nd dimension of scale data of train set data');
end
%% Method_option.pca
if Method_option.pca == 1
    [Train,Test] = pcaForSVM(Train,Test,95);
end
%% Matlab Toolbox for Dimensionality Reduction

% X = [Train;Test];
% no_dims = round(intrinsic_dim(X, 'MLE'));
% % 'PCA' 'LDA' 'MDS' 'Isomap' 'LLE'
% % 'ProbPCA' 'FactorAnalysis' 'GPLVM'
% % 'DiffusionMaps'
% [mappedX,mapping] = compute_mapping(X,'DiffusionMaps',no_dims);
% 
% [m1,n1] = size(Train);
% [m2,n2] = size(Test);
% 
% Train = mappedX(1:m1,:);
% Test = mappedX(m1+1:end,:);

%% Method_option.type = 1[grid] or 2[ga] or 3[pso]

% grid
if Method_option.type == 1
    [bestCVaccuracy,bestc,bestg] = SVMcgForClass(TrainL,Train)
end

% ga
if Method_option.type == 2
    
    ga_option.maxgen = 100;
    ga_option.sizepop = 20;
    ga_option.cbound = [0,100];
    ga_option.gbound = [0,100];
    ga_option.v = 10;
    ga_option.ggap = 0.9;
    [bestCVaccuracy,bestc,bestg] = ...
    gaSVMcgForClass(TrainL,Train,ga_option)
end

% pso
if Method_option.type == 3
    pso_option.c1 = 1.5;
    pso_option.c2 = 1.7;
    pso_option.maxgen = 100;
    pso_option.sizepop = 20;
    pso_option.k = 0.6;
    pso_option.wV = 1;
    pso_option.wP = 1;
    pso_option.v = 3;
    pso_option.popcmax = 100;
    pso_option.popcmin = 0.1;
    pso_option.popgmax = 100;
    pso_option.popgmin = 0.1;
    
    [bestCVaccuracy,bestc,bestg] = psoSVMcgForClass(TrainL,Train,pso_option)
end

%% predict

cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];

model = svmtrain(TrainL,Train,cmd);

[ptrain_label, train_accuracy] = svmpredict(TrainL,Train, model);

[ptest_label, test_accuracy] = svmpredict(TestL,Test, model);

%%
predict_label = cell(1,2);
predict_label{1} = ptrain_label;
predict_label{2} = ptest_label;

accuracy = zeros(1,2);
accuracy(1) = train_accuracy(1);
accuracy(2) = test_accuracy(1);
accuracy
%% svmplot
if size(train_data,2) == 2
    figure;
    grid on;
    svmplot(ptrain_label,train_data,model);
    title('Train Data Set');
    
    figure;
    grid on;
    svmplot(ptest_label,test_data,model);
    title('Test Data Set');
end
