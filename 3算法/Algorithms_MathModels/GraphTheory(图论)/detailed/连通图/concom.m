function [S Q] = concom1(G)
% 计算图的连通性，求出元图
n=length(G);
Q=zeros(n,1);
C=1;S=0;
[x y]=find(G==1);
m=length(x);
for i = 1:m
    if Q(x(i))==Q(y(i))
        if Q(x(i))==0
            Q(x(i))=C;Q(y(i))=C;
            C=C+1;S=S+1;
        end
    else
        if Q(x(i))==0
            Q(x(i))=Q(y(i));
        elseif Q(y(i)==0)
            Q(y(i))=Q(x(i));
        else
            tb= Q==Q(x(i));
            Q(tb)=Q(y(i));
            S=S-1;
        end
    end 
end
end