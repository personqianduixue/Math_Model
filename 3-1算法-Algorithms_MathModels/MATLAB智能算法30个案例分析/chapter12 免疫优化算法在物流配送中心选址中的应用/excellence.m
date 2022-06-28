function exc=excellence(individuals,M,ps)
% 计算个体繁殖概率
% individuals    input      种群
% M              input      种群规模
% ps             input      多样性评价参数
% exc            output     繁殖概率

fit = 1./individuals.fitness;
sumfit = sum(fit);
con = individuals.concentration;
sumcon = sum(con);
for i=1:M
    exc(i) = fit(i)/sumfit*ps +con(i)/sumcon*(1-ps); 
end

end