function [f wf No] = fofuf(C,f1)
% C表示弧上的容量
% f1表示弧上现在的流量
% f表示最大流
% wf表示最大流量
% No标号函数，由此可得到最小割
% 注：待求最大流的源为第一个顶点，汇为最后一个顶点

n = length(C);
if nargin == 1
    f = zeros(n,n);
else
    f = f1;
end
No = zeros(1,n);
d = zeros(1,n);
while(1)
    No(1) = n+1;
    d(1)=inf;
    while(1)
        pd = 1;
        for i = 1:n
            if(No(i))
                for j = 1:n
                    if No(j) == 0 && f(i,j) < C(i,j)
                        No(j)=i;
                        d(j) = C(i,j)-f(i,j);
                        pd = 0;
                        if d(j) > d(i)
                            d(j) = d(i);
                        end
                    elseif No(j)==0 && f(j,i)>0
                        No(j) = -i;d(j) = f(j,i);pd = 0;
                        if d(j) > d(i)
                            d(j)=d(i);
                        end
                    end
                end
            end
        end
        if (No(n) || pd)
            break;
        end
    end
    if pd
        break;
    end
    dvt = d(n);t = n;
    while(1)
        if No(t)>0
            f(No(t),t)=f(No(t),t)+dvt;
        elseif No(t) < 0
            f(No(t),t)=f(No(t),t)-dvt;
        end
        if No(t)==1
            for i = 1:n
                No(i)=0;
                d(i)=0;
            end
            break;
        end
        t = No(t);
    end 
end
wf = 0;
for j = 1:n
    wf = wf + f(1,j);
end
end

