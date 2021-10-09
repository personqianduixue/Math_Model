%% 出租车补贴方案仿真程序
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc, clear, close all
%% 数据结构设计
% passengers:
% [出发点横坐标，出发点纵坐标，目的地横坐标，目的地纵坐标，出行里程]
% 即[xs,ys,xd,yd,l]
% taxis
% [出租车位置横坐标，出租车位置纵坐标，出租车被占用里程]
% 即[x_taxi,y_taxi,lo]
r_valid = 2/10;%出租车有效覆盖半径
xmax = 111*cos(pi*34/180)*1.4;
ymax = 0.7*111;
xmax = xmax/10;
ymax = ymax/10;
psnger_total = 80;
taxi_total = 152;
%先生成5000个出发点
for i = 1:psnger_total
    passengers(i,:) = gen_passenger();
end
for i = 1:taxi_total
    taxis(i,:) = gen_taxi();
end
figure
scatter(taxis(:,1)*10,taxis(:,2)*10)
xlabel('x(km)')
ylabel('y(km)')
all_B = [];
all_K = [];
for i = 1:200
    %% 首先更新出租车状态
    lc = taxis(:,3) - 0.01;%出租车被占用里程
    lc(lc < 0) = 0;
    taxis(:,3) = lc;
    %空车随机一个方向前进0.01
    valid_lines = find( lc == 0 );
    all_K = [all_K,1-length(valid_lines)/taxi_total]; 
    for m = 1:length(valid_lines)
        k = valid_lines(m);
        while(1)
            degree = 2*pi*rand();%出行方向
            new_x = taxis(k,1) + 0.01.*cos(degree);
            new_y = taxis(k,2) + 0.01.*sin(degree);
            if(new_x>=0 && new_x<=xmax && new_y>=0 && new_y<=ymax)
                taxis(k,1:2) = [new_x,new_y];
                break
            end
        end
    end
    
    %% 乘客加入系统
    add_passengers_total = 4;%round(normrnd(10,3));
    add_passengers = zeros(add_passengers_total,5);
    for n = 1:add_passengers_total
        add_passengers(n,:) = gen_passenger();
    end
    passengers = [passengers;add_passengers];    
    %% 计算各乘客视野内出租车数目  
    for j = 1:length(passengers)  
        p = passengers(j,:);
        if isnan(p(1))
            continue
        end
        temp_taxis = taxis; 
        %被占用的出租车不参与打车
        invalid_lines = find(temp_taxis(:,3)>0);
        temp_taxis(invalid_lines,:) = nan;
       %% 然后是乘客乘车
        r = sqrt((temp_taxis(:,1)-p(1)).^2+(temp_taxis(:,2)-p(2)).^2);
        taxi_num = find(r<r_valid);%视野范围内的车辆 
        if isempty(taxi_num)%视野内没有车，下一位乘客
            continue;
        else
            %随机选一辆乘坐
            index = round(rand()*(length(taxi_num)-1))+1;
            taxi_num = taxi_num(index);
            taxis(taxi_num,3) = p(5) + sqrt((taxis(taxi_num,1)-p(1))^2+(taxis(taxi_num,2)-p(2))^2);%此乘客p乘坐的出租车被占用
            taxis(taxi_num,1) = p(3);taxis(taxi_num,2) = p(4);%将其更新到目的地
            passengers(j,:) = nan;%更新乘客状态，上车的乘客变为nan，移出系统
        end
    end
        all_B = [all_B,calcu_b(passengers,taxis)];
end
%% 结果可视化
figure
hold on
scatter(taxis(:,1)*10,taxis(:,2)*10,'g*')
legend('初始位置','一段时间后位置')

%20次演化后才得到平时状态，故只保留20次之后的数据
pos = (20:length(all_B));
figure
plot((pos-20)/4.5,all_B(pos));
xlabel('时间(分钟)')
ylabel('数目不平衡度')
figure
plot((pos-20)/4.5,all_K(pos));
xlabel('时间(分钟)')
ylabel('里程利用率')

figure
res = sqrt( ((all_K-0.66)./0.66).^2 + (all_B-1).^2 );
plot((pos-20)/4.5,res(pos));
xlabel('时间(分钟)')
ylabel('供需不平衡度')