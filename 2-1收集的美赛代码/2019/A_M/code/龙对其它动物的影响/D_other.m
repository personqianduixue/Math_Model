%% plot the dragon's influence on other creatures
D = [3, 3] % the initial number of dragons 
R = [10,3] % the initial number of other creatures
for i=1:2
    figure('position',[200,200,700,300])
    [T,Y]=ode45('zhibiao',[0:0.05: 10],[D(i),R(i)]);
    subplot(1,2,1);
    plot(T,Y(:,1),'-r',T,Y(:,2),'b','linewidth',1.5)
    xlabel('u')
    ylabel('D or R')
    gtext('R(u)'),gtext('D(u)');
    subplot(1,2,2)
    plot(Y(:,2),Y(:,1),'-k','linewidth',1.5)
    xlabel('R')
    ylabel('D')
end








