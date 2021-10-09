function [train_pca,test_pca] = pcaForSVM(train,test,threshold)
% pca pre-process for SVM
%
%
% by faruto
%Email:patrick.lee@foxmail.com QQ:516667408 http://blog.sina.com.cn/faruto
%last modified 2011.06.08
%
% Èô×ªÔØÇë×¢Ã÷£º
% faruto and liyang , LIBSVM-farutoUltimateVersion 
% a toolbox with implements for support vector machines based on libsvm, 2011. 
% Software available at http://www.matlabsky.com
% 
% Chih-Chung Chang and Chih-Jen Lin, LIBSVM : a library for
% support vector machines, 2001. Software available at
% http://www.csie.ntu.edu.tw/~cjlin/libsvm
%%
if nargin == 2
    threshold = 90;
end
%%
[mtrain,ntrain] = size(train);
[mtest,ntest] = size(test);
dataset = [train;test];
%%
[dataset_coef,dataset_score,dataset_latent,dataset_t2] = princomp(dataset);
%%
dataset_cumsum = 100*cumsum(dataset_latent)./sum(dataset_latent);
index = find(dataset_cumsum >= threshold);
percent_explained = 100*dataset_latent/sum(dataset_latent);

figure;
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
grid on;
%% 
train_pca = dataset_score(1:mtrain,:);
test_pca = dataset_score( (mtrain+1):(mtrain+mtest),: );

train_pca = train_pca(:,1:index(1));
test_pca = test_pca(:,1:index(1));
