%% 思维进化算法应用于优化BP神经网络的初始权值和阈值

%% 清空环境变量
clear all
clc
warning off

%% 导入数据
load data.mat
% 随机生成训练集、测试集
k = randperm(size(input,1));
N = 1900;
% 训练集——1900个样本
P_train=input(k(1:N),:)';
T_train=output(k(1:N));
% 测试集——100个样本
P_test=input(k(N+1:end),:)';
T_test=output(k(N+1:end));

%% 归一化
% 训练集
[Pn_train,inputps] = mapminmax(P_train);
Pn_test = mapminmax('apply',P_test,inputps);
% 测试集
[Tn_train,outputps] = mapminmax(T_train);
Tn_test = mapminmax('apply',T_test,outputps);

%% 参数设置
popsize = 200;                      % 种群大小
bestsize = 5;                       % 优胜子种群个数
tempsize = 5;                       % 临时子种群个数
SG = popsize / (bestsize+tempsize); % 子群体大小
S1 = size(Pn_train,1);              % 输入层神经元个数
S2 = 5;                            % 隐含层神经元个数
S3 = size(Tn_train,1);              % 输出层神经元个数
iter = 10;                          % 迭代次数

%% 随机产生初始种群
initpop = initpop_generate(popsize,S1,S2,S3,Pn_train,Tn_train);

%% 产生优胜子群体和临时子群体
% 得分排序
[sort_val,index_val] = sort(initpop(:,end),'descend');
% 产生优胜子种群和临时子种群的中心
bestcenter = initpop(index_val(1:bestsize),:);
tempcenter = initpop(index_val(bestsize+1:bestsize+tempsize),:);
% 产生优胜子种群
bestpop = cell(bestsize,1);
for i = 1:bestsize
    center = bestcenter(i,:);
    bestpop{i} = subpop_generate(center,SG,S1,S2,S3,Pn_train,Tn_train);
end
% 产生临时子种群
temppop = cell(tempsize,1);
for i = 1:tempsize
    center = tempcenter(i,:);
    temppop{i} = subpop_generate(center,SG,S1,S2,S3,Pn_train,Tn_train);
end

while iter > 0
    %% 优胜子群体趋同操作并计算各子群体得分
    best_score = zeros(1,bestsize);
    best_mature = cell(bestsize,1);
    for i = 1:bestsize
        best_mature{i} = bestpop{i}(1,:);
        best_flag = 0;                % 优胜子群体成熟标志(1表示成熟，0表示未成熟)
        while best_flag == 0
            % 判断优胜子群体是否成熟
            [best_flag,best_index] = ismature(bestpop{i});
            % 若优胜子群体尚未成熟，则以新的中心产生子种群
            if best_flag == 0
                best_newcenter = bestpop{i}(best_index,:);
                best_mature{i} = [best_mature{i};best_newcenter];
                bestpop{i} = subpop_generate(best_newcenter,SG,S1,S2,S3,Pn_train,Tn_train);
            end
        end
        % 计算成熟优胜子群体的得分
        best_score(i) = max(bestpop{i}(:,end));
    end
    % 绘图(优胜子群体趋同过程)
    figure
    temp_x = 1:length(best_mature{1}(:,end))+5;
    temp_y = [best_mature{1}(:,end);repmat(best_mature{1}(end),5,1)];
    plot(temp_x,temp_y,'b-o')
    hold on
    temp_x = 1:length(best_mature{2}(:,end))+5;
    temp_y = [best_mature{2}(:,end);repmat(best_mature{2}(end),5,1)];
    plot(temp_x,temp_y,'r-^')
    hold on
    temp_x = 1:length(best_mature{3}(:,end))+5;
    temp_y = [best_mature{3}(:,end);repmat(best_mature{3}(end),5,1)];
    plot(temp_x,temp_y,'k-s')
    hold on
    temp_x = 1:length(best_mature{4}(:,end))+5;
    temp_y = [best_mature{4}(:,end);repmat(best_mature{4}(end),5,1)];
    plot(temp_x,temp_y,'g-d')
    hold on
    temp_x = 1:length(best_mature{5}(:,end))+5;
    temp_y = [best_mature{5}(:,end);repmat(best_mature{5}(end),5,1)];
    plot(temp_x,temp_y,'m-*')
    legend('子种群1','子种群2','子种群3','子种群4','子种群5')
    xlim([1 10])
    xlabel('趋同次数')
    ylabel('得分')
    title('优胜子种群趋同过程')
    
    %% 临时子群体趋同操作并计算各子群体得分
    temp_score = zeros(1,tempsize);
    temp_mature = cell(tempsize,1);
    for i = 1:tempsize
        temp_mature{i} = temppop{i}(1,:);
        temp_flag = 0;                % 临时子群体成熟标志(1表示成熟，0表示未成熟)
        while temp_flag == 0
            % 判断临时子群体是否成熟
            [temp_flag,temp_index] = ismature(temppop{i});
            % 若临时子群体尚未成熟，则以新的中心产生子种群
            if temp_flag == 0
                temp_newcenter = temppop{i}(temp_index,:);
                temp_mature{i} = [temp_mature{i};temp_newcenter];
                temppop{i} = subpop_generate(temp_newcenter,SG,S1,S2,S3,Pn_train,Tn_train);
            end
        end
        % 计算成熟临时子群体的得分
        temp_score(i) = max(temppop{i}(:,end));
    end
     % 绘图(临时子群体趋同过程)
    figure
    temp_x = 1:length(temp_mature{1}(:,end))+5;
    temp_y = [temp_mature{1}(:,end);repmat(temp_mature{1}(end),5,1)];
    plot(temp_x,temp_y,'b-o')
    hold on
    temp_x = 1:length(temp_mature{2}(:,end))+5;
    temp_y = [temp_mature{2}(:,end);repmat(temp_mature{2}(end),5,1)];
    plot(temp_x,temp_y,'r-^')
    hold on
    temp_x = 1:length(temp_mature{3}(:,end))+5;
    temp_y = [temp_mature{3}(:,end);repmat(temp_mature{3}(end),5,1)];
    plot(temp_x,temp_y,'k-s')
    hold on
    temp_x = 1:length(temp_mature{4}(:,end))+5;
    temp_y = [temp_mature{4}(:,end);repmat(temp_mature{4}(end),5,1)];
    plot(temp_x,temp_y,'g-d')
    hold on
    temp_x = 1:length(temp_mature{5}(:,end))+5;
    temp_y = [temp_mature{5}(:,end);repmat(temp_mature{5}(end),5,1)];
    plot(temp_x,temp_y,'m-*')
    legend('子种群1','子种群2','子种群3','子种群4','子种群5')
    xlim([1 10])
    xlabel('趋同次数')
    ylabel('得分')
    title('临时子种群趋同过程')
    
    %% 异化操作
    [score_all,index] = sort([best_score temp_score],'descend');
    % 寻找临时子群体得分高于优胜子群体的编号
    rep_temp = index(find(index(1:bestsize) > bestsize)) - bestsize;
    % 寻找优胜子群体得分低于临时子群体的编号
    rep_best = index(find(index(bestsize+1:end) < bestsize+1) + bestsize);
    
    % 若满足替换条件
    if ~isempty(rep_temp)
        % 得分高的临时子群体替换优胜子群体
        for i = 1:length(rep_best)
            bestpop{rep_best(i)} = temppop{rep_temp(i)};
        end
        % 补充临时子群体，以保证临时子群体的个数不变
        for i = 1:length(rep_temp)
            temppop{rep_temp(i)} = initpop_generate(SG,S1,S2,S3,Pn_train,Tn_train);
        end
    else
        break;
    end
    
    %% 输出当前迭代获得的最佳个体及其得分
    if index(1) < 6
        best_individual = bestpop{index(1)}(1,:);
    else
        best_individual = temppop{index(1) - 5}(1,:);
    end

    iter = iter - 1;
    
