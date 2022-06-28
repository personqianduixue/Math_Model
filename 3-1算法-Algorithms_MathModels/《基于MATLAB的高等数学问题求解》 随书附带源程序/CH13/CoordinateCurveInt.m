function I=CoordinateCurveInt(fun,vars,fun_para,t,alpha,beta)
%COORDINATECURVEINT   计算第二类曲线积分
% I=COORDINATECURVEINT(FUN,VARS,FUN_PARA,T,ALPHA,BETA)  计算函数FUN的第二类曲线积分
%
% 输入参数：
%     ---FUN：被积函数向量
%     ---VARS：符号变量
%     ---FUN_PARA：积分曲线的参数方程的符号表达式
%     ---T：参数方程的符号自变量
%     ---ALPHA,BETA：积分区间
% 输出参数：
%     ---I：第二类曲线积分值
%
% See also diff, int

N=length(fun);
S=0;
for k=1:N
    df=diff(fun_para(k),t);
    S=S+subs(fun(k),vars,num2cell(fun_para))*df;
end
I=int(S,t);
I=subs(I,t,sym(beta))-subs(I,t,sym(alpha));
web -broswer http://www.ilovematlab.cn/forum-221-1.html