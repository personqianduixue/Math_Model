%% 免疫优化算法在物流配送中心选址中的应用
%% 清空环境
clc
clear

%% 算法基本参数           
sizepop=50;           % 种群规模
overbest=10;          % 记忆库容量
MAXGEN=100;            % 迭代次数
pcross=0.5;           % 交叉概率
pmutation=0.4;        % 变异概率
ps=0.95;              % 多样性评价参数
length=6;             % 配送中心数
M=sizepop+overbest;

%% step1 识别抗原,将种群信息定义为一个结构体
individuals = struct('fitness',zeros(1,M), 'concentration',zeros(1,M),'excellence',zeros(1,M),'chrom',[]);
%% step2 产生初始抗体群
individuals.chrom = popinit(M,length);
trace=[]; %记录每代最个体优适应度和平均适应度

%% 迭代寻优
for iii=1:MAXGEN

     %% step3 抗体群多样性评价
     for i=1:M
         individuals.fitness(i) = fitness(individuals.chrom(i,:));      % 抗体与抗原亲和度(适应度值）计算
         individuals.concentration(i) = concentration(i,M,individuals); % 抗体浓度计算
     end
     % 综合亲和度和浓度评价抗体优秀程度，得出繁殖概率
     individuals.excellence = excellence(individuals,M,ps);
          
     % 记录当代最佳个体和种群平均适应度
     [best,index] = min(individuals.fitness);   % 找出最优适应度 
     bestchrom = individuals.chrom(index,:);    % 找出最优个体
     average = mean(individuals.fitness);       % 计算平均适应度
     trace = [trace;best,average];              % 记录
     
     %% step4 根据excellence，形成父代群，更新记忆库（加入精英保留策略，可由s控制）
     bestindividuals = bestselect(individuals,M,overbest);   % 更新记忆库
     individuals = bestselect(individuals,M,sizepop);        % 形成父代群

     %% step5 选择，交叉，变异操作，再加入记忆库中抗体，产生新种群
     individuals = Select(individuals,sizepop);                                                             % 选择
     individuals.chrom = Cross(pcross,individuals.chrom,sizepop,length);                                    % 交叉
     individuals.chrom = Mutation(pmutation,individuals.chrom,sizepop,length);   % 变异
     individuals = incorporate(individuals,sizepop,bestindividuals,overbest);                               % 加入记忆库中抗体      

end

%% 画出免疫算法收敛曲线
figure(1)
plot(trace(:,1));
hold on
plot(trace(:,2),'--');
legend('最优适应度值','平均适应度值')
title('免疫算法收敛曲线','fontsize',12)
xlabel('迭代次数','fontsize',12)
ylabel('适应度值','fontsize',12)

%% 画出配送中心选址图
%城市坐标
city_coordinate=[1304,2312;3639,1315;4177,2244;3712,1399;3488,1535;3326,1556;3238,1229;4196,1044;4312,790;4386,570;
                 3007,1970;2562,1756;2788,1491;2381,1676;1332,695;3715,1678;3918,2179;4061,2370;3780,2212;3676,2578;
                 4029,2838;4263,2931;3429,1908;3507,2376;3394,2643;3439,3201;2935,3240;3140,3550;2545,2357;2778,2826;2370,2975];
carge=[20,90,90,60,70,70,40,90,90,70,60,40,40,40,20,80,90,70,100,50,50,50,80,70,80,40,40,60,70,50,30];
%找出最近配送点
for i=1:31
    distance(i,:)=dist(city_coordinate(i,:),city_coordinate(bestchrom,:)');
end
[a,b]=min(distance');

index=cell(1,length);

for i=1:length
%计算各个派送点的地址
index{i}=find(b==i);
end
figure(2)
title('最优规划派送路线')
cargox=city_coordinate(bestchrom,1);
cargoy=city_coordinate(bestchrom,2);
plot(cargox,cargoy,'rs','LineWidth',2,...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','b',...
    'MarkerSize',20)
hold on

plot(city_coordinate(:,1),city_coordinate(:,2),'o','LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',10)

for i=1:31
    x=[city_coordinate(i,1),city_coordinate(bestchrom(b(i)),1)];
    y=[city_coordinate(i,2),city_coordinate(bestchrom(b(i)),2)];
    plot(x,y,'c');hold on
end

