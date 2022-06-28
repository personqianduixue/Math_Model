function [traind,trainl,testd,testl]=divide(data,label)
% 数据划分
% [data,label]=getdata('student.xls')
%[traind,trainl,testd,testl]=divide(data,label)

% 随机数
% rng(0)
% 男女各取30个进行训练
TRAIN_NUM_M=30;
TRAIN_NUM_F=30;

% 男女分开
m_data=data(label==1,:);
f_data=data(label==0,:);

NUM_M=length(m_data); % 男生的个数

% 男
r=randperm(NUM_M);%randperm是matlab函数，功能是随机打乱一个数字序列。其内的参数决定了随机数的范围
traind(1:TRAIN_NUM_M,:)=m_data(r(1:TRAIN_NUM_M),:);
testd(1:NUM_M-TRAIN_NUM_M,:)= m_data(r(TRAIN_NUM_M+1:NUM_M),:);

NUM_F=length(f_data); % 女生的个数

% 女
r=randperm(NUM_F);
traind(TRAIN_NUM_M+1:TRAIN_NUM_M+TRAIN_NUM_F,:)=f_data(r(1:TRAIN_NUM_F),:);
testd(NUM_M-TRAIN_NUM_M+1:NUM_M-TRAIN_NUM_M+NUM_F-TRAIN_NUM_F,:)=f_data(r(TRAIN_NUM_F+1:NUM_F),:);

% 赋值
trainl=zeros(1,TRAIN_NUM_M+TRAIN_NUM_F);
trainl(1:TRAIN_NUM_M)=1;

testl=zeros(1,NUM_M+NUM_F-TRAIN_NUM_M-TRAIN_NUM_F);
testl(1:NUM_M-TRAIN_NUM_M)=1;
