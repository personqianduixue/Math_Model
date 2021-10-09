%% ClassResult_test
% by faruto
%% a litte clean work
tic;
close all;
clear;
clc;
format compact;
%%
% load wine_test;
% label = train_data_labels;
% data = train_data;

load heart_scale.mat;
data = heart_scale_inst;
label = heart_scale_label;

model = svmtrain(label,data);
%%
type = 1;
CR = ClassResult(label, data, model, type)

%%
toc;

