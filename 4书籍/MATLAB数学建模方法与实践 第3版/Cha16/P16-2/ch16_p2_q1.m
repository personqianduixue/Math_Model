%% 最短路径的求解，以及现有的交巡警服务平台设置方案的合理性的判断
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc; clear all; close all
%% 数据准备
% 全市交通网络中路口节点节点坐标
A=xlsread('2011B_Table.xls', '全市交通路口节点数据','A2:C583'); 
% 全市交通路线
B=xlsread('2011B_Table.xls', '全市交通路口的路线','A2:B929');
% A区巡警台设置位置
%PS_A=xlsread('2011B_Table.xls', '全市交巡警平台','B2:B21');

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

%% 确定最佳新增警台数
alt_sta=21:92;
ppsl=1:20;
min_n=ones(1,5)*6;
%% 启用双核加速计算(多核计算机才可以采用)
if matlabpool('size') == 0 
    matlabpool open 2
end
%% 计算各新增警台数与对应的不满足3分钟出警的路口数
for apsn=2:5
    com_pat=nchoosek(alt_sta,apsn);
    com_num=size(com_pat, 1);
    tmin_un_num=6;
    for k1=1:com_num
         npsl=[ppsl, com_pat(k1,:)]; % 更新警台设置方案
        %% 计算还有多少路口不满足3分钟出警 
         SR=zeros(92,4);
         for i=1:92
             i;
         SR(i,1)=i;
         SR(i,2)=0;
         SR(i,3)=inf;
         SR(i,4)=0;
                for j=1:(20+apsn)
                   if SR(i,3)>dmin(i,npsl(j))
                      SR(i,3)=dmin(i,npsl(j));
                      SR(i,2)=npsl(j);
                   end
                end
                if SR(i,3)*100>3000
                   SR(i,4)=1;
                end    
         end
         tun_num=sum(SR(:,4));
         if tun_num<tmin_un_num
            tmin_un_num=tun_num;
         end
         if tmin_un_num==0
             break
         end
         
    end
    min_n(1,apsn)=tmin_un_num;
end
     
%% 关闭多核计算
if matlabpool('size') > 0
    matlabpool close
end
%% 显示结果
apn=[0, 2, 3, 4, 5]';
f_result=[apn, min_n']
figure(1) 
bar(apn,min_n)
xlabel('新增交警平台的数量');
ylabel('不满足3分钟出警的路口数');
title('不满足三分钟出警的路口数与新增服务台数的关系图','fontsize',12);
for i=1:4
    FT(1,i)=i+2*min_n(1,i+1);
end
opn=find(FT==min(FT));
disp(['最佳新增交警平台书:' num2str(opn+1)]);
T=2:5;
figure(2)
plot(T, FT,'-ko', 'LineWidth', 2);
xlabel('新增交警平台的数量');
ylabel('目标函数');
title('目标函数与新增交警平台的数关系图','fontsize',12);





        



