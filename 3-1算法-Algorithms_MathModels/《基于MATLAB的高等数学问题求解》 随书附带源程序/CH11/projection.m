function h=projection(F,G,limit,type)
%PROJECTION   绘制空间曲线在坐标面上的投影
% PROJECTION(F,G)  绘制曲面F和G的交线在xOy面上x∈[-2*pi,2*pi]的投影
% PROJECTION(F,G,LIMIT)  绘制曲面F和G的交线在xOy面上x∈LIMIT的投影
% PROJECTION(F,G,LIMIT,TYPE)  绘制曲面F和G的交线在指定坐标面上的投影
% H=PROJECTION(...)  绘制空间曲线在做表面上的投影并返回其句柄
%
% 输入参数：
%     ---F,G：两个相交的曲面方程
%     ---LIMIT：自变量范围
%     ---TYPE：指定坐标面的类型
% 输出参数：
%     ---H：投影图形的句柄
%
% See also ezplot

if nargin<4
    type='z';
end
if nargin<3
    limit=[-2*pi,2*pi];
end
s=unique([symvar(F),symvar(G)]);
if ~ismember(type,s)
    error('Illegal options.')
end
x=solve(F,type);
G=subs(G,type,x(1));
hp=ezplot(G,limit);
if nargout>0
    h=hp;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html