function S=LineConvert(PI1,PI2)
%LINECONVERT   将直线的一般方程转化为参数方程
% S=LINECONVERT(PI1,PI2)  求平面PI1和PI2的交线的参数方程
%
% 输入参数：
%     ---PI1,PI2：平面的系数向量
% 输出参数：
%     ---S：参数方程表达式
%
% See also \, cross

if ~isvector(PI1) && ~isvector(PI2)
    error('PI1 and PI2 must be vectors.')
end
if length(PI1)==4 && length(PI2)==4
    A=[PI1(1:3);PI2(1:3)];
    b=-[PI1(4);PI2(4)];
    x0=A\b;
    s=cross(A(1,:),A(2,:));
    syms t
    S=x0(:)+s(:)*t;
else
    error('输入向量必须为4维向量.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html