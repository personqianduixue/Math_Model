clc,clear
Wt = 0:10000
Eb = 71.04*Wt.^(0.754);   % Eq
Ei = 98.67*Wt.^(0.754);   % Ei
Eq = 2273.28*Wt.^(0.754); % Eq
Ej = 3157.3*Wt.^(0.754);  % Ej

% the image of Eb and Ei
figure('position',[100,100,320,320])
plot(Wt,Eb,'-r','linewidth',1.5)
hold on
plot(Wt,Ei,'-b','linewidth',1.5)
gtext('E_{b}','Color','red','FontSize',14);
gtext('E_{i}','Color','blue','FontSize',14);
set(gca,'FontName','Times New Roman','FontSize',13)
xlabel('W_{t}(kg)')
ylabel('E(J/d)')
set(gca,'LineWidth',1)

% the image of Ej and Eq
figure('position',[100,100,320,320])
plot(Wt,Eq,'-r','linewidth',1.5)
hold on
plot(Wt,Ej,'-b','linewidth',1.5)
gtext('E_{q}','Color','red','FontSize',14);
gtext('E_{j}','Color','blue','FontSize',14);
set(gca,'FontName','Times New Roman','FontSize',14)
xlabel('W_{t}(kg)')
ylabel('E(J/d)')
set(gca,'LineWidth',1)
set('XLim',[0,10000])
