function varargout=max_min(fun,xrange,yrange,type)
%MAX_MIN   验证有界闭区域上二元函数的介值定理
% MAX_MIN(FUN,XRANGE,YRANGE)  图形化方法演示有界闭区域上二元函数的介值定理
% MAX_MIN(FUN,XRANGE,YRANGE,TYPE)  图形化方法演示有界闭区域上二元函数的介值定理，
%                                  图形可以有两种显示方式：'rect'和'circ'
% [ZMAX,ZMIN]=MAX_MIN(...)  返回函数在指定区域上的最大值和最小值
%
% 输入参数：
%     ---FUN：给定的二元函数
%     ---XRANGE,YRANGE：自变量范围
%     ---TYPE：图形绘制类型，有'rect'和'circ'两个取值
% 输出参数：
%     ---ZMAX,ZMIN：函数的最大值和最小值
%
% See also ezsurf, max, min

if nargin==3
    type='circ';
end
if ~any(strcmp(type,{'rect','circ'}))
    error('The Input argument type must be either ''rect'' or ''circ''.')
end
h=ezsurf(fun,[xrange yrange],type);
X=get(h,'XData');
Y=get(h,'YData');
Z=get(h,'ZData');
zmax=max(Z(:));
zmin=min(Z(:));
hold on
surf(X,Y,zmax*ones(size(X)))
surf(X,Y,zmin*ones(size(X)))
shading interp
if nargout>0
    varargout{1}=zmax;varargout{2}=zmin;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html