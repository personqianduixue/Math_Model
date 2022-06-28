 clc;clear;
 BoardLength=120;
 SteelPosition=0.5;
   BoardWidth=50;
  BoardThick=3;
    DeskHeight=53-BoardThick;
  BarWidth=2.5;  
  BarNumber=BoardWidth/BarWidth/2;
CircleRadial=BoardWidth/2;
Barx1=sqrt(CircleRadial^2-(CircleRadial-1/2*BarWidth)^2);
Bary1=CircleRadial-1/2*BarWidth;
BarLength1=1/2*BoardLength-Barx1;
Angle=asin(DeskHeight/BarLength1);
BarLength=1/2*BoardLength-sqrt(CircleRadial^2-(CircleRadial-((1:BarNumber)-0.5)*BarWidth).^2);
Barx=BoardLength*1/2-BarLength;
Bary=(BarNumber-0.5:-1:0.5)*BarWidth;
VBary=Bary;



c1=0;
for theta=linspace(0,Angle,10)
    c1=c1+1;
    for t= 0:pi/50:2*pi-pi/50;
        X=[CircleRadial*sin(t) CircleRadial*sin(t+pi/50) ];Y=[CircleRadial*cos(t) CircleRadial*cos(t+pi/50)];Z=[zeros(length(t)) zeros(length(t))];
        plot3(X,Y,Z)
        hold on
    end

SteelBarx=Barx1+SteelPosition*BarLength1*cos(theta);
SteelBary1=-Bary1;SteelBary2=Bary1;
SteelBarz=SteelPosition*BarLength1*sin(theta);
X=[SteelBarx SteelBarx];Y=[SteelBary1 SteelBary2];Z=[SteelBarz SteelBarz];
plot3(X,Y,Z);hold on
X=[-SteelBarx -SteelBarx];Y=[SteelBary1 SteelBary2];Z=[SteelBarz SteelBarz];
plot3(X,Y,Z);hold on
    for i=1:length(BarLength)
        alpha(i)=atan2(SteelBarz,(SteelBarx-Barx(i)));
        jiao(c1,i)=alpha(i);         
        
    end
    
    
end
jiaosu=zeros(9,10);
for i=1:9
    jiaosu(i,:)=jiao(i+1,:)-jiao(i,:);
end
jiaosuc=zeros(9,9);
for i=1:9
    jiaosuc(:,i)=jiaosu(:,i+1)./jiaosu(:,1);
end
hold off
plot(jiaosuc)
grid on





