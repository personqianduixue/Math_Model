%function S_xy = sort_reform(B,DeD)
%% 读入数据
%% 找出第一列，不同数
clear;clc;close
A=load('InfoUD.mat');
P=100;
B=[];
B(:,1)=[A.node1;A.node2];
B(:,2)=[A.node2;A.node1];
load('InfoUD_DeD.mat')
B1=B(:,1);
num0=unique(B1);
mini=min(num0);
maxi=max(num0);

%% 缺漏:
check=mini:maxi;
len=length(check);
i=1;
leak_num=0;
leak=NaN*ones(len);

while i == len
    if num0(i)==check(i)
        i=i+1;
        
    else
        que_num=num0(i)-check(i);
        std_num=leak_num;
        final_num=que_num+leak_num;
        leak(std_num+1:final_num)=i:i+que_num-1;
        i=i+que_num;
        
    end
    
end

%% 重组：
B2=B(:,2);
index=1:len;
reform_data=NaN*ones(len,len);
leak_std=1;

for j=index
    if j==leak(leak_std)
        leak_std=leak_std+1;
        continue;
    else
        judge_sign = (B1 == check(j));
        term=sum(judge_sign);
        reform_data(1:term,j)=B2(judge_sign);%以列储存
    end
    
end
L=zeros(len);
S_xy=zeros(len);
AV_DeD=zeros(len);
for i=index
    for j=index
       Lx=reform_data(:,i);
       Ly=reform_data(:,j);
       Lx=Lx(~isnan(Lx));
       Ly=Ly(~isnan(Ly));
       L(i,j)=length((intersect(Lx,Ly))); 
       AV_DeD(i,j)=DeD(i)+DeD(j);
       S_xy(i,j)=2*L(i,j)/(DeD(i)+DeD(j));
    end
end


