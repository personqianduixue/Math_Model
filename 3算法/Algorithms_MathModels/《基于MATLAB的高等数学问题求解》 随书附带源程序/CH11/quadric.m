function varargout=quadric(varargin)
%QUADRIC   绘制二次曲面
% QUADRIC('elliptic',XC,YC,ZC,A,B,N)  绘制椭圆锥面
% QUADRIC('ellipsoid',XC,YC,ZC,A,B,C,N)  绘制椭球面
% QUADRIC('hyperboloidofonesheet',XC,YC,ZC,A,B,C,N)  绘制单叶双曲面
% QUADRIC('hyperboloidoftwosheets',XC,YC,ZC,A,B,C,N)  绘制双叶双曲面
% QUADRIC('ellipticparaboloid',XC,YC,ZC,A,B,N)  绘制椭圆抛物面
% QUADRIC('hyperbolicparaboloid',A,B,N)  绘制双曲抛物面
% H=QUADRIC(...)  绘制二次曲面并返回其句柄
% [X,Y,Z]=QUADRIC(...)  计算二次曲面的坐标数据
%
% 输入参数：
%     ---XC,YC,ZC：二次曲面的中心坐标
%     ---A,B,C：二次曲面的参数
%     ---N：指定采样点数
%     ---TYPE：指定二次曲面类型，有上述6种取值
% 输出参数：
%     ---H：二次曲面的句柄
%     ---X,Y,Z：二次曲面的坐标数据
%
% See also cylinder, ellipsoid

args=varargin;
type=args{1};
switch lower(type)
    case {1,'elliptic','椭圆锥面'}
        [xc,yc,zc,a,b,n]=deal(args{2:end});
        z=linspace(-a,a);
        [X,Y,Z]=cylinder(a*z,n);
        X=X+xc;
        Y=b/a*Y+yc;
        Z=-a+2*a*Z+zc;
    case {2,'ellipsoid','椭球面'}
        [xc,yc,zc,a,b,c,n]=deal(args{2:end});
        [X,Y,Z]=ellipsoid(xc,yc,zc,a,b,c,n);
    case {3,'hyperboloidofonesheet','单叶双曲面'}
        % 参数方程：
        % x=a*sec(t)*cos(p)
        % y=b*sec(t)*sin(p)
        % z=c*tan(t)
        [xc,yc,zc,a,b,c,n]=deal(args{2:end});
        t=linspace(-pi/2.5,pi/2.5,n);
        p=linspace(-pi,pi,30);
        [T,P]=meshgrid(t,p);
        X=a*sec(T).*cos(P)+xc;
        Y=b*sec(T).*sin(P)+yc;
        Z=c*tan(T)+zc;
    case {4,'hyperboloidoftwosheets','双叶双曲面'}
        [xc,yc,zc,a,b,c,n]=deal(args{2:end});
        t=linspace(-pi/2.5,pi/2.5,n);
        p=linspace(-pi,pi,30);
        [T,P]=meshgrid(t,p);
        X=a*sec(T)+xc;
        Y=b*tan(T).*cos(P)+yc;
        Z=c*tan(T).*sin(P)+zc;
    case {5,'ellipticparaboloid','椭圆抛物面'}
        [xc,yc,zc,a,b,n]=deal(args{2:end});
        z=linspace(0,abs(a));
        [X,Y,Z]=cylinder(abs(a)*sqrt(z),n);
        X=X+xc;
        Y=b/a*Y+yc;
        Z=Z+zc;
    case {6,'hyperbolicparaboloid','双曲抛物面'}
        [a,b,n]=deal(args{2:end});
        x=linspace(-a^2, a^2,n);
        y=linspace(-b^2, b^2,n);
        [X,Y]=meshgrid(x,y);
        Z=X.^2/a^2-Y.^2/b^2;
end
if nargout==0
    surf(X,Y,Z)
elseif nargout==1
    h=surf(X,Y,Z);
    varargout{1}=h;
elseif nargout==3
    varargout{1}=X; varargout{2}=Y; varargout{3}=Z;
else
    error('The Number of output arguments is wrong.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html