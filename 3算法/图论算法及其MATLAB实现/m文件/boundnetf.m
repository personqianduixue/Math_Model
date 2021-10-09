function f=boundnetf(G1,G2)
% function f=boundnetf(G1,G2)
% 容量有上下界的可行流
% G1 弧的容量下界矩阵 G2弧的容量上界矩阵
% 调用2F求附加网络的最大流,调用fofuf.m
n=size(G2,1);
G=G2-G1;
%G(G~=0)=1;
x=zeros(1,n);
W=[0 x 0;
    x' G x';
    0 x 0]; % 增加新的顶点
% 增加新的边
for i=1:n
    W(i+1,n+2)=sum(G2(:,i))-sum(G1(:,i));
    W(1,i+1)=sum(G2(i,:))-sum(G1(i,:));
end
W(1,n+2)=inf;
W(n+2,1)=inf;
% 调用2F算法求附加网络的最大流
% [f1 wf]=Dinif2(W);
[f1 wf]=fofuf(W);
f=f1(2:(n+1),2:(n+1))+G1;