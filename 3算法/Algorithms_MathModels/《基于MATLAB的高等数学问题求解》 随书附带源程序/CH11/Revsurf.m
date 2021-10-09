function varargout=Revsurf(x,fun,type)
%REVSURF   绘制旋转体
% REVSURF(X,FUN)  绘制曲线FUN绕Z轴旋转所得的旋转体，其中FUN是关于Z的函数
% REVSURF(X,FUN,TYPE)  绘制FUN绕Z轴旋转所得的旋转体，其中FUN由TYPE指定自变量
% H=REVSURF(...)  绘制旋转体并返回旋转体图形句柄
% [XX,YY,ZZ]=REVSURF(...)  计算旋转体坐标数据
%
% 输入参数：
%     ---X：函数的自变量数据
%     ---FUN：描述曲线的函数
%     ---TYPE：指定函数的自变量，TYPE有以下两种取值：
%              1.'cylinder'或1：FUN是关于Z的函数
%              2.'revsurf'或2：FUN是关于X或Y的函数
% 输出参数：
%     ---H：旋转体图形句柄
%     ---XX,YY,ZZ：旋转体坐标数据
%
% See also cylinder

if nargin==2
    type='cylinder';
end
switch lower(type)
    case {1,'cylinder'}
        xL=min(x(:)); xR=max(x(:));
        [xx,yy,zz]=cylinder(fun(x),40);
        zz=xL+(xR-xL)*zz;
    case {2,'revsurf'}
        [theta,rho]=meshgrid(linspace(0,2*pi),x);
        [xx,yy]=pol2cart(theta,rho);
        R=sqrt(xx.^2+yy.^2);
        zz=fun(R);
    otherwise
        error('Illegal options.')
end
if nargout==0
    surf(xx,yy,zz)
elseif nargout==1
    varargout{1}=surf(xx,yy,zz);
elseif nargout==3
    varargout{1}=xx; varargout{2}=yy; varargout{3}=zz;
else
    error('The number of output arguments is Illegal.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html