function resemble = similar(individual1,individual2)
% 计算个体individual1和individual2的相似度
% individual1,individual2    input     两个个体
% resemble                   output     相似度

k=zeros(1,length(individual1));
for i=1:length(individual1)
    if find(individual1(i)==individual2)
        k(i)=1;
    end
end

resemble=sum(k)/length(individual1);

end