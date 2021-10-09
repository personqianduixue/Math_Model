F9=[0,0,0,0,-0.1,0,0,-0.1;90,80,80,80,80,80,80,80];
T=0.1;
h=0.05:0.01:0.30;
theta=zeros(size(h));
for i=1:length(h)
    [~,~,theta(i)]=drum_angle(F9,h(i),T);
end
figure
plot(h,theta);
title('第九组数据下鼓面在0.1s时的倾角和鼓面下降高度的关系');

t=0:0.01:0.15;
theta=zeros(size(t));
for i=1:length(t)
   F=[0,0,0,0,-t(i),0,0,-t(i);90,80,80,80,80,80,80,80];
   [~,~,theta(i)]=drum_angle(F,0.11,T);
end
figure
plot(t,theta);
title('第九组数据下鼓面在0.1s时的倾角和提前发力时间的关系');

f=80:100;
theta=zeros(size(f));
for i=1:length(f)
    F=[0,0,0,0,-0.1,0,0,-0.1;f(i),80,80,80,80,80,80,80];
    [~,~,theta(i)]=drum_angle(F,0.11,T);
end
figure
plot(f,theta);
title('第九组数据下鼓面在0.1s时的倾角和提前发力大小的关系');