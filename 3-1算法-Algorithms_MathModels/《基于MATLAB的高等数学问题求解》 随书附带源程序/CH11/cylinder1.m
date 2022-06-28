function varargout=cylinder1(x,y,N)
%CYLINDER1   绘制柱面
% CYLINDER1  绘制底面圆的圆心在原点，半径为1，高度为1的圆柱
% CYLINDER1(X,Y)  绘制以X和Y构成的曲线为母线的高度为1的柱面
% CYLINDER1(X,Y,N)  绘制以X和Y构成的曲线为母线的柱面，并将其高度分为N等分
% H=CYLINDER1(...)  绘制柱面并返回其句柄
% [XX,YY,ZZ]=CYLINDER1(...)  计算柱面坐标数据
%
% 输入参数：
%     ---X,Y：母线的坐标数据
%     ---N：柱面高度的等分数
% 输出参数：
%     ---H：柱面的句柄
%     ---XX,YY,ZZ：柱面坐标数据
%
% See also cylinder

if nargin<3
    N=2;
end
t=linspace(0,2*pi);
if nargin<1
    x=cos(t);y=sin(t);
end   
if length(x)~=length(y)
    error('曲线坐标维数不匹配.')
end
x=x(:); y=y(:);
X=repmat(x,1,N);
Y=repmat(y,1,N);
Z=repmat(linspace(0,1,N),length(x),1);
if nargout==0
    surf(X,Y,Z)
elseif nargout==1
    h=surf(X,Y,Z);
    varargout{1}=h;
else
    varargout{1}=X; varargout{2}=Y; varargout{3}=Z;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html