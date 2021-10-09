%% GA算法求解旅行商问题
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
 %% 加载问题的数据
load('usborder.mat','x','y','xx','yy');

cities = 40;
locations = zeros(cities,2);
n = 1;
while (n <= cities)
    xp = rand*1.5;
    yp = rand;
    if inpolygon(xp,yp,xx,yy)
        locations(n,1) = xp;
        locations(n,2) = yp;
        n = n+1;
    end
end
plot(locations(:,1),locations(:,2),'bo');
xlabel('城市的横坐标x'); ylabel('城市的纵坐标y'); 
grid on

%% 计算城市距离

distances = zeros(cities);
for count1=1:cities
    for count2=1:count1
        x1 = locations(count1,1);
        y1 = locations(count1,2);
        x2 = locations(count2,1);
        y2 = locations(count2,2);
        distances(count1,count2)=sqrt((x1-x2)^2+(y1-y2)^2);
        distances(count2,count1)=distances(count1,count2);
    end
end


%% 定义目标函数
FitnessFcn = @(x) traveling_salesman_fitness(x,distances);

my_plot = @(options,state,flag) traveling_salesman_plot(options, ...
    state,flag,locations);

%% 设置优化属性并执行遗传算法求解

options = optimoptions(@ga, 'PopulationType', 'custom','InitialPopulationRange', ...
                            [1;cities]);

options = optimoptions(options,'CreationFcn',@create_permutations, ...
                        'CrossoverFcn',@crossover_permutation, ...
                        'MutationFcn',@mutate_permutation, ...
                        'PlotFcn', my_plot, ...
                        'MaxGenerations',500,'PopulationSize',60, ...
                        'MaxStallGenerations',200,'UseVectorized',true);

numberOfVariables = cities;
[x,fval,reason,output] = ...
    ga(FitnessFcn,numberOfVariables,[],[],[],[],[],[],[],options);

