function [Q,P]=jqryd(A,B)%%%%加权冗余度计算，A表示renyiryd计算出来的结果，B表示rl计算出来后排序的dd,P表示加权冗余总数,Q 第二列是加权冗余度
[m,n]=size(B);
for i=1:m
    b=B(i,1);
    r=min(A(A(:,2)==b,4));
    Q(i,2)=B(i,3)*r;
    Q(i,1)=b;
    Q(i,3)=r;
    Q(i,4)=B(i,3);
end
   Q=sortrows(Q,2);
    P=sum(Q(:,2));