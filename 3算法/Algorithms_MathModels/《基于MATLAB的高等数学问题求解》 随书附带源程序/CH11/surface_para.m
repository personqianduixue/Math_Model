function surface_para(funx,funy,funz,varargin)
%SURFACE_PARA   绘制以参数方程表示的曲面或以参数方程表示的曲线绕z轴旋转所得的旋转曲面
% SURFACE_PARA(FUNX,FUNY,FUNZ,T)  绘制参数方程确定的曲线绕z轴旋转的旋转曲面
% SURFACE_PARA(FUNX,FUNY,FUNZ,U,V)  绘制参数方程确定的曲面
%
% 输入参数：
%     ---FUNX,FUNY,FUNZ：参数方程，可以是曲线或曲面
%     ---T：曲线参数方程自变量
%     ---U,V：曲面参数方程的自变量
%
% See also surf

s=unique([symvar(funx),symvar(funy),symvar(funz)]);
if length(s)==1
    theta=linspace(0,2*pi);
    t=varargin{1};
    [T,Th]=meshgrid(t,theta);
    X=subs(sqrt(funx^2+funy^2),s,T).*cos(Th);
    Y=subs(sqrt(funx^2+funy^2),s,T).*sin(Th);
    Z=subs(funz,s,T);
elseif length(s)==2
    [u,v]=deal(varargin{:});
    [U,V]=meshgrid(u,v);
    X=subs(funx,num2cell(s),{U,V});
    Y=subs(funy,num2cell(s),{U,V});
    Z=subs(funz,num2cell(s),{U,V});
else
    error('参数方程的参数个数有误.')
end
surf(X,Y,Z)
web -broswer http://www.ilovematlab.cn/forum-221-1.html