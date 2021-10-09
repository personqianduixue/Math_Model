function [path,pheromone]=searchpath(PopNumber,LevelGrid,PortGrid,pheromone,HeightData,starty,starth,endy,endh)
%% 该函数用于蚂蚁蚁群算法的路径规划
%LevelGrid     input    横向划分格数
%PortGrid      input    纵向划分个数
%pheromone     input    信息素
%HeightData    input    地图高度
%starty starth input    开始点
%path          output   规划路径
%pheromone     output   信息素

%% 搜索参数
ycMax=2;   %蚂蚁横向最大变动
hcMax=2;   %蚂蚁纵向最大变动
decr=0.9;  %信息素衰减概率

%% 循环搜索路径
for ii=1:PopNumber
    
    path(ii,1:2)=[starty,starth];  %记录路径
    NowPoint=[starty,starth];      %当前坐标点
    
    %% 计算点适应度值
    for abscissa=2:PortGrid-1
        %计算所有数据点对应的适应度值
        kk=1;
        for i=-ycMax:ycMax
            for j=-hcMax:hcMax
                NextPoint(kk,:)=[NowPoint(1)+i,NowPoint(2)+j];
                if (NextPoint(kk,1)<20)&&(NextPoint(kk,1)>0)&&(NextPoint(kk,2)<20)&&(NextPoint(kk,2)>0)
                    qfz(kk)=CacuQfz(NextPoint(kk,1),NextPoint(kk,2),NowPoint(1),NowPoint(2),endy,endh,abscissa,HeightData);
                    qz(kk)=qfz(kk)*pheromone(abscissa,NextPoint(kk,1),NextPoint(kk,2));
                    kk=kk+1;
                else
                    qz(kk)=0;
                    kk=kk+1;
                end
            end
        end
        
        
        %选择下个点
        sumq=qz./sum(qz);
    
        pick=rand;
        while pick==0
            pick=rand;
        end
        
        for i=1:25
            pick=pick-sumq(i);
            if pick<=0
                index=i;
                break;
            end
        end
        
        oldpoint=NextPoint(index,:);
        
        %更新信息素
        pheromone(abscissa+1,oldpoint(1),oldpoint(2))=0.5*pheromone(abscissa+1,oldpoint(1),oldpoint(2));
        
        %路径保存
        path(ii,abscissa*2-1:abscissa*2)=[oldpoint(1),oldpoint(2)];    
        NowPoint=oldpoint;
        
    end
    path(ii,41:42)=[endy,endh];
end
    
    