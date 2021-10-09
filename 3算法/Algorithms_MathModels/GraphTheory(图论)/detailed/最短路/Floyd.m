function [ U ] = Floyd( W )
%Floyd算法，返回最短距离矩阵
% W是权值矩阵
m = 1;
n = length(W);
U  = W;
while m<=n
    for i = 1:n
        for j=1:n
            if U(i,j) > U(i,m)+U(m,j)
                U(i,j) = U(i,m)+U(m,j);
            end
        end
    end
    m=m+1;
end


end

