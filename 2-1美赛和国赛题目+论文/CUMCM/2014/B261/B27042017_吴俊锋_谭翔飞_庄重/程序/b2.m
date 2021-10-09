 clc;clear;
   BoardWidth=80;
  BoardThick=3;
    DeskHeight=67;
  BarWidth=2.5;  
  BL=140:280;SP=0.1:0.1:0.9;
  aw=zeros(length(BL),length(SP));i=0;u1=0.2;u2=0.3;u3=0.5;
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
Barx=CircleRadial;
huacao=(SteelPosition*BarLength1)^2+(Barx1-Barx)^2+2*SteelPosition*(Barx1-Barx)*BarLength1*cos(Angle);

      aw(i,j)=u1*(sqrt(SteelBarx^2+SteelBary^2)-CircleRadial)^2+u2*huacao+u3*BoardLength;
     end
 end
  [w,e]=find(aw==min(min(aw)))
   BL(w)
   SP(e)






