%% 聚类方法
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
%% 导入数据和预处理数据
clc, clear all, close all
load BondData
settle = floor(date);
%数据预处理
bondData.MaturityN = datenum(bondData.Maturity, 'dd-mmm-yyyy');
bondData.SettleN = settle * ones(height(bondData),1);
% 筛选数据
corp = bondData(bondData.MaturityN > settle & ...
             bondData.Type == 'Corp' & ...
             bondData.Rating >= 'CC' & ...
             bondData.YTM < 30 & ...
             bondData.YTM >= 0, :);
% 设置随机数生成方式保证结果可重现
rng('default');

%% 探索数据
% 数据可视化
figure
gscatter(corp.Coupon,corp.YTM,corp.Rating)
set(gca,'linewidth',2);
xlabel('票面利率')
ylabel('到期收益率')

% 选择聚类变量
corp.RatingNum = double(corp.Rating);
bonds = corp{:,{'Coupon','YTM','CurrentYield','RatingNum'}};

% 设置类别数量
numClust = 3;

% 设置用于可视化聚类效果的变量
VX=[corp.Coupon, double(corp.Rating), corp.YTM];

%% K-Means 聚类
dist_k = 'cosine';
kidx = kmeans(bonds, numClust, 'distance', dist_k);

%绘制聚类效果图
figure
F1 = plot3(VX(kidx==1,1), VX(kidx==1,2),VX(kidx==1,3),'r*', ...
           VX(kidx==2,1), VX(kidx==2,2),VX(kidx==2,3), 'bo', ...
           VX(kidx==3,1), VX(kidx==3,2),VX(kidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on;
set(F1,'linewidth',2, 'MarkerSize',8);
xlabel('票面利率','fontsize',12);
ylabel('评级得分','fontsize',12);
ylabel('到期收益率','fontsize',12);
title('Kmeans方法聚类结果')

% 评估各类别的相关程度
dist_metric_k = pdist(bonds,dist_k);
dd_k = squareform(dist_metric_k);
[~,idx] = sort(kidx);
dd_k = dd_k(idx,idx);
figure
imagesc(dd_k)
set(gca,'linewidth',2);
xlabel('数据点','fontsize',12)
ylabel('数据点', 'fontsize',12)
title('k-Means聚类结果相关程度图', 'fontsize',12)
ylabel(colorbar,['距离矩阵:', dist_k])
axis square

%% 层次聚类
dist_h = 'spearman';
link = 'weighted';
hidx = clusterdata(bonds, 'maxclust', numClust, 'distance' , dist_h, 'linkage', link);

%绘制聚类效果图
figure
F2 = plot3(VX(hidx==1,1), VX(hidx==1,2),VX(hidx==1,3),'r*', ...
           VX(hidx==2,1), VX(hidx==2,2),VX(hidx==2,3), 'bo', ...
           VX(hidx==3,1), VX(hidx==3,2),VX(hidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F2,'linewidth',2, 'MarkerSize',8);
set(gca,'linewidth',2);
xlabel('票面利率','fontsize',12);
ylabel('评级得分','fontsize',12);
ylabel('到期收益率','fontsize',12);
title('层次聚类方法聚类结果')

% 评估各类别的相关程度
dist_metric_h = pdist(bonds,dist_h);
dd_h = squareform(dist_metric_h);
[~,idx] = sort(hidx);
dd_h = dd_h(idx,idx);
figure
imagesc(dd_h)
set(gca,'linewidth',2);
xlabel('数据点', 'fontsize',12)
ylabel('数据点', 'fontsize',12)
title('层次聚类结果相关程度图')
ylabel(colorbar,['距离矩阵:', dist_h])
axis square

% 计算同型相关系数
Z = linkage(dist_metric_h,link);
cpcc = cophenet(Z,dist_metric_h);
disp('同型相关系数: ')
disp(cpcc)

% 层次结构图
set(0,'RecursionLimit',5000)
figure
dendrogram(Z)
set(gca,'linewidth',2);
set(0,'RecursionLimit',500)
xlabel('数据点', 'fontsize',12)
ylabel ('标准距离', 'fontsize',12)
 title('层次聚类法层次结构图')

%% 神经网络
%设置网络
dimension1 = 3;
dimension2 = 1;
net = selforgmap([dimension1 dimension2]);
net.trainParam.showWindow = 0;

%训练网络
[net,tr] = train(net,bonds');
nidx = net(bonds');
nidx = vec2ind(nidx)';

%绘制聚类效果图
figure
F3 = plot3(VX(nidx==1,1), VX(nidx==1,2),VX(nidx==1,3),'r*', ...
           VX(nidx==2,1), VX(nidx==2,2),VX(nidx==2,3), 'bo', ...
           VX(nidx==3,1), VX(nidx==3,2),VX(nidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F3,'linewidth',2, 'MarkerSize',8);
xlabel('票面利率','fontsize',12);
ylabel('评级得分','fontsize',12);
ylabel('到期收益率','fontsize',12);
title('神经网络方法聚类结果')

%% 模糊C-Means聚类
options = nan(4,1);
options(4) = 0;
[centres,U] = fcm(bonds,numClust, options);
[~, fidx] = max(U);
fidx = fidx';

%绘制聚类效果图
figure
F4 = plot3(VX(fidx==1,1), VX(fidx==1,2),VX(fidx==1,3),'r*', ...
           VX(fidx==2,1), VX(fidx==2,2),VX(fidx==2,3), 'bo', ...
           VX(fidx==3,1), VX(fidx==3,2),VX(fidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F4,'linewidth',2, 'MarkerSize',8);
xlabel('票面利率','fontsize',12);
ylabel('评级得分','fontsize',12);
ylabel('到期收益率','fontsize',12);
title('模糊C-Means方法聚类结果')

%% 高斯混合聚类 (GMM)
gmobj = gmdistribution.fit(bonds,numClust);
gidx = cluster(gmobj,bonds);

%绘制聚类效果图
figure
F5 = plot3(VX(fidx==1,1), VX(fidx==1,2),VX(fidx==1,3),'r*', ...
           VX(fidx==2,1), VX(fidx==2,2),VX(fidx==2,3), 'bo', ...
           VX(fidx==3,1), VX(fidx==3,2),VX(fidx==3,3), 'kd');
set(gca,'linewidth',2);
grid on
set(F5,'linewidth',2, 'MarkerSize',8);
xlabel('票面利率','fontsize',12);
ylabel('评级得分','fontsize',12);
ylabel('到期收益率','fontsize',12);
title('高斯混合方法聚类结果')

%% k-Means方法确定最佳的聚类类别数
% 绘制几个典型类别数情况下的平均轮廓值图
figure
for i=2:4
    kidx = kmeans(bonds,i,'distance',dist_k);
    subplot(3,1,i-1)
    [~,F6] = silhouette(bonds,kidx,dist_k);
    xlabel('轮廓值','fontsize',12);
    ylabel('类别数','fontsize',12);
    set(gca,'linewidth',2);
    title([num2str(i) '类对应的轮廓值图 ' ])
    snapnow
end



% 计算平均轮廓值
numC = 15;
silh_m = nan(numC,1);
for i=1:numC
    kidx = kmeans(bonds,i,'distance',dist_k,'MaxIter',500);
    silh = silhouette(bonds,kidx,dist_k);
    silh_m(i) = mean(silh);
end

%绘制各类别数对应的平均轮廓值图
figure
F7 = plot(1:numC,silh_m,'o-');
set(gca,'linewidth',2);
set(F7, 'linewidth',2, 'MarkerSize',8);
xlabel('类别数', 'fontsize',12)
ylabel('平均轮廓值','fontsize',12)
title('平均轮廓值vs.类别数')
%% 聚类方案案例
