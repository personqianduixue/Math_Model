function X=bin2decFun(x,lenchrom,bound)
%% 二进制转化成十进制
% 输入      x：二进制编码
%    lenchrom：各变量的二进制位数
%       bound：各变量的范围
% 输出      X：十进制数
M=length(lenchrom);
n=1;
X=zeros(1,M);
for i=1:M
    for j=lenchrom(i)-1:-1:0
        X(i)=X(i)+x(n).*2.^j;
        n=n+1;
    end
end
X=bound(:,1)'+X./(2.^lenchrom-1).*(bound(:,2)-bound(:,1))'; 
