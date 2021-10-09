function fitness=CacuFit(path)
%% 该函数用于计算个体适应度值
%path       input     路径
%fitness    input     路径

[n,m]=size(path);
for i=1:n
    fitness(i)=0;
    for j=2:m/2
        %适应度值为长度加高度
        fitness(i)=fitness(i)+sqrt(1+(path(i,j*2-1)-path(i,(j-1)*2-1))^2 ...
            +(path(i,j*2)-path(i,(j-1)*2))^2)+abs(path(i,j*2));
    end
end