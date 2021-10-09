function varargout=PlaneEquation(varargin)
%PLANEEQUATION   求平面的方程
% L=PLANEEQUATION(N,M0)  平面的点法式方程
% L=PLANEEQUATION(A,B,C,D)  平面的一般方程
% [L,TYPE]=PLANEEQUATION(...)  求平面的方程并返回方程类型
%
% 输入参数：
%     ---N：平面上点M0处的法向量
%     ---M0：平面上的一点
%     ---A,B,C,D：平面方程的系数
% 输出参数：
%     ---L：平面方程
%     ---TYPE：平面方程类型字符串
%
% See also dot

syms x y z
if nargin==2
    [n,M0]=deal(varargin{:});
    M=[x,y,z];
    M0M=M-M0;
    L=dot(n,M0M);
    type='平面的点法式方程';
elseif nargin==4
    [A,B,C,D]=deal(varargin{:});
    L=A*x+B*y+C*z+D;
    type='平面的一般式方程';
else
    error('Illegal Input arguments.')
end
L=[char(L),'=0'];
if nargout==1
    varargout{1}=L;
elseif nargout==2
    varargout{1}=L;varargout{2}=type;
else
    error('Illegal output arguments.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html