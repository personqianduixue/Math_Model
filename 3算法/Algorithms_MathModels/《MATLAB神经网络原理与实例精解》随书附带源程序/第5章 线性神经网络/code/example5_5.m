% example5_5.m
X = [1 2 -4 7; 0.1 3 10 6]			% 输入的矩阵，由4个二维向量组成
% X =
% 
%     1.0000    2.0000   -4.0000    7.0000
%     0.1000    3.0000   10.0000    6.0000
lr = maxlinlr(X,'bias')				% 带偏置时的最大学习率
% lr =
% 
%     0.0067

lr = maxlinlr(X)				% 不带偏置的最大学习率
% lr =
% 
%     0.0069

lr = 0.9999/max(eig(X*X'))			% 按公式算
% r =
% 
%     0.0069

P=-5:5; 					% 用实例4.1中的输入矩阵所算得的最大学习率
lr = maxlinlr(P)

% lr =
% 
%     0.0091
web -broswer http://www.ilovematlab.cn/forum-222-1.html