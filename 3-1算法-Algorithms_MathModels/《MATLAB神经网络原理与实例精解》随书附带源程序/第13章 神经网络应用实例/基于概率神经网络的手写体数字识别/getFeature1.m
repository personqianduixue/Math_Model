function [Feature,bmp,flag]=getFeature1(A)
% getFeature.m
% 提取64*64二值图像的特征向量
% input:
% A: 64*64矩阵
% output:
% Feature: 长度为14的特征向量
% bmp    : 图像中的数字部分
% flag   : 标志位，表示数字部分的宽高比

% 反色
A = ones(64) - A;

% 提取数字部分
[x, y] = find(A == 1);

% 截取图像中的数字部分
A = A(min(x):max(x),min(y):max(y));  

% 计算宽高比和标志位
flag = (max(y)-min(y)+1)/(max(x)-min(x)+1);
if flag < 0.5
    flag = 0;
elseif flag >=0.5 && flag <0.75
    flag = 1;
elseif flag >=0.75 && flag <1
    flag = 2;
else
    flag = 3;
end

% 重新放大，将长或宽调整为64
rate = 64 / max(size(A));
% 调整尺寸
A = imresize(A,rate);  
[x,y] = size(A);

% 不足64的部分用零填充
if x ~= 64
    A = [zeros(ceil((64-x)/2)-1,y);A;zeros(floor((64-x)/2)+1,y)];
end;
if y ~= 64
    A = [zeros(64,ceil((64-y)/2)-1),A,zeros(64,floor((64-y)/2)+1)];
end

%% 三条竖线与数字字符的交点个数  F(1)~F(3)
% 1/2 竖线交点数量
Vc = 32;
Num = 0;
for i = 1:64
    Num = Num+A(i, Vc);
end
F(1) = Num;
% F(1) = sum(A(:,Vc));

% 5/12 竖线交点数量
Vc = round(64*3/12);
Num = 0;
for i = 1:64
    Num = Num + A(i, Vc);
end
F(2) = Num;
% F(2) = sum(A(:,Vc));

% 7/12 竖线交点数量
Vc = round(64*9/12);
Num = 0;
for i = 1:64
    Num = Num + A(i, Vc);
end
F(3)=Num;
% F(3) = sum(A(:,Vc));

%% 三条横线与数字字符的交点个数 F(4)~F(6)
% 1/2 水平线交点数量
Hc = 32;
Num = 0;
for i = 1:64
    Num = Num + A(Hc, i);
end
F(4) = Num;
%  F(4) = sum(A(Hc,:));

% 1/3 水平线处交点数量，
Hc = round(64/3);
Num = 0;
for i = 1:64
    Num = Num + A(Hc, i);
end
F(5) = Num;
%  F(5) = sum(A(Hc,:));
 
% 2/3水平线处交点数量
Hc = round(2*64/3);
Num = 0;
for i = 1:64
    Num = Num + A(Hc, i);
end
F(6) = Num;
%  F(6) = sum(A(Hc,:));
%% 两条对角线的交点数量
% 主对角线交点数，
x3 = 1;
y3 = 1;
Num = 0;
for i = 0:63
    Num = Num+A(x3+i,y3+i);
end
F(7) = Num;
% F(7) = sum(diag(A));
% 次对角线交点数
x4 = 1;
y4 = 64;
Num = 0;
for i = 0:63
    Num = Num + A(x4+i, y4-i);
end
F(8) = Num;
% F(8) = sum(diag(rot90(A)));
%% 小方块

% 右下角1/2小方块中的所有点
Num = 0;
for i = 32:64
    for r = 32:64
        Num = Num + A(i,r);
    end
end
F(9) = Num/10;
% t = A(32:64,33:64);
% F(9) = sum(t(:))/10;
% 左上角1/2小方块中的所有点
Num = 0;
for i3 = 1:32
    for r3 = 1:32
        Num = Num + A(i3,r3);
    end
end
F(10) = Num/10;
% t = A(1:32,1:32);
% F(10) = sum(t(:))/10;
% 左下角方块中的所有点
Num = 0;
for i4 = 1:32
    for r4 = 32:64
        Num = Num + A(i4,r4);
    end
end
F(11) = Num/10;
% t = A(1:32,32:64);
% F(11) = sum(t(:))/10;
% 右上角方块中的所有点
Num = 0;
for i5 = 32:64
    for r5 = 1:32
        Num = Num + A(i5,r5);
    end
end
F(12) = Num/10;
% t = A(32:64,1:32);
% F(12) = sum(t(:))/10;
% 下方2/3部分的所有像素点
Num = 0;
for i1 = 1:64
    for r1 = 16:48
        Num = Num + A(i1,r1);
    end
end
F(13) = Num/20;
% t = A(1:64,16:64);
% F(13) = sum(t(:))/20;
% 右方2/3部分的所有像素点
Num = 0;
for i2 = 16:48
    for r2 = 1:64
        Num = Num + A(i2,r2);
    end
end
F(14) = Num/20;
% t = A(16:48,1:64);
% F(14) = sum(t(:))/20;
Feature = F';
bmp = A;
