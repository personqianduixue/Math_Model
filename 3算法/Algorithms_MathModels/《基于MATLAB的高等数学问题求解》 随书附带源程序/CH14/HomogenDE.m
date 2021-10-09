function varargout=HomogenDE(fun,coef,t)
%HOMOGENDE   齐次或可化为齐次方程的求解
% L=HOMOGENDE(FUN,COEF)  求微分方程dY/dX=FUN((a*x+b*y+c)/(a1*x+b1*y+c1))的通解
% L=HOMOGENDE(FUN,COEF,T)  求可化为齐次方程的通解，并指定FUN的自变量为T
% [L,S]=L=HOMOGENDE(...)  求可化为齐次方程的通解并返回其解的字符串形式
%
% 输入参数：
%     ---FUN：关于(a*x+b*y+c)/(a1*x+b1*y+c1)的函数
%     ---COEF：系数矩阵[a,b,c;a1,b1,c1]
%     ---T：函数FUN的自变量
% 输出参数：
%     ---L：微分方程的通解
%     ---S：微分方程解的字符串表示
%
% See also SeparableVarsDE

if nargin==2
    t=symvar(fun);
end
if length(t)>1
    error('符号变量个数有误.')
end
syms x y
D=det(coef(:,1:2));
if D==0
    v=sym('v','real');
    L=coef(2,1)/coef(1,1);
    fun=subs(fun,t,(v+coef(1,3))/(L*v+coef(2,3)));
    I=SeparableVarsDE(sym(coef(1,2)),1/(fun+coef(1,1)/coef(1,2)),x,v);
    yy=subs(I,v,coef(1,1)*x+coef(1,2)*y);
else
    u=sym('u','real');
    X=sym('X','real');
    Y=sym('Y','real');
    x0=-coef(:,1:2)\coef(:,3);
    fun=subs(fun,t,(coef(1,1)+coef(1,2)*u)/(coef(2,1)+coef(2,2)*u));
    I=SeparableVarsDE(1/X,1/(fun-u),X,u);
    I=subs(I,u,Y/X);
    yy=subs(I,{X,Y},{x-x0(1),y-x0(2)});
end
varargout{1}=yy;
if nargout==2
    varargout{2}=['Solution:',char(yy)];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html