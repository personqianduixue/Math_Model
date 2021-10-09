function [train_dct,test_dct] = DCTforSVM(train_data,test_data)
% scaleForSVM 
% by faruto Email:farutoliyang@gmail.com
% 2009.10.28

%%
[mtrain,ntrain] = size(train_data);
[mtest,ntest] = size(test_data);
dataset = [train_data;test_data];

dataset_dct = dct(dataset');
dataset_dct = dataset_dct';

train_dct = dataset_dct(1:mtrain,:);
test_dct = dataset_dct( (mtrain+1):(mtrain+mtest),: );
