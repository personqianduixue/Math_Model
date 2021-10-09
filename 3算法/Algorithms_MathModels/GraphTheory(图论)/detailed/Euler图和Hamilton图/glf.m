function [C d1] = glf(d)
% d表示图的权值矩阵
% C表示算法最终找到的Hamilton圈

n = size(d,2);
C = [linspace(1,n,n) 1];
C1 = C;
if n > 3
    for v = 4:n+1
        for i = 1:(v-3)
            for j = (i+2):(v-1)
                if (d(C(i),C(j))+d(C(i+1),C(j+1))<d(C(i),C(i+1)) + d(C(j),C(j+1)) )
                    C1(1:i)=C(1:i);
                    for k = (i+1):j
                        C1(k)=C(j+i+1-k);
                    end
                    C1((j+1):v)=C((j+1):v);
            end
        end
    end
end
elseif n<=3
    if n<=2
        fprintf('It does not exist hamilton circle');
    else
        fprintf('Any circle is the right answer');
    end
end
C = C1;
d1 = 0;
for i =1:n
    d1=d1+d(C(i),C(i+1));
end
end

