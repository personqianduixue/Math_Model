function rets=bestselect(individuals,m,n)
% 初始化记忆库,依据excellence，将群体中高适应度低相似度的overbest个个体存入记忆库
% m                  input          抗体数
% n                  input          记忆库个体数\父代群规模
% individuals        input          抗体群
% bestindividuals    output         记忆库\父代群

% 精英保留策略，将fitness最好的s个个体先存起来，避免因其浓度高而被淘汰
s=3;
rets=struct('fitness',zeros(1,n), 'concentration',zeros(1,n),'excellence',zeros(1,n),'chrom',[]);
[fitness,index] = sort(individuals.fitness);
for i=1:s
    rets.fitness(i) = individuals.fitness(index(i));   
    rets.concentration(i) = individuals.concentration(index(i));
    rets.excellence(i) = individuals.excellence(index(i));
    rets.chrom(i,:) = individuals.chrom(index(i),:);
end

% 剩余m-s个个体
leftindividuals=struct('fitness',zeros(1,m-s), 'concentration',zeros(1,m-s),'excellence',zeros(1,m-s),'chrom',[]);
for k=1:m-s
    leftindividuals.fitness(k) = individuals.fitness(index(k+s));   
    leftindividuals.concentration(k) = individuals.concentration(index(k+s));
    leftindividuals.excellence(k) = individuals.excellence(index(k+s));
    leftindividuals.chrom(k,:) = individuals.chrom(index(k+s),:);
end

% 将剩余抗体按excellence值排序
[excellence,index]=sort(1./leftindividuals.excellence);

% 在剩余抗体群中按excellence再选n-s个最好的个体
for i=s+1:n
    rets.fitness(i) = leftindividuals.fitness(index(i-s));
    rets.concentration(i) = leftindividuals.concentration(index(i-s));
    rets.excellence(i) = leftindividuals.excellence(index(i-s));
    rets.chrom(i,:) = leftindividuals.chrom(index(i-s),:);
end

end