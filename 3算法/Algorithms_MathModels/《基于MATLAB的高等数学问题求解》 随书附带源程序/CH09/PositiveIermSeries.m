function [L,type]=PositiveIermSeries(un,mode)
%POSITIVEIERMSERIES   正项级数的比值审敛法和根值审敛法
% L=POSITIVEIERMSERIES(UN)  比值审敛法判断正项级数的敛散性
% L=POSITIVEIERMSERIES(UN,MODE)  选用指定的审敛法判断正项级数的敛散性
% [L,TYPE]=POSITIVEIERMSERIES(...)  选用指定的审敛法判断正项级数的敛散性
%                                   并返回所使用的审敛法
%
% 输入参数：
%     ---UN：正项级数通项
%     ---MODE：指定的审敛法，MODE有以下两个取值：
%              1.'d'或'比值'或1：比值审敛法
%              2.'k'或'根值'或2：根值审敛法
% 输出参数：
%     ---L：返回的通项的某种类型的极限值
%     ---TYPE：所使用的审敛法
%
% See also limit

if nargin==1
    mode=1;
end
n=sym('n','positive');
s=symvar(un);
if ~ismember(n,s)
    error('正项级数一般项的符号变量必须为n.')
end
switch lower(mode)
    case {1,'d','比值'}
        type='比值审敛法';
        uN=subs(un,'n',n+1);
        L=limit(simple(uN/un),'n',inf);
    case {2,'k','根值'}
        type='根值审敛法';
        L=limit(simple(un^(1/n)),'n',inf);
    otherwise
        error('Illegal options.')
end
if length(s)==1
    if double(L)<1
        type=[type,'：收敛'];
    elseif double(L)>1
        type=[type,'：发散'];
    else
        error('当前所选择的审敛法失效.')
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html