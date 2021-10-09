%% Matlab神经网络43个案例分析

% 基于SVM的图像分割-真彩色图像分割
% by 李洋(faruto)
% http://www.matlabsky.com
% Email:faruto@163.com
% http://weibo.com/faruto 
% http://blog.sina.com.cn/faruto
% 2013.01.01
%% A Little Clean Work
tic;
close all;
clear;
clc;
format compact;
%% 读取图像数据

% 读入图像，放在矩阵pic
pic = imread('littleduck.jpg');
% 查看矩阵pic的大小和类型
whos pic;

scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
imshow(pic);
%% 确定训练集

TrainData_background = zeros(20,3,'double');
TrainData_foreground = zeros(20,3,'double');

% % 背景（湖水）采样
% msgbox('Please get 20 background samples（点击OK后再按任意键继续）', ...
%     'Background Samples','help');
% pause;
% for run = 1:20
%     [x,y] = ginput(1);
%     hold on;
%     plot(x,y,'r*');
%     x = uint8(x);
%     y = uint8(y);
%     TrainData_background(run,1) = pic(x,y,1);
%     TrainData_background(run,2) = pic(x,y,2);
%     TrainData_background(run,3) = pic(x,y,3);
% end 

% % 待分割出来的前景（鸭子）采样
% msgbox('Please get 20 foreground samples which is the part to be segmented（点击OK后再按任意键继续）', ...
%     'Foreground Samples','help');
% pause;
% for run = 1:20
%     [x,y] = ginput(1);
%     hold on;
%     plot(x,y,'ro');
%     x = uint8(x);
%     y = uint8(y);
%     TrainData_foreground(run,1) = pic(x,y,1);
%     TrainData_foreground(run,2) = pic(x,y,2);
%     TrainData_foreground(run,3) = pic(x,y,3);
% end 

% % 背景（湖水）训练样本 10*3
TrainData_background = ...
    [52 74 87;
    76 117 150;
    19 48 62;
    35 64 82;
    46 58 36;
    50 57 23;
    110 127 135;
    156 173 189;
    246 242 232;
    166 174 151];

% % 前景（鸭子）训练样本 8*3
TrainData_foreground = ...
    [211 192 107;
    202 193 164;
    32 25 0;
    213 201 151;
    115 75 16;
    101 70 0;
    169 131 22;
    150 133 87];

%% 建立支持向量机

% let background be 0 & foreground 1
% 即 属于背景（湖水）的点为0，属于前景（鸭子）的点位1 
TrainLabel = [zeros(length(TrainData_background),1); ...
    ones(length(TrainData_foreground),1)];

TrainData = [TrainData_background;TrainData_foreground];

model = svmtrain(TrainLabel, TrainData, '-t 1 -d 1');
%% 进行预测i.e.进行图像分割
preTrainLabel = svmpredict(TrainLabel, TrainData, model);
% 求三维矩阵pic的行数m，列数n，页数k
[m,n,k] = size(pic)
% 将三维矩阵pic转成m*n行，k列的双精度二维矩阵
TestData = double(reshape(pic,m*n,k));
% 查看矩阵TestData的大小和类型
whos TestData;
% 预测前景（鸭子）和背景（湖水）的标签
TestLabal = svmpredict(zeros(length(TestData),1), TestData, model);
%% 展示分割后的图像

% 根据预测得到的前景（鸭子）和背景（湖水）标签对整个图像的像素点进行分类，进而达到图像分割目的。
ind = reshape([TestLabal,TestLabal,TestLabal],m,n,k);
ind = logical(ind);
pic_seg = pic;
pic_seg(~ind) = 0;

% 展示分割后的图像
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
imshow(pic_seg);
% 分割前和分割后图像对比查看
scrsz = get(0,'ScreenSize');
figure('Position',[scrsz(3)*1/4 scrsz(4)*1/6  scrsz(3)*4/5 scrsz(4)]*3/4);
subplot(1,2,1);
imshow(pic);
subplot(1,2,2);
imshow(pic_seg);
%%
toc;