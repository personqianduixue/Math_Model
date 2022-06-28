% credit_class.m
% 信贷信用的评估
% 数据取自德国信用数据库

%% 清理工作空间
clear,clc

% 关闭图形窗口
close all

%% 读入数据
% 打开文件
fid = fopen('german.data', 'r');

% 按格式读取每一行
% 每行包括21项，包括字符串和数字
C = textscan(fid, '%s %d %s %s %d %s %s %d %s %s %d %s %d %s %s %d %s %d %s %s %d\n');

% 关闭文件
fclose(fid);

% 将字符串转换为整数
N = 20;
% 存放整数编码后的数值矩阵
C1=zeros(N+1,1000);
for i=1:N+1
    % 类别属性
    if iscell(C{i})
        for j=1:1000
            % eg: 'A12' -> 2
            if i<10
                d = textscan(C{i}{j}, '%c%c%d');
            % eg: 'A103'  -> 3
            else
                d = textscan(C{i}{j}, '%c%c%c%d');
            end
            C1(i,j) = d{end};
        end
    % 数值属性
    else
        C1(i,:) = C{i};
    end
end

%% 划分训练样本与测试样本

% 输入向量
x = C1(1:N, :);
% 目标输出
y = C1(N+1, :);

% 正例
posx = x(:,y==1);
% 负例
negx = x(:,y==2);

% 训练样本
trainx = [ posx(:,1:350), negx(:,1:150)];
trainy = [ones(1,350), ones(1,150)*2];

% 测试样本
testx = [ posx(:,351:700), negx(:,151:300)];
testy = trainy;
%% 样本归一化
% 训练样本归一化
[trainx, s1] = mapminmax(trainx);

% 测试样本归一化
testx = mapminmax('apply', testx, s1);
%% 创建网络，训练

% 创建BP网络
net = newff(trainx, trainy);
% 设置最大训练次数
net.trainParam.epochs = 1500;
% 目标误差
net.trainParam.goal = 1e-13;
% 显示级别
net.trainParam.show = 1;

% 训练
net = train(net,trainx, trainy);
%% 测试
y0 = net(testx);

% y0为浮点数输出。将y0量化为1或2。
y00 = y0;
% 以1.5为临界点，小于1.5为1，大于1.5为2
y00(y00<1.5)=1;
y00(y00>1.5)=2;

% 显示正确率
fprintf('正确率: \n');
disp(sum(y00==testy)/length(y00));
web -broswer http://www.ilovematlab.cn/forum-222-1.html