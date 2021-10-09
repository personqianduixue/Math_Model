function r=CrossPoint(varargin)
%CROSSPOINT   确定图形所在的水平区间
% R=CROSSPOINT(F1,F2)  返回曲线F1和F2的交点横坐标，符号自变量为自由自变量
% R=CROSSPOINT(F1,F2,X)  返回曲线F1和F2的交点横坐标，符号自变量为X
% 
% 输入参数：
%     ---F1,F2：曲线的函数描述
% 输出参数：
%     ---R：交点横坐标区间
%
% See also solve

[f1,f2]=deal(varargin{1:2});
s=unique([symvar(f1),symvar(f2)]);
if nargin==2 && length(s)==1
    x=s;
else
    x=varargin{3};
end
x0=solve(f1-f2,x);
N=length(x0);
r=zeros(N-1,2);
for k=1:N-1
    r(k,:)=[x0(k),x0(k+1)];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html