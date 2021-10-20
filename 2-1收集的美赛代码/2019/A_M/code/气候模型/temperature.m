% to plot temperature and growth
clc,clear,close all
% plot standard normal distribution probability density function
% Polar
figure('position',[0,0,320,320])
x = -10:0.1:20;
y = normpdf(x, 5, 12);
plot(x,y,'b','linewidth',1.5);
set(gca,'XLim',[-10,20])
hold on
x1 = [-10,-7.5,-5,-2.5,0,5,7.5,10,15,20];
y1 = [0.016,0.017,0.022,0.025,0.029,0.034,0.032,0.03,0.023,0.015]
plot(x1,y1,'r','linewidth',1.5);
xlabel('T/\circC ','LineWidth',12)
ylabel('v/mmol.s^{-1}')
grid on;

% temperate zone
figure('position',[0,0,320,320])
x = 0:0.1:30;
y = normpdf(x, 15, 4);
plot(x,y,'b','linewidth',1.5);
hold on
x1 = [2.5,5,7.5,10,12.5,15,17.5,20,22.5,25,27.5];
y1 = [0.001,0.007,0.018,0.043,0.078,0.095,0.076,0.044,0.016,0.006,0.002];
plot(x1,y1,'r','linewidth',1.5);
xlabel('T/\circC ','LineWidth',12)
ylabel('v/mmol.s^{-1}')
grid on;
hold on;


% drought zone
figure('position',[0,0,320,320])
x = 0:0.1:70;
y = normpdf(x, 35, 12);
plot(x,y,'b','linewidth',1.5);
set(gca,'XLim',[0,70])
hold on
x1 = [5,10,15,20,25,30,35,40,45,50,60];
y1 = [0.001,0.0035,0.006,0.01,0.016,0.026,0.032,0.025,0.017,0.013,0.003];
plot(x1,y1,'r','linewidth',1.5);
xlabel('T/\circC ','LineWidth',12)
ylabel('v/mmol.s^{-1}')
grid on;


    
