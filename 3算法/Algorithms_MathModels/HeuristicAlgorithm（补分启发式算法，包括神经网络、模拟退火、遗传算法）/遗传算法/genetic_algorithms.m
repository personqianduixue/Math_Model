%经纬度最小TSP问题
clc,clear

load example_1.txt %加载敌方100 个目标的数据（修改！使其处理5个目标）
sj = example_1

x=sj(:,1:2:8);x=x(:);%经度
y=sj(:,2:2:8);y=y(:);%纬度
sj=[x y];
d1=[70,40];
sj0=[d1;sj;d1];

%距离矩阵d
sj=sj0*pi/180;
d=zeros(102);
for i=1:101
    for j=i+1:102%产生一个上三角矩阵
        temp=cos(sj(i,1)-sj(j,1))*cos(sj(i,2))*cos(sj(j,2))+sin(sj(i,2))*sin(sj(j,2));
        d(i,j)=6370*acos(temp);
    end
end

d=d+d';L=102;w=50;dai=100;%w种群大小，dai代数
%通过改良圈算法选取优良父代A
for k=1:w
    c=randperm(100);%产生0~100的随机数
    c1=[1,c+1,102];
    flag=1;
    while flag>0
        flag=0;
        for m=1:L-3
            for n=m+2:L-1
                if d(c1(m),c1(n))+d(c1(m+1),c1(n+1))<d(c1(m),c1(m+1))+d(c1(n),c1(n+1))%判断新路径与原路径相比较
                    flag=1;
                    c1(m+1:n)=c1(n:-1:m+1);%cl(2:4)=cl(4:-1:2)倒转
                end
            end
        end
    end
    J(k,c1)=1:102;%k=1,2,3…
end

J=J/102;%归一化
J(:,1)=0;J(:,102)=1;
rand('state',sum(clock));

%遗传算法实现过程
A=J;
for k=1:dai %产生0～1 间随机数列进行编码
    B=A;
    c=randperm(w);%w种群大小
    %交配产生子代B
    for i=1:2:w
        F=2+floor(100*rand(1));%rand(1)产生一个随机数（0,1，floor趋向负无穷取整
        temp=B(c(i),F:102);%B(2,63:102)
        B(c(i),F:102)=B(c(i+1),F:102);%两行之间交换基因
        B(c(i+1),F:102)=temp;
    end
    %-280-
    %变异产生子代C
    by=find(rand(1,w)<0.1);%变异率小于0.1
    if length(by)==0
        by=floor(w*rand(1))+1;
    end
    C=A(by,:);
    L3=length(by);
    for j=1:L3
        bw=2+floor(100*rand(1,3));
        bw=sort(bw);%升序排列
        C(j,:)=C(j,[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:102]);%C（1,[1:16,65:73,17:64,74:102]）
    end
    G=[A;B;C];%105*102
    TL=size(G,1);
    %在父代和子代中选择优良品种作为新的父代
    [dd,IX]=sort(G,2);temp(1:TL)=0;%sort 矩阵的每一列按降序排列
    for j=1:TL
        for i=1:101
            temp(j)=temp(j)+d(IX(j,i),IX(j,i+1));
        end
    end
    [DZ,IZ]=sort(temp);
    A=G(IZ(1:w),:);
end

path=IX(IZ(1),:)
long=DZ(1)
%toc
xx=sj0(path,1);yy=sj0(path,2);%经度和纬度
%DD=[xx,yy];
plot(xx,yy,'-o')

% [B,I]=sort(A,2) 
%B=[1 3 5
%   1 2 4]
%I=[ 1 3 2   元素在原矩阵中行的位置
%    3 1 2]

%[B,I]=sort(A) I返回元素在原矩阵中列的位置
