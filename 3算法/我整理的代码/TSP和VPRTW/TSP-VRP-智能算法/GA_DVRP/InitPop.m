function Chrom=InitPop(NIND,CityNum,Distance,Travelcon)
%% 初始化种群
% 
%输入：
%NIND       种群大小
%CityNum	需求点个数
%Distance    距离矩阵
%Travelcon   行程约束
%输出：
%Chrom      初始种群

Chrom=zeros(NIND,CityNum*2+1); %预分配内存，用于存储种群数据

for i=1:NIND
    TSProute=[0,randperm(CityNum)]+1; %随机生成一条不包括尾位的TSP路线
    VRProute=ones(1,CityNum*2+1); %初始化VRP路径
    
    DisTraveled=0; % 汽车已经行驶距离
    k=1;
	for j=2:CityNum+1
        k=k+1;%对VRP路径下一点进行赋值
        if DisTraveled+Distance(VRProute(k-1),TSProute(j))+Distance(TSProute(j),1) > Travelcon  %这一点配送完成后,再回到配送中心不超行程约束
            VRProute(k)=1; %经过配送中心
            DisTraveled=Distance(1,TSProute(j)); %距离初始化为配送中心到此点距离
            % 新一辆车再去下一个需求点
            k=k+1;
            VRProute(k)=TSProute(j);  %TSP路线中此点添加到VRP路线
        else %
            DisTraveled=DisTraveled+Distance(TSProute(j-1),TSProute(j));
            VRProute(k)=TSProute(j); %TSP路线中此点添加到VRP路线
        end
	end
    Chrom(i,:)=VRProute;  %此路线加入种群
end