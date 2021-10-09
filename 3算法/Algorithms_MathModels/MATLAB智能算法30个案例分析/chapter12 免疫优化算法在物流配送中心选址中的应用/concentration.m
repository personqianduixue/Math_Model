function concentration = concentration(i,M,individuals)
% 计算个体浓度值
% i              input      第i个抗体
% M              input      种群规模
% individuals    input     个体
% concentration  output     浓度值

concentration=0;
for j=1:M
    xsd=similar(individuals.chrom(i,:),individuals.chrom(j,:));  % 第i个体与种群个体间的相似度
    % 相似度大于阀值
    if xsd>0.7
        concentration=concentration+1;
    end
end

concentration=concentration/M;

end