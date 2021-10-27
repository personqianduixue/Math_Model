clc;
clear;
A=xlsread('产权形式.xlsx');
num=zeros(1,12);%统计每个城市个数
num(1)=1;
city=A(:,1);%城市编号
yz=A(:,4);%运载里程
j=1;
for i=2:length(city)
    if(city(i)==city(i-1))
        num(j)=num(j)+1;
    else
        j=j+1;
        num(j)=num(j)+1;
    end
end
N=num;
ssum=zeros(1,12);%总量
av=zeros(1,12);%每个地区均值
i=1;

for j=1:num(i)
    if(isnan(yz(j))==1)
        yz(j)=0;
        N(i)=N(i)-1;
    end
    ssum(i)=ssum(i)+yz(j);
end
av(i)=ssum(i)/N(i);
 t=find(yz(1:num(i))>4*av(i));
    if(length(t)~=0)
        disp('运载里程异常数据为')
        disp(t)
      N(i)=N(i)-length(t);
      ssum(i)=ssum(i)-sum(yz(t));
    end
    av(i)=ssum(i)/N(i);
cum=cumsum(num);
for i=2:12
    for j=cum(i-1)+1:cum(i)
         if(isnan(yz(j))==1)
        yz(j)=0;
        N(i)=N(i)-1;
    end
    ssum(i)=ssum(i)+yz(j);
    end
    av(i)=ssum(i)/N(i);
    t=find(yz(cum(i-1)+1:cum(i))>4*av(i));
    t=t+cum(i-1);
    if(length(t)~=0)
        disp('运载里程异常数据为')
        disp(t)
      N(i)=N(i)-length(t);
      ssum(i)=ssum(i)-sum(yz(t));
    end
    av(i)=ssum(i)/N(i);
   
end
av'
