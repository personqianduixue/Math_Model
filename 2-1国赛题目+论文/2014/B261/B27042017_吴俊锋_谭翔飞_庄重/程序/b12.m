clear;clc;
BoardLength=120;BoardWidth=50;BoardThick=3;BarWidth=2.5;DeskHeight=53-BoardThick;
BarNumber=BoardWidth/BarWidth/2;
CircleRadial=BoardWidth/2;
SteelPosition=1/2;
h=0.1;
BarLength=1/2*BoardLength-sqrt(CircleRadial^2-(CircleRadial-((1:h:BarNumber)-0.5)*BarWidth).^2);
angle=asin(DeskHeight/BarLength(1));
Barx=BoardLength*1/2-BarLength;
Bary=(BarNumber-0.5:-h:0.5)*BarWidth;
    SteelBarx=Barx(1)+SteelPosition*BarLength(1)*cos(angle);
    SteelBarz=SteelPosition*BarLength(1)*sin(angle);
for i=1:length(BarLength)
    alpha(i)=atan2(SteelBarz,(SteelBarx-Barx(i)));
    VBarz(i)=BarLength(i)*sin(alpha(i));
    VBarx(i)=Barx(i)+BarLength(i)*cos(alpha(i));
end
VBary=Bary;
plot3(VBarx,VBary,VBarz,'-')



