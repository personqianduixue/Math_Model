function [Path f] = efpathf(W,C,k1,k2)
%最大期望容量路的算法
WW=W;
CC=C;
f1=1;
f=0;
k=1;
while f1==1 && k<10
    [pw pt f1]=p_pathf(WW,k1,k2);
    if f1==1
        c1=inf;
%         找到最小容量
        for i = 1:(length(pw)-1)
            c2=CC(pw(i),pw(i+1));
            if c1>c2
                c1=c2;
            end
        end
%         计算路的期望容量
        ft=c1*pt;
        
        CC(CC>c1)=0;
        WW(CC>c1)=0;
        if ft > f
            f=ft;
            Path=pw;
        end
        k=k+1;
    end
end


end

