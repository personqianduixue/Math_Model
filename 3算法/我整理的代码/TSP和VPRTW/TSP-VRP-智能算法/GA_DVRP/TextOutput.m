function TextOutput(Distance,route)
%% 输出路径函数
%输入：
%Distance	距离矩阵
%route      路径
%输出：
%p          路径文本形式

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
subpath='0'; %子路径路线
for j=2:len
    DisTraveled = DisTraveled+Distance(route(j-1),route(j)); %每两点间距离累加
    subpath=[subpath,' -> ',num2str(route(j)-1)]; %子路径路线输出

	if route(j)==1 %若此位是配送中心
        disp('-------------------------------------------------------------')
        fprintf('Route of Vehichle No.%d: %s  \n',Vnum,subpath)%输出：每辆车 路径 
        fprintf('Distance traveled: %.2f km;  \n',DisTraveled)%输出：行驶距离
        Vnum=Vnum+1; %车辆数累加
        DisTraveled=0; %已行驶距离置零
        subpath='0'; %子路径重置
	end
end
