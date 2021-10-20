% water modle
clc,clear
Wtr = 1:1000/40:1001; % the range of Weight 
Tr = 0:40;            % range of temperature

% the relationship between the water demand of dragons and body weight and temperature
figure('position',[100,100,320,320])
[Wt,T] = meshgrid(Wtr,Tr); 
V = 0.06*Wt.*exp(T./25-1);
surf(Wt,T,V)
colorbar
xlabel('W_{t}')
grid on;
set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1); % grid lines use dashed lines
set(gca,'XLim',[0 1000]);% the data display range of the X axis is [0,1000]
ylabel('T')
zlabel('V')