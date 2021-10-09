function type=AlternatingSeries(un)
%ALTERNATINGSERIES   交错级数审敛法
% TYPE=ALTERNATINGSERIES(UN)  利用莱布尼茨定理判断交错级数(-1)^(N-1)*UN的敛散性
%
% 输入参数：
%     ---UN：正项级数
% 输出参数：
%     ---TYPE：表征级数敛散性的字符串
%
% See also limit

n=sym('n','positive');
s=symvar(un);
if ~ismember(n,s)
    error('正项级数一般项的符号变量必须为n.')
end
uN=subs(un,n,n+1);
x=subs(un-uN,n,1:1e6);
L=limit(un,n,inf);
if L==0 && all(x>=0)
    type='收敛';
elseif L~=0
    type='发散';
else
    type='不确定';
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html