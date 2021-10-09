function [train, test] = rnd_partition(data, train_percent);
% function [train, test] = rnd_partition(data, train_percent);
%
% data(:,i) is the i'th example
% train_percent of these columns get put into train, the rest into test

N = size(data, 2);
ndx = randperm(N);
k = ceil(N*train_percent);
train_ndx = ndx(1:k);
test_ndx = ndx(k+1:end);
train =  data(:, train_ndx);
test = data(:, test_ndx);
