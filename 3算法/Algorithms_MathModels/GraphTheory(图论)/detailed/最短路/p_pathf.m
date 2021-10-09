function [ Path P f ] = p_pathf(A,k1,k2)
%求最大可靠路的算法
% Path表示路径,P是概率的极大值，f=1表示找到路，f=0表示没有路

[m n] = size(A);
f = 1;
B = zeros(m,n);

% 对原矩阵进行转换
for i =1:m
    for j = 1:n
        if A(i,j) > 0 && A(i,j) < 1
            B(i,j) = -log(A(i,j));
        elseif A(i,j)==0
            B(i,j)=inf;
        end
    end
end

%  利用Floyd算法求最短路
[Path d]=n2shortf(B,k1,k2);
if d < inf
    P=1;
    for i=1:(length(Path)-1)
        P=P*A(Path(i),Path(i+1));
    end
else
    Path = 0;
    P=0;
    f=0;
end



end

