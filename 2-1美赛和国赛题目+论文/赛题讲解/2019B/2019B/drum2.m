clear;
F1=[0,0,0,0,0,0,0,0;90,80,80,80,80,80,80,80];
F2=[0,0,0,0,0,0,0,0;90,90,80,80,80,80,80,80];
F3=[0,0,0,0,0,0,0,0;90,80,80,90,80,80,80,80];
F4=[-0.1,0,0,0,0,0,0,0;80,80,80,80,80,80,80,80];
F5=[-0.1,-0.1,0,0,0,0,0,0;80,80,80,80,80,80,80,80];
F6=[-0.1,0,0,-0.1,0,0,0,0;80,80,80,80,80,80,80,80];
F7=[-0.1,0,0,0,0,0,0,0;90,80,80,80,80,80,80,80];
F8=[0,-0.1,0,0,-0.1,0,0,0;90,80,80,90,80,80,80,80];
F9=[0,0,0,0,-0.1,0,0,-0.1;90,80,80,80,80,80,80,80];
theta0=zeros(9,1);
T=0.5;  T0=0.1; h=0.11;
[t,theta,a]=drum_angle(F1,h,T);
theta0(1)=a;
figure
hold on
ax1=subplot(5,2,1);
plot(ax1,t,theta);
hold on
plot(ax1,0.1,a,'*r');
text(ax1,0.1,a,num2str(a));
title(ax1,'第一组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F2,h,T);
theta0(2)=a;
ax2=subplot(5,2,3);
plot(ax2,t,theta);
hold on
plot(ax2,0.1,a,'*r');
text(ax2,0.1,a,num2str(a));
title(ax2,'第二组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F3,h,T);
theta0(3)=a;
ax3=subplot(5,2,5);
plot(ax3,t,theta);
hold on
plot(ax3,0.1,a,'*r');
text(ax3,0.1,a,num2str(a));
title(ax3,'第三组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F4,h,T);
theta0(4)=a;
ax4=subplot(5,2,7);
plot(ax4,t,theta);
hold on
plot(ax4,0.1,a,'*r');
text(ax4,0.1,a,num2str(a));
a=theta(find(t==0));
plot(ax4,0,a,'*r');
text(ax4,0,a,num2str(a));
title(ax4,'第四组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F5,h,T);
theta0(5)=a;
ax5=subplot(5,2,9);
plot(ax5,t,theta);
hold on
plot(ax5,0.1,a,'*r');
text(ax5,0.1,a,num2str(a));
a=theta(find(t==0));
plot(ax5,0,a,'*r');
text(ax5,0,a,num2str(a));
title(ax5,'第五组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F6,h,T);
theta0(6)=a;
ax6=subplot(5,2,2);
plot(ax6,t,theta);
hold on
plot(ax6,0.1,a,'*r');
text(ax6,0.1,a,num2str(a));
a=theta(find(t==0));
plot(ax6,0,a,'*r');
text(ax6,0,a,num2str(a));
title(ax6,'第六组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F7,h,T);
theta0(7)=a;
ax7=subplot(5,2,4);
plot(ax7,t,theta);
hold on
plot(ax7,0.1,a,'*r');
text(ax7,0.1,a,num2str(a));
a=theta(find(t==0));
plot(ax7,0,a,'*r');
text(ax7,0,a,num2str(a));
title(ax7,'第七组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F8,h,T);
theta0(8)=a;
ax8=subplot(5,2,6);
plot(ax8,t,theta);
hold on
plot(ax8,0.1,a,'*r');
text(ax8,0.1,a,num2str(a));
a=theta(find(t==0));
plot(ax8,0,a,'*r');
text(ax8,0,a,num2str(a));
title(ax8,'第八组数据下鼓面倾角和时间的关系');

[t,theta,a]=drum_angle(F9,h,T);
theta0(9)=a;
ax9=subplot(5,2,8);
plot(ax9,t,theta);
hold on
plot(ax9,0.1,a,'*r');
text(ax9,0.1,a,num2str(a));
a=theta(find(t==0));
plot(ax9,0,a,'*r');
text(ax9,0,a,num2str(a));
title(ax9,'第九组数据下鼓面倾角和时间的关系');