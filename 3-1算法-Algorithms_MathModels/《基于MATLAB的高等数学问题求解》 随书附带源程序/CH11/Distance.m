function D=Distance(A,B)
%DISTANCE   计算两点之间的距离
% DISTANCE(A)  绘制原点到点A的向量，图题标注为原点到A的距离
% DISTANCE(A,B)   绘制点B到点A的向量，图题标注为A，B间的距离
% D=DISTANCE(...)  计算原点到A或A、B之间的距离
%
% 输入参数：
%     ---A：终点
%     ---B：起点
% 输出参数：
%     ---D：A、B间的距离
%
% See also norm, sqrt

if nargin==1
    B=zeros(size(A));
end
[m,n]=size(A);
if ~isequal([m,n],size(B)) || m~=1
    error('点的坐标表示形式有误.')
end
C=A-B;
L=0;
for k=1:n
    L=L+C(k)^2;
end
L=sqrt(L);
if isnumeric([A,B]) && (n==2 || n==3) && nargout==0
    drawvec(C,B)
    title(['|AB|=',num2str(L)])
elseif nargout==1
    D=L;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html