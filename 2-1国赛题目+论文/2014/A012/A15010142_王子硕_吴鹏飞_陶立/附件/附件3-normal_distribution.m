minx=1;
maxx=100;
n=100000;
data= round((minx+maxx)/2 + 10*randn(1,n));
plotx=1:5:101;
p=hist(data,plotx)/n;
sump=cumsum(p);
axis([1 100 0 0.2]);
subplot(1,2,1) 
bar(plotx,p);
axis([1 100 0 0.2]);
title('概率密度') 
subplot(1,2,2) 
plot(plotx,sump);
title('累积概率密度')