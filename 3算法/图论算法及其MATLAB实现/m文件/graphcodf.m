function [k C W]=graphcodf(M)

% function [k C W]=graphcodf(M)
% 从图上的某个顶点染色，然后对其不相邻的顶点染色，再对其相关联的每条边进行染色，对其相关联的
% 边集合中的每条边的不相邻的边进行染色。重复以上过程。得到图的全染色方案。
% k为全染色数，C为图顶点的染色方案，W为图边集合的染色方案。
% 边的染色方案其实可以给出为一个矩阵
% M为任意图的邻接矩阵


% making matrix
G=M;
n=size(G,1);


W=G;
for i=1:n
    for j=1:(i-1)
        W(i,j)=0;
    end
end
C=zeros(1,n);
i=1;k=1;
Z=[1:n];
while sum(find(C==0))
% 对没有染色的顶点染色
    if C(1,i)==0
        C(1,i)=k;
        Sn=find(G(i,:)~=0);
        flag=1;
        while flag
           tc=setdiff(Z,Sn);
           if isempty(tc)
               flag=0;
           else
               c=G(tc(1),:);
               c(1,tc(1))=1;
               C(tc(1))=k;
               Sn1=find(c~=0);
               Sn=union(Sn,Sn1);
           end
        end
    end
% 对相应的边集合进行染色
for j=(i+1):n
    W1=W;
    if W(i,j)==1
        k=k+1;
           W(i,j)=k;
           W1(:,i)=0;W1(:,j)=0;
           W1(i,:)=0;W1(j,:)=0;
           m=0;
        while sum(sum(W1))~=0 & m==0
           c2=find(W1~=0);
           c3=find(W==1);
           c4=intersect(c2,c3);
           if ~isempty(c4)
               k1=floor(c4(1)/n);
               k2=mod(c4(1),n);
               if k2==0
                   k2=n;
               end
               W1(k2,:)=0;W1(:,k2)=0;
               W1((k1+1),:)=0;W1(:,(k1+1))=0;
               if k1+1<k2
                   W((k1+1),k2)=k;
               else
                   W(k2,(k1+1))=k;
               end
           else
               m=1;
           end
        end
    end
end
i=i+1;k=k+1;
end
k=k-1;m=0;
for i=1:k
    t1=find(C==i);
    t2=find(W==i);
    t3=sum(t1);
    t4=sum(sum(t2));
    t5=t3+t4;
    if t5~=0
        m=m+1;
    end
end
k=m;
