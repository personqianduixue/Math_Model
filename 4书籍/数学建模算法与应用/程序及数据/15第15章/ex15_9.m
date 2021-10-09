clc, clear
M=600; N=420; p=200; q=2282;
eq=@(x) x^M-(1+q/p)*x^(M-N)+q/p
options=optimset('MaxFunEvals',10000,'MaxIter',1000);
x=fsolve(eq,1.2345,options) %初始值取为1.2345
