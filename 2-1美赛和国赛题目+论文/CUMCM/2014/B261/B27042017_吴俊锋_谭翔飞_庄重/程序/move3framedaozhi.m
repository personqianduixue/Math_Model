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


framenum=10;
the=linspace(0,Angle,framenum);
for theta=the(3)
    for t= 0:pi/50:2*pi-pi/50;
        X=[CircleRadial*sin(t) CircleRadial*sin(t+pi/50) ];Y=[CircleRadial*cos(t) CircleRadial*cos(t+pi/50)];Z=[zeros(length(t)) zeros(length(t))];
        plot3(X,Y,-Z)
        hold on
    end

SteelBarx=Barx1+SteelPosition*BarLength1*cos(theta);
SteelBary1=-Bary1;SteelBary2=Bary1;
SteelBarz=SteelPosition*BarLength1*sin(theta);
X=[SteelBarx SteelBarx];Y=[SteelBary1 SteelBary2];Z=[SteelBarz SteelBarz];
plot3(X,Y,-Z);hold on
X=[-SteelBarx -SteelBarx];Y=[SteelBary1 SteelBary2];Z=[SteelBarz SteelBarz];
plot3(X,Y,-Z);hold on
    for i=1:length(BarLength)
        alpha(i)=atan2(SteelBarz,(SteelBarx-Barx(i)));
        VBarz(i)=BarLength(i)*sin(alpha(i));
        VBarx(i)=Barx(i)+BarLength(i)*cos(alpha(i));
        X=[Barx(i) VBarx(i)];Y=[Bary(i) VBary(i)];Z=[0 VBarz(i)];
        plot3(X,Y,-Z);hold on
        X=[Barx(i) VBarx(i)] ;Y=[-Bary(i) -VBary(i)];Z=[0 VBarz(i)];
        plot3(X,Y,-Z);hold on
       X=[-Barx(i) -VBarx(i)];Y=[Bary(i) VBary(i)];Z=[0 VBarz(i)];
       plot3(X,Y,-Z);hold on
       X=[-Barx(i) -VBarx(i)];Y=[-Bary(i) -VBary(i)];Z=[0 VBarz(i)];
       plot3(X,Y,-Z);hold on
            
        
    end
    
    
    for i=1:length(BarLength)-1
        
        X=[VBarx(i) VBarx(i+1)];Y=[VBary(i) VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
        plot3(X,Y,-Z);hold on
        X=[VBarx(i) VBarx(i+1)] ;Y=[-VBary(i) -VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
        plot3(X,Y,-Z);hold on
       X=[-VBarx(i) -VBarx(i+1)];Y=[VBary(i) VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
       plot3(X,Y,-Z);hold on
       X=[-VBarx(i) -VBarx(i+1)];Y=[-VBary(i) -VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
       plot3(X,Y,-Z);hold on
              
        
    end
    
    
    X=[VBarx(length(BarLength)) VBarx(length(BarLength))]; Y=[-VBary(length(BarLength)) VBary(length(BarLength))]; Z=[VBarz(length(BarLength)) VBarz(length(BarLength))];
     plot3(X,Y,-Z);hold on
    X=[-VBarx(length(BarLength)) -VBarx(length(BarLength))]; Y=[-VBary(length(BarLength)) VBary(length(BarLength))]; Z=[VBarz(length(BarLength)) VBarz(length(BarLength))];
     plot3(X,Y,-Z);hold on
    axis([-BoardLength/2-10 BoardLength/2+10 -BoardWidth-10 BoardWidth+10 0  -(DeskHeight+10)])
    pause(0.1);
    hold off
end






