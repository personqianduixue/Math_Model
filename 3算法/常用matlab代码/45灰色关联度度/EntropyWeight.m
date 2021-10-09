function weights = EntropyWeight(R)
%% 熵权法求指标权重,R为输入矩阵,返回权重向量weights

[rows,cols]=size(R);   % 输入矩阵的大小,rows为对象个数，cols为指标个数
k=1/log(rows);         % 求k

f=zeros(rows,cols);    % 初始化fij
sumBycols=sum(R,1);    % 输入矩阵的每一列之和(结果为一个1*cols的行向量)
% 计算fij
for i=1:rows  
    for j=1:cols
        f(i,j)=R(i,j)./sumBycols(1,j);
    end
end

lnfij=zeros(rows,cols);  % 初始化lnfij
% 计算lnfij
for i=1:rows
    for j=1:cols
        if f(i,j)==0
            lnfij(i,j)=0;
        else
            lnfij(i,j)=log(f(i,j));
        end
    end
end

Hj=-k*(sum(f.*lnfij,1)); % 计算熵值Hj
weights=(1-Hj)/(cols-sum(Hj));
end