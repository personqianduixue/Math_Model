function me=histogramofauto()
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%histogramofauto用于作元胞自动机模型时间分布直方图%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

p = experiNagal(1000,1370,1500);
for i=1:10000
p = [p,experiNagal(1000,1370,1500)];
end
hist(p,50);
xlabel('到达时间(s)');
ylabel('频数');
me=mean(p);
end