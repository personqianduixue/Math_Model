function [T c]=Primf(a)
% 求最小生成树的Prim算法
% function [T c]=Primf(a)
%  a：边权矩阵。
%  c:生成树的费用;
%  T:生成树的边集合;

l=length(a);
a(a==0)=inf;
k=1:l;
listV(k)=0;
listV(1)=1;
e=1;
while (e<l)
    min=inf;
    for i=1:l
        if listV(i)==1
            for j=1:l
                if listV(j)==0 & min>a(i,j)
                        min=a(i,j);b=a(i,j);
                        s=i;d=j;
                end
            end
        end
    end
    listV(d)=1;
    distance(e)=b;
    source(e)=s;
    destination(e)=d;
    e=e+1;
end

T=[source;destination];
for g=1:e-1
    c(g)=a(T(1,g),T(2,g));
end
c;
%=====================otherway
%D=[inf 7 8 2 inf inf 3 inf;
%    7 inf 1 inf 2 inf inf 3;
%    8 1 inf 4 2 7 inf inf;
%    2 inf 4 inf inf 4 6 inf;
%    inf 2 2 inf inf 5 inf 1;
%    inf inf 7 4 5 inf 4 3;
%    3 inf inf 6 inf 4 inf 6;
%    inf 3 inf inf 1 3 6 inf];
%n=8;
%  function [T c]=Primf1(D)
% n=length(D);
% T=[];l=0;%l记录T的列数
% q(1)=-1;
%for i=2:n
%    p(i)=1;q(i)=D(i,1);
%end
%k=1;
%while 1
%    if k>=n
%       % disp(T);
%        break;
%    else
%        min=inf;
%        for i=2:n
%            if q(i)>0&q(i)<min
%                min=q(i);
%                h=i;
%            end
%        end
%    end
%    l=l+1;
%    T(1,l)=h;T(2,l)=p(h);
%    q(h)=-1;
%    for j=2:n
%        if D(h,j)<q(j)
%            q(j)=D(h,j);
%            p(j)=h;
%        end
%    end
%    k=k+1;
%end
%T;
%for g=1:n-1
%    c(g)=a(T(1,g),T(2,g));
%end
%c;