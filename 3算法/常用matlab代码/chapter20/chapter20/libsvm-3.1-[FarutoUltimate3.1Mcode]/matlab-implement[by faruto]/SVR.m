function [predict_Y,mse,r] = SVR(train_y,train_x,test_y,test_x,Method_option)
% SVC 
%
% by faruto
% Email:patrick.lee@foxmail.com 
% QQ:516667408 
% http://blog.sina.com.cn/faruto 
% last modified 2011.06.08
% www.matlabsky.com
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
% Method_option.xscale = 0 or 1
% Method_option.yscale = 0 or 1
% Method_option.plotScale = 0 or 1
% Method_option.pca = 0 or 1
% Method_option.type = 1[grid] or 2[ga] or 3[pso] or 4 5
%
% ====================output=================

%%
if nargin < 5
    Method_option.plotOriginal = 1;
    Method_option.xscale = 1
    Method_option.yscale = 0
    Method_option.plotScale = 0;
    Method_option.pca = 0;
    Method_option.type = 1;
end
if nargin == 2
    test_y = train_y;
    test_x = train_x;
end
%%
TrainL = train_y;
Train = train_x;
TestL = test_y;
Test = test_x;
%% plotOriginal
if Method_option.plotOriginal == 1
    
    figure;
    plot(TrainL,'r*-');
    grid on;
    title('Visualization for train_y');
    
end
%% Method_option.xscale = 0 or 1
if Method_option.xscale == 1
    [Train,Test] = scaleForSVM(Train,Test,-1,1);
end
%% Method_option.yscale = 0 or 1
if Method_option.yscale == 1
    [TrainL,TestL,ps] = scaleForSVM(TrainL,TestL,0,1);
end
%% Method_option.plotScale
if Method_option.yscale == 1 && Method_option.plotScale == 1
    
    figure;
    plot(TrainL,'r*-');
    grid on;
    title('Visualization for train_y after scale');
    
end
%% Method_option.pca
if Method_option.pca == 1
    [Train,Test] = pcaForSVM(Train,Test,98);
end
%% Matlab Toolbox for Dimensionality Reduction

% X = [Train;Test];
% no_dims = round(intrinsic_dim(X, 'MLE'));
% % 'PCA' 'LDA' 'MDS' 'Isomap' 'LLE'
% % 'ProbPCA' 'FactorAnalysis' 'GPLVM'
% % 'DiffusionMaps'
% [mappedX,mapping] = compute_mapping(X,'GPLVM',no_dims);
% 
% [m1,n1] = size(Train);
% [m2,n2] = size(Test);
% 
% Train = mappedX(1:m1,:);
% Test = mappedX(m1+1:end,:);

%% Method_option.type = 1[grid] or 2[ga] or 3[pso]

% grid
if Method_option.type == 1
    [bestCVmse,bestc,bestg] = SVMcgForRegress(TrainL,Train,-8,8,-8,8,5,0.4,0.4)
    cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
end

% ga cg
if Method_option.type == 2
    
    ga_option.maxgen = 100;
    ga_option.sizepop = 20;
    ga_option.cbound = [0,100];
    ga_option.gbound = [0,100];
    ga_option.v = 5;
    ga_option.ggap = 0.9;
    [bestCVmse,bestc,bestg] = ...
    gaSVMcgForRegress(TrainL,Train,ga_option)
    cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
end

% pso cg
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
    
    [bestCVmse,bestc,bestg] = psoSVMcgForRegress(TrainL,Train,pso_option)
    cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];
end

% pso cgp
if Method_option.type == 4
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
    
    pso_option.poppmax = 10;
    pso_option.poppmin = 0.01;
    
    [bestCVmse,bestc,bestg,bestp] = psoSVMcgpForRegress(TrainL,Train,pso_option)
    cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -p ',num2str(bestp),' -s 3'];
end

% ga cgp
if Method_option.type == 5
    
    ga_option.maxgen = 100;
    ga_option.sizepop = 20;
    ga_option.v = 5;
    ga_option.ggap = 0.9;
    ga_option.cbound = [0,100];
    ga_option.gbound = [0,100];
    ga_option.pbound = [0.01,1];
    
    [bestCVmse,bestc,bestg,bestp] = ...
    gaSVMcgpForRegress(TrainL,Train,ga_option)
    cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -p ',num2str(bestp),' -s 3'];
end

if Method_option.type == 6
    [bestCVmse,bestc,bestg,bestp] = SVMcgpForRegress(TrainL,Train)
    cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -p ',num2str(bestp),' -s 3'];
end

%% predict

% cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.01'];

model = svmtrain(TrainL,Train,cmd);

[ptrain, train_mse] = svmpredict(TrainL,Train, model);

[ptest, test_mse] = svmpredict(TestL,Test, model);

if Method_option.yscale == 1
    ptrain = mapminmax('reverse',ptrain',ps);
    ptrain = ptrain';
    ptest = mapminmax('reverse',ptest',ps);
    ptest = ptest';
end
%%
predict_Y = cell(1,2);
predict_Y{1} = ptrain;
predict_Y{2} = ptest;

mse = zeros(1,2);
r = zeros(1,2);
mse(1) = train_mse(2);
mse(2) = test_mse(2);
mse
r(1) = train_mse(3);
r(2) = test_mse(3);
r
%% plot

figure;
if nargin >= 4
    subplot(2,1,1);
end
plot(train_y,'-o');
hold on;
plot(ptrain,'r-s');
grid on;
legend('original','predict');
title('Train Set Regression Predict by SVM');

if nargin >= 4
    subplot(2,1,2);
    plot(test_y,'-d');
    hold on
    plot(ptest,'r-*');
    legend('original','predict');
    title('Test Set Regression Predict by SVM');
    grid on;
end

if nargin >= 4
    figure;
    hold on;
    grid on;
    plot([train_y;test_y],'-o');
    plot([ptrain;ptest],'r-s');

    legend('original','predict');
end
