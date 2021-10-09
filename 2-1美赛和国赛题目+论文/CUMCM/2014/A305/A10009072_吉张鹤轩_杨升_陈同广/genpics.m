cd('./');
clear;
load('2400m处分析数据.mat');
%聚落分析
figure;
cla;
surface(data4,'EdgeColor','none');
colorbar;
saveas(gcf,'2400m处聚落分析.png');
%合适区域
cla;
surf(score,'EdgeColor','none');
colorbar;
saveas(gcf,'2400m处落点评价.png');

clear;
load('100m处分析数据.mat');
%聚落分析
cla;
surface(data4,'EdgeColor','none');
colorbar;
saveas(gcf,'100m处聚落分析.png');
%合适区域
cla;
surf(score,'EdgeColor','none');
colorbar;
saveas(gcf,'100m处落点评价.png');





clear;
cla;
calc_proc2;
saveas(gcf,'第一阶段降落y-x轨迹.png');

cla;
hold on;
plot(history(:,1), history(:,3), 'b', 'LineWidth',2);
plot(history(:,1), history(:,4), 'red', 'LineWidth',2);
legend ('\fontsize {17}Vx', '\fontsize {17}Vy');
xlabel 't/s';
ylabel 'V/(m/s)';
saveas(gcf,'第一阶段降落Vx、Vy-t轨迹.png');

cla;
hold on;
plot(history(:,1), history(:,5), 'black', 'LineWidth',2);
axis([0, 450, 0, 0.45]);
xlabel 't/s';
ylabel 'θ/rad';
saveas(gcf,'第一阶段降落sita-t轨迹.png');

clear;
cla;
calc_proc;
saveas(gcf,'问题一降落y-x轨迹.png');

cla;
hold on;
plot(history(:,1), history(:,3), 'b', 'LineWidth',2);
plot(history(:,1), history(:,4), 'red', 'LineWidth',2);
legend ('\fontsize {17}Vx', '\fontsize {17}Vy');
xlabel 't/s';
ylabel 'V/(m/s)';
saveas(gcf,'问题一降落Vx、Vy-t轨迹.png');

cla;
hold on;
plot(history(:,1), history(:,5), 'black', 'LineWidth',2);
axis([0, 450, 0, 0.8]);
xlabel 't/s';
ylabel 'θ/rad';
saveas(gcf,'问题一降落sita-t轨迹.png');


%杂类
clear;
load('2400m处分析数据.mat');
plotdata = [];
for i = 1:1:255
    plotdata = [plotdata; i, sum(sum(A == i))];
end
max0=0; max1=0; max2=0; max3=0;
for i = 1:1:460
    for j = 1:1:460
        if(data4(i,j)==0)
            if(data(i,j) > max0)
                max0 = data(i,j);
            end
        end
        if(data4(i,j)==1)
            if(data(i,j) > max1)
                max1 = data(i,j);
            end
        end
        if(data4(i,j)==2)
            if(data(i,j) > max2)
                max2 = data(i,j);
            end
        end
        if(data4(i,j)==3)
            if(data(i,j) > max3)
                max3 = data(i,j);
            end
        end
    end
end
hold on
plot(plotdata(:,1), plotdata(:,2), 'black', 'LineWidth',1.5);
plot([max3+0.5 max3+0.5], [0, 3.5e5], 'red', 'LineWidth',2,'linestyle',':');
plot([max2+0.5 max2+0.5], [0, 3.5e5], 'red', 'LineWidth',2,'linestyle',':');
plot([max1+0.5 max1+0.5], [0, 3.5e5], 'red', 'LineWidth',2,'linestyle',':');
plot([max0+0.5 max0+0.5], [0, 3.5e5], 'red', 'LineWidth',2,'linestyle',':');
axis([0 255 0 400000])
saveas(gcf,'灰阶分布.png');