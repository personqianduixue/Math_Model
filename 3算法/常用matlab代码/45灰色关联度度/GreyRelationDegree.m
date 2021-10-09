function GreyRelationDegree(stats) %% stats是一个m×n的评价矩阵，即m个评价对象、n个评价指标
 
%% [重要]设置参考数列，即各指标的理想最优值组成的行向量，长度必需要与stats列数一致
optArray=max(stats,[],1) % 这里设置假设所有指标均为正向型指标，各指标的最大值组成参考数列，在实际应用中根据具体情况进行设置
 
%% 原始评价矩阵及样本序号
[r,c]=size(stats);       % stats的行数和列数，即评价对象的个数及评价指标的个数
samNo=1:r;               % 样本序号
 
%% 数据规范化处理，将各指标数据与参考数列一起规范化到0-1之间
% 这里假设全为正向指标，即假设全部指标值越大越好，在实际应用中根据具体情况分别需对不同类型的指标数据进行标准化处理，然后再这里修改相应的代码
% 更多标准化处理方法见http://blog.sina.com.cn/s/blog_b3509cfd0101bsky.html
stdMatrix=zeros(r+1,c);  % 给标准化矩阵分配空间，第一行为参考数列的标准化值，第二行至最后一行为原始评价矩阵的标准化值
optArryAndStat=[optArray;stats];
maxOfCols=max(optArryAndStat);    % 包括参考数列在内的各列的最大值
minOfCols=min(optArryAndStat);    % 包括参考数列在内的各列的最小值
for j=1:c
    for i=1:r+1
        stdMatrix(i,j)=(optArryAndStat(i,j)-minOfCols(j))./(maxOfCols(j)-minOfCols(j));  % 计算标准化指标值
    end
end
 
stdMatrix

%% 计算关联系数
absValue=zeros(r,c);   % 给绝对差值序列分配空间
R_0 = stdMatrix(1,:);  % 标准化处理后的参考数列
for i=2:r+1
    absValue(i-1,:)=abs(stdMatrix(i,:)-R_0);  % 绝对差值序列计算
end
minAbsValueOfCols=min(absValue,[],1);    % absValue每一列的最小值
maxAbsValueOfCols=max(absValue,[],1);    % absValue每一列的最大值
minAbsValue=min(minAbsValueOfCols);      % absValue的最小值
maxAbsValue=max(maxAbsValueOfCols);      % absValue的最大值
defCoeff=0.5;          % 设置分辨系数为0.5
relCoeff=(minAbsValue+defCoeff*maxAbsValue)./(absValue+defCoeff*maxAbsValue);  % 关联系数计算
 
 stdMatrix(2:r,:)
%% 计算关联度
% 这里采用熵权法求客观权重，实现方法见：http://blog.sina.com.cn/s/blog_b3509cfd0101bm0f.html
% 在实际应用中可采用不同的方法确定权重，然后再这里修改相应的代码
weights=EntropyWeight(stdMatrix(2:r+1,:))  %r?/r+1? 权重
P=zeros(r,1);    % 给关联度序列分配空间
for i=1:r
    for j=1:c
        P(i,1)=relCoeff(i,j)*weights(j);  % 关联度计算
    end
end
 
 
%% 权重可视化
[sortW,IXW]=sort(weights,'descend');   % 权重降序排序，IXW确保对应的指标名称一致
indexes={};
for i=1:c
    indexes(i)={strcat('指标',num2str(i))}; % 指标名称为“指标1”、指标“2”……
end
sortIndex=indexes(IXW);                % 排序后与权重对应的指标名称
figure;
subplot(1,2,1);
bar(weights);
xlim([0 c+1]);   % 设置x轴范围
xlabel('指标名称','FontSize',12,'FontWeight','bold');
set(gca,'xtick',1:c);
set(gca,'XTickLabel',indexes,'FontWeight','light');
ylabel('权重','FontSize',12,'FontWeight','bold');
set(gca,'YGrid','on');
for i=1:c
    text(i-0.35,weights(i)+0.005,sprintf('%.3f',weights(i)));
end
title('指标权重可视化');
box off;
 
subplot(1,2,2);
bar(sortW);
xlim([0 c+1]);   % 设置x轴范围
xlabel('指标名称','FontSize',12,'FontWeight','bold');
set(gca,'xtick',1:c);
set(gca,'XTickLabel',sortIndex,'FontWeight','light');
ylabel('权重','FontSize',12,'FontWeight','bold');
set(gca,'YGrid','on');
for i=1:c
    text(i-0.35,sortW(i)+0.005,sprintf('%.3f',sortW(i)));
end
title('指标权重可视化（降序排列）');
box off;
 
 
%% 关联度分析结果展示
[sortP,IX]=sort(P,'descend');  % 关联度降序排序，IX确保对应的样本序号一致
sortSamNo=samNo(IX);           % 排序后与关联度对应的样本序号
figure;
subplot(2,1,1);
plot(P,'--rs',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',10);
xlim([1 r]);   % 设置x轴范围
xlabel('样本序号','FontSize',12,'FontWeight','bold');
set(gca,'xtick',1:r);
set(gca,'XTickLabel',samNo,'FontWeight','light');
ylabel('关联度','FontSize',12,'FontWeight','bold');
title('XXX事物灰色关联度综合评价结果');
grid on;
 
subplot(2,1,2);
plot(sortP,'--rs',...
    'LineWidth',2,...
    'MarkerEdgeColor','k',...
    'MarkerFaceColor','g',...
    'MarkerSize',10);
xlim([1 r]);   % 设置x轴范围
xlabel('样本序号','FontSize',10,'FontWeight','bold');
set(gca,'xtick',1:r);
set(gca,'XTickLabel',sortSamNo,'FontWeight','light');
ylabel('关联度','FontSize',10,'FontWeight','bold');
title('XXX事物灰色关联度综合评价结果（降序排列）');
grid on;
hold off;
 
end