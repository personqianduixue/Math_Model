function dfdl=DirectionalDerivative(fun,vars,direction,M)
%DIRECTIONALDERIVATIVE   计算方向导数
% DFDL=DIRECTIONALDERIVATIVE(FUN,VARS,DIRECTION,M)  计算函数在点M上的方向导数
%
% 输入参数：
%     ---FUN：多元函数的符号表达式
%     ---VARS：符号自变量
%     ---DIRECTION：方向向量
%     ---M：指定点的坐标
% 输出参数：
%     ---DFDL：返回的方向导数
%
% See also Distance, dot

if ~isa(fun,'sym')
    error('FUN must be a Symbolic function.')
end
N=length(vars);
df=sym(zeros(1,N));
for k=1:N
    df(k)=subs(diff(fun,vars{k}),vars,num2cell(M));
end
C=Direction_Cosine(direction);
dfdl=dot(df,C);
web -broswer http://www.ilovematlab.cn/forum-221-1.html