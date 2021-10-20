%% to plot relationship between living area and the number and weight of dragons
clc,clear
Dr = 1:2:100   % range of the number of dragons
Wtr = 1:2:100  % range of weight
figure('position',[100,100,400,400])
[D,Wt] = meshgrid(Dr,Wtr); 
A = D*1000./(Wt.^(-0.8).*log2(D+1));
surf(D,Wt,A)
colorbar
grid on;set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1); % grid lines use dashed lines
xlabel('D')
ylabel('W_{t}')
zlabel('A')

