function y=logn(x,a)
%LOGN   求任意底的对数
% Y=LOGN(X,A)  求底数为A、真数为X的对数，将结果返回到Y中
%
% 输入参数：
%     ---X：对数的真数
%     ---A：对数的底数
% 输出参数：
%     ---Y：返回的对数值
%
% See also log, log2, log10

if ~isequal(class(x),class(a))
    error('LOGN requires input arguments be the same class.');
end
if ~(isa([x,a],'double')||isa([x,a],'single'))
    error('LOGN requires input arguments of double or single class.');
end
switch a
    case exp(1)
        y=log(x);  % 自然对数
    case 2
        y=log2(x);  % 以2为底的对数
    case 10
        y=log10(x);  % 常用对数
    otherwise
        y=log(x)/log(a);  % 换底公式，这里换底公式中b取为e
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html