end

%% 解码最优个体
x = best_individual;

% 前S1*S2个编码为W1
temp = x(1:S1*S2);
W1 = reshape(temp,S2,S1);

% 接着的S2*S3个编码为W2
temp = x(S1*S2+1:S1*S2+S2*S3);
W2 = reshape(temp,S3,S2);

% 接着的S2个编码为B1
temp = x(S1*S2+S2*S3+1:S1*S2+S2*S3+S2);
B1 = reshape(temp,S2,1);

%接着的S3个编码B2
temp = x(S1*S2+S2*S3+S2+1:end-1);
B2 = reshape(temp,S3,1);

% E_optimized = zeros(1,100);
% for i = 1:100
%% 创建/训练BP神经网络
net_optimized = newff(Pn_train,Tn_train,S2);
% 设置训练参数
net_optimized.trainParam.epochs = 100;
net_optimized.trainParam.show = 10;
net_optimized.trainParam.goal = 1e-4;
net_optimized.trainParam.lr = 0.1;
% 设置网络初始权值和阈值
net_optimized.IW{1,1} = W1;
net_optimized.LW{2,1} = W2;
net_optimized.b{1} = B1;
net_optimized.b{2} = B2;
% 利用新的权值和阈值进行训练
net_optimized = train(net_optimized,Pn_train,Tn_train);

%% 仿真测试
Tn_sim_optimized = sim(net_optimized,Pn_test);     
% 反归一化
T_sim_optimized = mapminmax('reverse',Tn_sim_optimized,outputps);

%% 结果对比
result_optimized = [T_test' T_sim_optimized'];
% 均方误差
E_optimized = mse(T_sim_optimized - T_test)
% end
%% 未优化的BP神经网络
% E = zeros(1,100);
% for i = 1:100
net = newff(Pn_train,Tn_train,S2);
% 设置训练参数
net.trainParam.epochs = 100;
net.trainParam.show = 10;
net.trainParam.goal = 1e-4;
net.trainParam.lr = 0.1;
% 利用新的权值和阈值进行训练
net = train(net,Pn_train,Tn_train);

%% 仿真测试
Tn_sim = sim(net,Pn_test);    
% 反归一化
T_sim = mapminmax('reverse',Tn_sim,outputps);

%% 结果对比
result = [T_test' T_sim'];
% 均方误差
E = mse(T_sim - T_test)

% end

