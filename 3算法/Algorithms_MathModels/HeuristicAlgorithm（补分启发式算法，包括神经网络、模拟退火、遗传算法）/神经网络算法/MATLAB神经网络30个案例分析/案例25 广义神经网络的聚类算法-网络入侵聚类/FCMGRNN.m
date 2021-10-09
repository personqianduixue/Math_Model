web browser http://www.ilovematlab.cn/thread-64642-1-1.html
%% 清空环境文件
clear all;
clc;

%% 提取攻击数据

%攻击样本数据
load netattack;
P1=netattack;
T1=P1(:,39)';
P1(:,39)=[];

%数据大小
[R1,C1]=size(P1);
csum=20;  %提取训练数据多少

%% 模糊聚类
data=P1;
[center,U,obj_fcn] = fcm(data,5);    
for i=1:R1
    [value,idx]=max(U(:,i));
    a1(i)=idx;
end

%% 模糊聚类结果分析
Confusion_Matrix_FCM=zeros(6,6);
Confusion_Matrix_FCM(1,:)=[0:5];
Confusion_Matrix_FCM(:,1)=[0:5]';
for nf=1:5
    for nc=1:5
        Confusion_Matrix_FCM(nf+1,nc+1)=length(find(a1(find(T1==nf))==nc));
    end
end

%% 网络训练样本提取
cent1=P1(find(a1==1),:);cent1=mean(cent1);
cent2=P1(find(a1==2),:);cent2=mean(cent2);
cent3=P1(find(a1==3),:);cent3=mean(cent3);
cent4=P1(find(a1==4),:);cent4=mean(cent4);
cent5=P1(find(a1==5),:);cent5=mean(cent5);

%提取范数最小为训练样本
for n=1:R1;
    ecent1(n)=norm(P1(n,:)-cent1);
    ecent2(n)=norm(P1(n,:)-cent2);
    ecent3(n)=norm(P1(n,:)-cent3);
    ecent4(n)=norm(P1(n,:)-cent4);
    ecent5(n)=norm(P1(n,:)-cent5);
end
for n=1:csum
    [va me1]=min(ecent1);
    [va me2]=min(ecent2);
    [va me3]=min(ecent3);
    [va me4]=min(ecent4);
    [va me5]=min(ecent5);
    ecnt1(n,:)=P1(me1(1),:);ecent1(me1(1))=[];tcl(n)=1;
    ecnt2(n,:)=P1(me2(1),:);ecent2(me2(1))=[];tc2(n)=2;
    ecnt3(n,:)=P1(me3(1),:);ecent3(me3(1))=[];tc3(n)=3;
    ecnt4(n,:)=P1(me4(1),:);ecent4(me4(1))=[];tc4(n)=4;
    ecnt5(n,:)=P1(me5(1),:);ecent5(me5(1))=[];tc5(n)=5;
end
P2=[ecnt1;ecnt2;ecnt3;ecnt4;ecnt5];T2=[tcl,tc2,tc3,tc4,tc5];
k=0;

%% 迭代计算
for nit=1:10%开始迭代
    
    %% 广义神经网络聚类
    net = newgrnn(P2',T2,50);   %训练广义网络
    
    a2=sim(net,P1') ;  %预测结果
    %输出标准化（根据输出来分类）
    a2(find(a2<=1.5))=1;
    a2(find(a2>1.5&a2<=2.5))=2;
    a2(find(a2>2.5&a2<=3.5))=3;
    a2(find(a2>3.5&a2<=4.5))=4;
    a2(find(a2>4.5))=5;
    
    %% 网络训练数据再次提取
    cent1=P1(find(a2==1),:);cent1=mean(cent1);
    cent2=P1(find(a2==2),:);cent2=mean(cent2);
    cent3=P1(find(a2==3),:);cent3=mean(cent3);
    cent4=P1(find(a2==4),:);cent4=mean(cent4);
    cent5=P1(find(a2==5),:);cent5=mean(cent5);
    
    for n=1:R1%计算样本到各个中心的距离
        ecent1(n)=norm(P1(n,:)-cent1);
        ecent2(n)=norm(P1(n,:)-cent2);
        ecent3(n)=norm(P1(n,:)-cent3);
        ecent4(n)=norm(P1(n,:)-cent4);
        ecent5(n)=norm(P1(n,:)-cent5);
    end
    
    %选择离每类中心最近的csum个样本
    for n=1:csum
        [va me1]=min(ecent1);
        [va me2]=min(ecent2);
        [va me3]=min(ecent3);
        [va me4]=min(ecent4);
        [va me5]=min(ecent5);
        ecnt1(n,:)=P1(me1(1),:);ecent1(me1(1))=[];tc1(n)=1;
        ecnt2(n,:)=P1(me2(1),:);ecent2(me2(1))=[];tc2(n)=2;
        ecnt3(n,:)=P1(me3(1),:);ecent3(me3(1))=[];tc3(n)=3;
        ecnt4(n,:)=P1(me4(1),:);ecent4(me4(1))=[];tc4(n)=4;
        ecnt5(n,:)=P1(me5(1),:);ecent5(me5(1))=[];tc5(n)=5;
    end
    
    p2=[ecnt1;ecnt2;ecnt3;ecnt4;ecnt5];T2=[tc1,tc2,tc3,tc4,tc5];

    %统计分类结果
    Confusion_Matrix_GRNN=zeros(6,6);
    Confusion_Matrix_GRNN(1,:)=[0:5];
    Confusion_Matrix_GRNN(:,1)=[0:5]';
    for nf=1:5
        for nc=1:5
            Confusion_Matrix_GRNN(nf+1,nc+1)=length(find(a2(find(T1==nf))==nc));
        end
    end
    
    pre2=0;
    
    for n=2:6;
        pre2=pre2+max(Confusion_Matrix_GRNN(n,:));
    end
    
    pre2=pre2/R1*100;

end

%% 结果显示
Confusion_Matrix_FCM

Confusion_Matrix_GRNN

web browser http://www.ilovematlab.cn/thread-64642-1-1.html