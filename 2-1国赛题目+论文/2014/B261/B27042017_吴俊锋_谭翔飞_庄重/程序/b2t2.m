 clc;clear;
   BoardWidth=80;
  BoardThick=3;
    DeskHeight=70-BoardThick;
  BarWidth=2.5;  
  BL=120:380;SP=0.1:0.1:0.9;
  aw=10^8*ones(length(BL),length(SP));i=0;moca=0.5;u1=0.5;u2=1-u1;
 for BoardLength=BL
     i=i+1;
     j=0;
     for SteelPosition=SP
      j=j+1;
BarNumber=BoardWidth/BarWidth/2;
CircleRadial=BoardWidth/2;
Barx1=sqrt(CircleRadial^2-(CircleRadial-1/2*BarWidth)^2);
Bary1=CircleRadial-1/2*BarWidth;
BarLength1=1/2*BoardLength-Barx1;
Angle=asin(DeskHeight/BarLength1);
SteelBarx=Barx1+SteelPosition*BarLength1*cos(Angle);

SteelBary=Bary1;
SteelBarz=SteelPosition*BarLength1*sin(Angle);
Barxn=sqrt(CircleRadial^2-(1/2*BarWidth)^2);
huacao1=SteelPosition*BoardLength/2;
huacao2=Barxn+sqrt((SteelPosition*BarLength1)^2+(Barx1-Barxn)^2+2*SteelPosition*(Barx1-Barxn)*BarLength1*cos(Angle));
huacao=huacao2-huacao1;

if (tan(Angle)>1/moca*(1-(2*BarWidth*BarLength1)/(BoardLength*BoardWidth)))&&(huacao1>Barxn)&&(huacao2<1/2*BoardLength)
      aw(i,j)=u1*huacao+u2*BoardLength;
end
     end
 end
  [w,e]=find(aw==min(min(aw)));
  BL(w)
  SP(e)
   






