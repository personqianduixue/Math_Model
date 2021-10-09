%% 离散Hopfield的分类——高校科研能力评价

%% 清空环境变量
clear all
clc

%% 导入数据
load class.mat

%% 目标向量
T = [class_1 class_2 class_3 class_4 class_5];

%% 创建网络
net = newhop(T);

%% 导入待分类样本
load sim.mat
A = {[sim_1 sim_2 sim_3 sim_4 sim_5]};

%% 网络仿真
Y = sim(net,{25 20},{},A);

%% 结果显示
Y1 = Y{20}(:,1:5)
Y2 = Y{20}(:,6:10)
Y3 = Y{20}(:,11:15)
Y4 = Y{20}(:,16:20)
Y5 = Y{20}(:,21:25)

%% 绘图
result = {T;A{1};Y{20}};
figure
for p = 1:3
    for k = 1:5 
        subplot(3,5,(p-1)*5+k)
        temp = result{p}(:,(k-1)*5+1:k*5);
        [m,n] = size(temp);
        for i = 1:m
            for j = 1:n
                if temp(i,j) > 0
                   plot(j,m-i,'ko','MarkerFaceColor','k');
                else
                   plot(j,m-i,'ko');
                end
                hold on
            end
        end
        axis([0 6 0 12])
        axis off
        if p == 1
           title(['class' num2str(k)])
        elseif p == 2
           title(['pre-sim' num2str(k)])
        else
           title(['sim' num2str(k)])
        end
    end                
end

% 案例扩展(无法分辨情况)
noisy = [1 -1 -1 -1 -1;-1 -1 -1 1 -1;
        -1 1 -1 -1 -1;-1 1 -1 -1 -1;
        1 -1 -1 -1 -1;-1 -1 1 -1 -1;
        -1 -1 -1 1 -1;-1 -1 -1 -1 1;
        -1 1 -1 -1 -1;-1 -1 -1 1 -1;
        -1 -1 1 -1 -1];
y = sim(net,{5 100},{},{noisy});
a = y{100}

