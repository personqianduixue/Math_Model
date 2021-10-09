%% 最短路径的求解，以及现有的交巡警服务平台设置方案的合理性的判断
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc; clear all;
%% 数据准备
% 全市交通网络中路口节点节点坐标
A=xlsread('2011B_Table.xls', '全市交通路口节点数据','A2:C583'); 
% 全市交通路线
B=xlsread('2011B_Table.xls', '全市交通路口的路线','A2:B929');
% A区巡警台设置位置
PS_A=xlsread('2011B_Table.xls', '全市交巡警平台','B2:B21');

%% 计算最短距离矩阵
arn=size(A,1);
brn=size(B,1);
% 构建距离矩阵
D=ones(arn);
D(:)=inf;
for i=1:arn
    D(i,i)=0;
end

for i=1:brn
    m=B(i,1);   % 起点标号
    n=B(i,2);   % 终点标号
    d=sqrt((A(m,2)-A(n,2))^2+(A(m,3)-A(n,3))^2);
    D(m,n)=d;
    D(n,m)=d;
end
[dmin,path]=floyd(D);

%% 划分A区交巡警服务平台管辖范围
PN_A=A(1:92,1);
psn=size(PS_A, 1);
for i=1:92
    SR(i,1)=i;
    SR(i,2)=0;
    SR(i,3)=inf;
    SR(i,4)=0;
    for j=1:psn
        if SR(i,3)>dmin(i,j)
         SR(i,3)=dmin(i,j);
         SR(i,2)=j;
        end
    end
    if SR(i,3)*100>3000
       SR(i,4)=1;
    end    
end
%% 输出结果 
disp('A区交巡警服务平台管辖范围划分方案为：')
SR

        



