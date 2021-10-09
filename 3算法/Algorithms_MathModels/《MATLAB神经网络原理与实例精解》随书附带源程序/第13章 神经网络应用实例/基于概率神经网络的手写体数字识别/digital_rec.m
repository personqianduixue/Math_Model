% digital_rec.m  手写体数字的识别

%% 清理工作空间
clear,clc
close all

%% 读取数据
disp('开始读取图片...');
I = getPicData();
% load I
disp('图片读取完毕')

%% 特征提取
x0 = zeros(14, 1000);
disp('开始特征提取...')
for i=1:1000
    % 先进行中值滤波
    tmp = medfilt2(I(:,:,i),[3,3]);
    
    % 得到特征向量
    t= getFeature(tmp);
    x0(:,i) = t(:);
end

% 标签 label 为长度为1000的列向量
label = 1:10;
label = repmat(label,100,1);
label = label(:);
disp('特征提取完毕')

%% 神经网络模型的建立
tic
spread = .1;
% 归一化
[x, se] = mapminmax(x0);
% 创建概率神经网络
net = newpnn(x, ind2vec(label'));
ti = toc;
fprintf('建立网络模型共耗时 %f sec\n', ti);

%% 测试
% 输入原数据样本进行测试
lab0 = net(x);
% 将向量化的类别lab0转化为标量类别lab
lab = vec2ind(lab0);
% 计算正确率
rate = sum(label == lab') / length(label);
fprintf('训练样本的测试正确率为\n  %d%%\n', round(rate*100));

%% 带噪声的图片测试
I1 = I;
% 椒盐噪声的强度
nois = 0.2;
fea0 = zeros(14, 1000);
for i=1:1000
    tmp(:,:,i) = I1(:,:,i);
    % 添加噪声
    tmpn(:,:,i) =  imnoise(double(tmp(:,:,i)),'salt & pepper', nois);
%     tmpn(:,:,i) =  imnoise(double(tmp(:,:,i)),'gaussian',0, 0.1);
    % 中值滤波
    tmpt = medfilt2(tmpn(:,:,i),[3,3]);
    % 提取特征向量
    t = getFeature(tmpt);
    fea0(:,i) = t(:);
end

% 归一化
fea = mapminmax('apply',fea0, se);
% 测试
tlab0 = net(fea);
tlab = vec2ind(tlab0);

% 计算噪声干扰下的正确率
rat = sum(tlab' == label) / length(tlab);
fprintf('带噪声的训练样本测试正确率为\n  %d%%\n', round(rat*100));

web -broswer http://www.ilovematlab.cn/forum-222-1.html