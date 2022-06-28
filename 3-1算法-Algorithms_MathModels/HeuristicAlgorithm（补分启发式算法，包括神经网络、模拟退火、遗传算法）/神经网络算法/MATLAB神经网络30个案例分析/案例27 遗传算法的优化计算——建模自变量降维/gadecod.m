function[W1,B1,W2,B2,val]=gadecod(x)
global p t r s1 s2
W1=zeros(s1,r);
W2=zeros(s2,s1);
B1=zeros(s1,1);
B2=zeros(s2,1);
% 前r*s1个编码为W1
for i=1:s1
    for k=1:r
        W1(i,k)=x(r*(i-1)+k);
    end
end
% 接着的s1*s2个编码(即第r*s1个后的编码)为W2
for i=1:s2
    for k=1:s1
        W2(i,k)=x(s1*(i-1)+k+r*s1);
    end
end
% 接着的s1个编码(即第r*s1+s1*s2个后的编码)为B1
for i=1:s1
    B1(i,1)=x((r*s1+s1*s2)+i);
end
% 接着的s2个编码(即第r*s1+s1*s2+s1个后的编码)为B2
for i=1:s2
    B2(i,1)=x((r*s1+s1*s2+s1)+i);
end
% 计算S1与S2层的输出
A1=tansig(W1*p,B1);
A2=purelin(W2*A1,B2);
% 计算误差平方和
SE=sumsqr(t-A2);
% 遗传算法的适应值
val=1/SE;