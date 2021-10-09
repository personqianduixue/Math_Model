clear;clc;
BoardLength=120;BoardWidth=50;BoardThick=3;BarWidth=2.5;DeskHeight=53-BoardThick;
BarNumber=BoardWidth/BarWidth/2;
CircleRadial=BoardWidth/2;
SteelPosition=1/2;
BarLength=1/2*BoardLength-sqrt(CircleRadial^2-(CircleRadial-((1:BarNumber)-0.5)*BarWidth).^2);
angle=asin(DeskHeight/BarLength(1));
Barx=BoardLength*1/2-BarLength;
Bary=(BarNumber-0.5:-1:0.5)*BarWidth;
for i=1:10
    huacaochushi(i)=sqrt(SteelPosition^2*BarLength(1)^2+(Barx(1)-Barx(i))^2+2*SteelPosition*(Barx(1)-Barx(i))*BarLength(1));
    huacaozhong(i)=sqrt(SteelPosition^2*BarLength(1)^2+(Barx(1)-Barx(i))^2+2*SteelPosition*(Barx(1)-Barx(i))*BarLength(1)*cos(angle));
    huacaolength(i)=huacaozhong(i)-huacaochushi(i);
end
    SteelBarx=Barx(1)+SteelPosition*BarLength(1)*cos(angle);
    SteelBarz=SteelPosition*BarLength(1)*sin(angle);
for i=1:BarNumber
    alpha(i)=atan2(SteelBarz,(SteelBarx-Barx(i)));
    VBarz(i)=BarLength(i)*sin(alpha(i));
    VBarx(i)=Barx(i)+BarLength(i)*cos(alpha(i));
end
VBary=Bary;


%plot3(VBarx,VBary,VBarz,'-*')



 huacaochushi(i)=sqrt(1/4*BarLength(1)^2+(Barx(1)-Barx(i))^2+(Barx(1)-Barx(i))*BarLength(1));
  huacaozhong(i)=sqrt(1/4*BarLength(1)^2+(Barx(1)-Barx(i))^2+(Barx(1)-Barx(i))*BarLength(1)*cos(angle));