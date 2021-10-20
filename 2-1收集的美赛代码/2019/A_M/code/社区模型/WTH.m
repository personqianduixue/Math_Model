% to plot the relation of weigth between temperature and humidity
clc,clear
Tr = 0:1/2:50;   % range of the number of dragons
Hr = 0:100;  % range of weight
figure('position',[100,100,600,500])
[T,H] = meshgrid(Tr,Hr); 
Wt = weight(100,T,H)
surf(T,H,Wt)
colorbar
grid on;set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1); % 网格线使用虚线
xlabel('T')
ylabel('H')
zlabel('W_{t}')
