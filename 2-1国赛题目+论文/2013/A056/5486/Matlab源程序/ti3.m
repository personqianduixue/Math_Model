%%  处理第三题数据
load('ti3data')
x1=data(:,1).*360;
x2=data(:,2);
x3=data(:,3).*360;
y=data(:,4);
% x1为事故横断面实际通行能力，x2为事故持续时间，x3为路段上游车流量
%% 分别观察路段车辆排队长度与事故横断面实际通行能力、事故持续时间、路段上游车流量间的关系
figure;
plot(x1,y,'o')
figure;
plot(x2,y,'o')
figure;
plot(x3,y,'o')
data1=[x1,x2,x3]