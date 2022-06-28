function [L,type]=LimitSeries(un,p)
%LIMITSERIES   正项级数的极限审敛法
% L=LIMITSERIES(UN)  极限审敛法判断正项级数UN的敛散性，p-级数中p取1
% L=LIMITSERIES(UN,P)  极限审敛法判断正项级数UN的敛散性，P>1
% [L,TYPE]=LIMITSERIES(...)  极限审敛法判断正项级数UN的敛散性，并返回级数的敛散性字符串
%
% 输入参数：
%     ---UN：正项级数
%     ---P：p级数的阶次
% 输出参数：
%     ---L：极限值
%     ---TYPE：表征级数敛散性的字符串
%
% See also limit

if nargin==1
    p=1;
end
if p<1
    error('等比级数的幂指数p必须大于等于1.')
end
n=sym('n','positive');
s=symvar(un);
if ~ismember(n,s)
    error('正项级数一般项的符号变量必须为n.')
end
L=limit(n^p*un,n,inf);
if p==1
    if length(s)==1
        if double(L)>0
            type='发散';
        end
    end
else
    if double(L)>=0
        type='收敛';
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html