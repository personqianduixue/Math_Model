%% 最短路径的求解，以及现有的交巡警服务平台设置方案的合理性的判断
% 《MATLAB数学建模方法与实践》(《MATLAB在数学建模中的应用》升级版)，北航出版社，卓金武、王鸿钧编著. 
clc; clear all; close all
%% 数据准备
% 全市交通网络中路口节点节点坐标
A=xlsread('2011B_Table.xls', '全市交通路口节点数据','A2:C583'); 
% 全市交通路线
B=xlsread('2011B_Table.xls', '全市交通路口的路线','A2:B929');
% 每个路口发案率(次数)
owl=xlsread('2011B_Table.xls', '全市交通路口节点数据','E2:E93');
%% 计算最短距离矩阵
arn=size(A,1)
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
    apsn=4;
    com_pat=nchoosek(alt_sta,apsn);
    com_num=size(com_pat, 1);
    avn=0;
    bfair_f=inf;
    for k1=1:com_num
         npsl=[ppsl, com_pat(k1,:)]; % 更新警台设置方案
        % 计算还有多少路口不满足3分钟出警 
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
         
         if tun_num==0
          avn=avn+1;
          workload=zeros(1, 24);
               for j=1:24
                 for u=1:92
                     if SR(u,2)==npsl(1,j)
                     workload(1,j)=workload(1,j)+owl(u,1);
                     end
                  end
               end
               fair_f=var(workload,1);
               fair_r(avn,:)=[avn, fair_f,  com_pat(k1,:)];             
               
              if fair_f<bfair_f
                   bfair_f=fair_f;
                   ba=com_pat(k1,:);
                   bs=SR;
              end
         end       
    end      
%% 关闭多核计算
if matlabpool('size') > 0
    matlabpool close
end
%% 显示结果
abpn=0;
for i=1:avn
    if fair_r(i,2)==bfair_f
        abpn=abpn+1;
        abps(abpn,:)=[abpn, fair_r(i,2:end)];
    end
end
disp(['所有可行方案数' num2str(avn)]);
disp(['最佳方案数' num2str(abpn)]);
disp('所有最佳方案:')
abps
disp('最佳方案对应的工作均衡度:')
bfair_f
plot(fair_r(:,1),fair_r(:,2),'-ko', 'LineWidth', 2);
set(gca,'linewidth',2) ;
xlabel('可行方案编号'); ylabel('工作均衡度');
title('各可行方案的工作均衡度','fontsize',12);       



