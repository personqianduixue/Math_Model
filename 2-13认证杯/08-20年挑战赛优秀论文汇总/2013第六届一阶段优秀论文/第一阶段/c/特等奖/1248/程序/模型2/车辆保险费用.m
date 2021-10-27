clc;
clear;
B=xlsread('城市差异——车辆保障费用.xls');
A=B(:,2:11)';
A=sum(A);
A=[B(:,1) A'];
num=zeros(1,12);%统计每个城市个数
num(1)=1;
city=A(:,1);%城市编号
gz=A(:,2);%收入
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
    if(isnan(gz(j))==1)
        gz(j)=0;
        N(i)=N(i)-1;
    end
    ssum(i)=ssum(i)+gz(j);
end
av(i)=ssum(i)/N(i);
 t=find(gz(1:num(i))>20*av(i));
    if(length(t)~=0)
        disp('购置金额异常数据为')
        disp(t)
      N(i)=N(i)-length(t);
      ssum(i)=ssum(i)-sum(gz(t));
    end
    av(i)=ssum(i)/N(i);
cum=cumsum(num);
for i=2:12
    for j=cum(i-1)+1:cum(i)
         if(isnan(gz(j))==1)
        gz(j)=0;
        N(i)=N(i)-1;
    end
    ssum(i)=ssum(i)+gz(j);
    end
    av(i)=ssum(i)/N(i);
    t=find(gz(cum(i-1)+1:cum(i))>20*av(i));
    t=t+cum(i-1);
    if(length(t)~=0)
        disp('购置金额异常数据为')
        disp(t)
      N(i)=N(i)-length(t);
      ssum(i)=ssum(i)-sum(gz(t));
    end
    av(i)=ssum(i)/N(i);
   
end
av'
