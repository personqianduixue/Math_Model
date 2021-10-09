%% 以下为辅助函数的程序，放于独立的的m文件中
function y=myfplotcircleGA(xx,rtmp,xmax,ymax)
% plot circle

xtmp=xx(1:6);
ytmp=xx(7:12);
numlen=length(xtmp);
numsize=200;
t=linspace(0,2.*pi,numsize);
xplot=zeros(numsize,1);
yplot=zeros(numsize,1);
hold on
for j=1:numlen
	for i=1:numsize
		xplot(i)=xtmp(j)+rtmp*cos(t(i));
		yplot(i)=ytmp(j)+rtmp*sin(t(i));
    end
    plot(xplot,yplot)
 
end
y=[];
xlim([0 xmax]);
ylim([0 ymax]);  
