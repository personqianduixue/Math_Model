% football.m
% 亚洲足球水平聚类

%% 清空工作空间
clear,clc
close all;

rng(now)
M=4;
%% 定义输入样本
N = 16;
strr = {'中国','日本','韩国','伊朗','沙特','伊拉克','卡塔尔','阿联酋','乌兹别克','泰国',...
    '越南','阿曼','巴林','朝鲜','印尼','澳大利亚'};
data = [43,43,9,9;        % 中国
    28,9,4,1;               % 日本
    17,15,3,3;              % 韩国
    25,33,5,5;              % 伊朗
    28,33,2,9;              % 沙特
    43,43,1,5;              % 伊拉克
    43,33,9,5;              % 卡塔尔
    43,33,9,9;              % 阿联酋 
    33,33,5,4;              % 乌兹别克 
    43,43,9,17;             % 泰国 
    43,43,5,17;             % 越南
    43,43,9,17;             % 阿曼
    33,33,9,9;              % 巴林
    33,32,17,9;             % 朝鲜
    43,43,9,17;             % 印尼
    16,21,5,2]';            % 澳大利亚

%% 创建网络
% 2*2 自组织映射网络
net = selforgmap([2,2]);

%% 网络训练
data = mapminmax(data);
tic
net = init(net);
net = train(net, data([1,2,3,4],:));
toc

%% 测试
y = net(data([1,2,3,4],:));

% 将向量表示的类别转为标量
result = vec2ind(y);

%% 输出结果
% 将分类标签按实力排序
score = zeros(1,M);
for i=1:M
    t = data(:, result==i);
    score(i) = mean(t(:));
end
[~,ind] = sort(score);

result_ = zeros(1,N);
for i=1:M
    result_(result == ind(i)) = i; 
end

fprintf('  足球队            实力水平\n');
for i = 1:N
    fprintf('   %-8s      第 %d 流\n', strr{i}, result_(i)) ;
end
web -broswer http://www.ilovematlab.cn/forum-222-1.html

