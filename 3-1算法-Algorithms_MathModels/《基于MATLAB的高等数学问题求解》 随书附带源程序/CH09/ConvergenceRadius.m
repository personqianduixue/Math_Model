function [R,D]=ConvergenceRadius(an)
%CONVERGENCERADIUS   幂级数的收敛半径与收敛域
% R=CONVERGENCERADIUS(AN)  求幂级数AN的收敛半径
% [R,D]=CONVERGENCERADIUS(AN)  求幂级数AN的收敛半径和收敛域
%
% 输入参数：
%     ---AN：幂级数一般项
% 输出参数：
%     ---R：收敛半径
%     ---D：收敛域
%
% See also limit

n=sym('n','positive');
s=symvar(an);
if ~ismember(n,s)
    error('幂级数系数的符号变量必须为n.')
end
aN=subs(an,n,n+1);
rho=limit(simple(abs(aN/an)),n,inf);
R=1/rho;
if R==0
    D=0;
elseif isinf(double(R))
    D='(-∞,+∞)';
else
    D=[-R,R];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html