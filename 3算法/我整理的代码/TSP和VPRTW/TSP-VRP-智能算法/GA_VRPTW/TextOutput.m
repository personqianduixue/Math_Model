function TextOutput(route,Distance,TravelTime,Demand,TimeWindow,Capacity)
%% 输出路径函数
%输入：route 路径
%输出：p 路径文本形式

%% 总路径
len=length(route); %路径长度
disp('Best Route:')

p=num2str(route(1)); %配送中心位先进入路径首位
for i=2:len
    p=[p,' -> ',num2str(route(i))]; %路径依次加入下一个经过的点
end
disp(p)

%% 子路径

route=route+1; %路径值全体+1，为方便下面用向量索引

Vnum=1; %
DisTraveled=0;  % 汽车已经行驶的距离
CurrentTime=0; %本车行驶时间置零
delivery=0;       % 汽车已经送货量，即已经到达点的需求量之和
subpath='0'; %子路径路线
subtime='0'; %经过一子路径各点时间
for j=2:len
    DisTraveled = DisTraveled+Distance(route(j-1),route(j)); %每两点间距离累加
    CurrentTime=CurrentTime+TravelTime(route(j-1),route(j)); %每两点间行驶时间累加
    delivery = delivery+Demand(route(j)); %累加可配送量
    
    
    
    subpath=[subpath,' -> ',num2str(route(j)-1)]; %子路径路线输出
    subtime=[subtime,' - ',num2str(roundn(CurrentTime,-1))]; %子路径到达各点时刻输出
    
    CurrentTime=max(CurrentTime,TimeWindow(route(j),1));  %若到达时间早于早时间窗，等待至早时间窗
    
	if route(j) == 1 %若此位是配送中心
        disp('-------------------------------------------------------------')
        fprintf('Route of Vehichle No.%d: %s  \n',Vnum,subpath)%输出：每辆车 路径
        fprintf('Time of arrival: %s min \n',subtime)%输出：到达各点时刻
        fprintf('Distance traveled: %.2f km, time elapsed: %.1f min, load rate: %.2f%%;  \n',DisTraveled,CurrentTime,delivery/Capacity*100)%输出：行驶距离 满载率
        Vnum=Vnum+1; %车辆数累加
        DisTraveled=0; %已行驶距离置零
        CurrentTime=0; %本车行驶时间置零
        delivery=0; %已配送置零
        subpath='0'; %子路径重置
        subtime='0'; %子路径时间重置
	end
end
