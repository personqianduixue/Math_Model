%灵敏性分析
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global len0 len1 len2 len3 len4 len5
global alpha_beta
load alpha_beta1.mat
T1011=25;l=30.5;a=5;b=25;deltat=0.5;d=0.015;deltax=0.001;
x=[182.113972660114	189.859222123262	230.258078795877	264.984602768553	91.5833943649100	488.210219430565];
isOK=zeros(4,10);S=zeros(4,10);
for i=1:4
    for j=1:10
        y=x;
        y(i)=y(i)+(j-5)/10;
        [isOK(i,j),S(i,j)]=evaluateS2(y(1:5));
    end
end
D_S=(S-x(6))/x(6);
D_T=([1:10]-5)/10;
figure('Position',[454.6,349.8,591.2,335.9])
for i=1:4
    plot(D_T,D_S(i,:),'-'),hold on
end
for i=1:4
    for j=1:10
        if isOK(i,j)==0
            scatter(D_T(j),D_S(i,j),'r*')
        end
    end
end
legend('T15','T06','T07','T89','不满足约束'),xlabel('温区温度变化 \Delta T'),ylabel('面积相对变化\Delta S/S')
beautiplot
exportgraphics(gcf,'img\灵敏度分析.png','Resolution',400)        
        
        
function [isOK,Fitness]=evaluateS2(x)
global T15 T06 T07 T89 T1011 v deltat
global ts l a b  d deltax
global len0 len1 len2 len3 len4 len5
global alpha_beta
T15=x(1);T06=x(2);T07=x(3);T89=x(4);v=x(5)/60;
ts=getTs();
len0=floor((b)/(v*deltat));
len1=floor((b+5*l+4*a)/(v*deltat));
len2=floor((b+6*l+5*a)/(v*deltat));
len3=floor((b+7*l+6*a)/(v*deltat));
len4=floor((b+9*l+8*a)/(v*deltat));
len5=floor((b+11*l+10*a+25)/(v*deltat));

if abs(T15-175)>10||abs(T06-195)>10||abs(T07-235)>10||abs(T89-255)>10
    isOK=0;
end

T_Model=getTt(alpha_beta(1:5),alpha_beta(6));
[~,maxT_index]=max(T_Model);
up217_index=find(T_Model>217);
up217_T=T_Model(up217_index(1):maxT_index)-217;
up217_S=sum((up217_T(1:end-1)+up217_T(2:end))*deltat/2);
[isOK,~,~,~,~,~]=condition(T_Model);
Fitness=up217_S;
end
        