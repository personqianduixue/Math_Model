clear;clc;
BoardLength=120;BoardWidth=50;BoardThick=3;BarWidth=2.5;DeskHeight=53-3;
BarNumber=BoardWidth/BarWidth;
CircleRadial=BoardWidth/2;
BarLength=1/2*BoardLength-sqrt(CircleRadial^2-(CircleRadial-((1:10)-0.5)*BarWidth).^2);
angle=asin(DeskHeight/BarLength(1));
theta=linspace(0,angle,100);
Barx=BoardLength*1/2-BarLength;
Bary=(9.5:-1:0.5)*BarWidth;
for i=1:10
    BarLength(i)=1/2*BoardLength-sqrt(CircleRadial^2-(CircleRadial-(i-0.5)*BarWidth).^2);
    Barx(i)=BoardLength*1/2-BarLength(i);
   m(angle)=atan((1/2*BarLength(1)*sin(angle))/(Barx(1)+1/2*BarLength(1)*cos(angle)-Barx(i)));
   dm(angle)=diff(m(angle));
   plot(angle,m(angle))
end
angle
    
    