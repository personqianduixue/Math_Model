function qfz=CacuQfz(Nexty,Nexth,Nowy,Nowh,endy,endh,abscissa,HeightData)
%% 该函数用于计算各点的启发值
%Nexty Nexth    input    下个点坐标
%Nowy Nowh      input    当前点坐标
%endy endh      input    终点坐标
%abscissa       input    横坐标
%HeightData     input    地图高度
%qfz            output   启发值

%% 判断下个点是否可达
if HeightData(Nexty,abscissa)<Nexth*200
    S=1;
else
    S=0;
end

%% 计算启发值
%D距离
D=50/(sqrt(1+(Nowh*0.2-Nexth*0.2)^2+(Nexty-Nowy)^2)+sqrt((21-abscissa)^2 ...
    +(endh*0.2-Nexth*0.2)^2+(endy-Nowy)^2));
%计算高度
M=30/abs(Nexth+1);
%计算启发值
qfz=S*M*D;



    

