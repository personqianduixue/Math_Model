function main()
clc;clear all;close all;
tic;                              %程序运行计时
E0=0.001;                        %允许误差
MaxNum=100;                    %粒子最大迭代次数
narvs=1;                         %目标函数的自变量个数
particlesize=30;                    %粒子群规模
c1=2;                            %每个粒子的个体学习因子，也称为加速常数
c2=2;                            %每个粒子的社会学习因子，也称为加速常数
w=0.6;                           %惯性因子
vmax=0.8;                        %粒子的最大飞翔速度
x=-5+10*rand(particlesize,narvs);     %粒子所在的位置
v=2*rand(particlesize,narvs);         %粒子的飞翔速度
%用inline定义适应度函数以便将子函数文件与主程序文件放在一起，
%目标函数是：y=1+(2.1*(1-x+2*x.^2).*exp(-x.^2/2))
%inline命令定义适应度函数如下：
fitness=inline('1/(1+(2.1*(1-x+2*x.^2).*exp(-x.^2/2)))','x');
%inline定义的适应度函数会使程序运行速度大大降低
for i=1:particlesize
    for j=1:narvs
        f(i)=fitness(x(i,j));
    end
end
personalbest_x=x;
personalbest_faval=f;
[globalbest_faval i]=min(personalbest_faval);
globalbest_x=personalbest_x(i,:);
k=1;
while k<=MaxNum
    for i=1:particlesize
        for j=1:narvs
            f(i)=fitness(x(i,j));
        end
        if f(i)<personalbest_faval(i) %判断当前位置是否是历史上最佳位置
            personalbest_faval(i)=f(i);
            personalbest_x(i,:)=x(i,:);
        end
    end
    [globalbest_faval i]=min(personalbest_faval);
    globalbest_x=personalbest_x(i,:);
    for i=1:particlesize %更新粒子群里每个个体的最新位置
        v(i,:)=w*v(i,:)+c1*rand*(personalbest_x(i,:)-x(i,:))...
            +c2*rand*(globalbest_x-x(i,:));
        for j=1:narvs    %判断粒子的飞翔速度是否超过了最大飞翔速度
            if v(i,j)>vmax;
                v(i,j)=vmax;
            elseif v(i,j)<-vmax;
                v(i,j)=-vmax;
            end
        end
        x(i,:)=x(i,:)+v(i,:);
    end
    if abs(globalbest_faval)<E0,break,end
    k=k+1;
end
Value1=1/globalbest_faval-1; Value1=num2str(Value1);
% strcat指令可以实现字符的组合输出
disp(strcat('the maximum value','=',Value1));
%输出最大值所在的横坐标位置
Value2=globalbest_x; Value2=num2str(Value2);
disp(strcat('the corresponding coordinate','=',Value2));
x=-5:0.01:5;
y=2.1*(1-x+2*x.^2).*exp(-x.^2/2);
plot(x,y,'m-','linewidth',3);
hold on;
plot(globalbest_x,1/globalbest_faval-1,'kp','linewidth',4);
legend('目标函数','搜索到的最大值');xlabel('x');ylabel('y');grid on;toc;
