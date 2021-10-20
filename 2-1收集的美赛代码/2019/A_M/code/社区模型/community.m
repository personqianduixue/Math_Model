%% the model of community
clc,clear,close all
t = 100       % age
T = 1:100;    % temperature 
H = 1:100;    % relative humidity
D_1 = 1;      % the number of dragon is 1
T0 = 25;      % the optimum temperature is 25 degrees
BF = 0.1;     % conversion rate
[T,H] = meshgrid(T,H)
%% living area required for raising one dragons
% daily food demand
Fw = 98.67.*weight(t,T,H).^(0.754)./BF
%% daily water demand
V = 0.06.*weight(t,T,H).*exp(T/T0-1);

%% plot
% Relationship between living area and weight  
Wt = 10:100000;
A_1 = 1*1000./(Wt.^(-0.8)*log2(3+1));
figure('position',[100,100,320,320])
plot(Wt,A_1,'b','linewidth',1.5);
xlabel('W_{t}(kg)')
ylabel('A(m^{2})')
set(gca,'FontName','Times New Roman','FontSize',14)
set(gca,'LineWidth',1)

% The relationship between daily food demand and temperature and humidity  
figure('position',[100,100,650,500])
surf(T,H,Fw)
colorbar
grid on;set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1); % 网格线使用虚线
xlabel('T')
ylabel('H')
zlabel('F')

% The relationship between daily water demand and temperature and humidity 
figure('position',[100,100,650,500])
surf(T,H,V)
colorbar
grid on;set(gca,'GridLineStyle',':','GridColor','k','GridAlpha',1); % 网格线使用虚线
xlabel('T')
ylabel('H')
zlabel('V')