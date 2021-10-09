function DrawPath(route,City)
%% 画路径函数
%输入
% route     待画路径   
% City      各城市坐标位置

figure
hold on %保留当前坐标区中的绘图，从而使新添加到坐标区中的绘图不会删除现有绘图
box on %通过将当前坐标区的 Box 属性设置为 'on' 在坐标区周围显示框轮廓
xlim([min(City(:,1)-0.01),max(City(:,1)+0.01)]) %手动设置x轴范围  xlimit
ylim([min(City(:,2)-0.01),max(City(:,2)+0.01)]) %手动设置y轴范围

% 画配送中心点
plot(City(1,1),City(1,2),'bp','MarkerFaceColor','r','MarkerSize',15) %plot(x轴坐标,y轴坐标,圆圈,颜色,某色RGB三元组)

% 画需求点
plot(City(2:end,1),City(2:end,2),'o','color',[0.5,0.5,0.5],'MarkerFaceColor','g') %plot(x轴坐标,y轴坐标,圆圈,颜色,某色RGB三元组)

%添加点编号
for i=1:size(City,1)
    text(City(i,1)+0.002,City(i,2)-0.002,num2str(i-1)); %为点进行编号 text(x轴坐标,y轴坐标,圆圈,颜色,红色RGB三元组)
end

axis equal %使XY轴的刻度比例一致

% 画箭头
A=City(route+1,:);
arrcolor=rand(1,3); %箭头颜色随机
for i=2:length(A)
    [arrowx,arrowy] = dsxy2figxy(gca,A(i-1:i,1),A(i-1:i,2)); %坐标归一化
    annotation('textarrow',arrowx,arrowy,'HeadLength',8,'HeadWidth',8,'LineWidth',2,'color',arrcolor); % 画箭头
	%下一个车辆路线换颜色
    if route(i)==0
        arrcolor=rand(1,3); %颜色RGB三元组
	end
end
set(gca, 'LineWidth',1)
hold off	%将保留状态设置为 off，从而使新添加到坐标区中的绘图清除现有绘图并重置所有的坐标区属性
xlabel('North Latitude')
ylabel('East Longitude')
title('Route Map')