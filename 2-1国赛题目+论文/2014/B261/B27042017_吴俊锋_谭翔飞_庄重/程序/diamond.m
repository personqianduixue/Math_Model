 clc;clear;
 BoardLength=120;
 SteelPosition=0.5;
   BoardWidth=50;
  BoardThick=3;
    DeskHeight=53-BoardThick;
  BarWidth=2.5;  
  xishu=1.2;
  BarNumber=BoardWidth/BarWidth/2;
Barx1=xishu*1/2*BarWidth;
Bary1=1/2*BoardWidth-1/2*BarWidth;
BarLength1=1/2*BoardLength-Barx1;
Angle=asin(DeskHeight/BarLength1);
BarLength=1/2*BoardLength-xishu*((1:BarNumber)-0.5)*BarWidth;
Barx=BoardLength*1/2-BarLength;
Bary=(BarNumber-0.5:-1:0.5)*BarWidth;
VBary=Bary;


the=linspace(0,Angle,10);

for theta=the
    
        X=xishu*[1/2*BoardWidth 0];Y=[0 1/2*BoardWidth];Z=[0 0];
        plot3(X,Y,Z)
        hold on
        X=xishu*[0 -1/2*BoardWidth];Y=[1/2*BoardWidth 0];Z=[0 0];
        plot3(X,Y,Z)
        hold on
         X=xishu*[-1/2*BoardWidth 0];Y=[0 -1/2*BoardWidth];Z=[0 0];
        plot3(X,Y,Z)
        hold on
          X=xishu*[0 1/2*BoardWidth];Y=[-1/2*BoardWidth 0];Z=[0 0];
        plot3(X,Y,Z)
        hold on


SteelBarx=Barx1+SteelPosition*BarLength1*cos(theta);
SteelBary1=-Bary1;SteelBary2=Bary1;
SteelBarz=SteelPosition*BarLength1*sin(theta);
X=[SteelBarx SteelBarx];Y=[SteelBary1 SteelBary2];Z=[SteelBarz SteelBarz];
plot3(X,Y,Z);hold on
X=[-SteelBarx -SteelBarx];Y=[SteelBary1 SteelBary2];Z=[SteelBarz SteelBarz];
plot3(X,Y,Z);hold on
   
   for i=1:length(BarLength)
        alpha(i)=atan2(SteelBarz,(SteelBarx-Barx(i)));
        VBarz(i)=BarLength(i)*sin(alpha(i));
        VBarx(i)=Barx(i)+BarLength(i)*cos(alpha(i));
        X=[Barx(i) VBarx(i)];Y=[Bary(i) VBary(i)];Z=[0 VBarz(i)];
        plot3(X,Y,Z);hold on
        X=[Barx(i) VBarx(i)] ;Y=[-Bary(i) -VBary(i)];Z=[0 VBarz(i)];
        plot3(X,Y,Z);hold on
       X=[-Barx(i) -VBarx(i)];Y=[Bary(i) VBary(i)];Z=[0 VBarz(i)];
       plot3(X,Y,Z);hold on
       X=[-Barx(i) -VBarx(i)];Y=[-Bary(i) -VBary(i)];Z=[0 VBarz(i)];
       plot3(X,Y,Z);hold on
            
        
    end
    
    
    for i=1:length(BarLength)-1
        
        X=[VBarx(i) VBarx(i+1)];Y=[VBary(i) VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
        plot3(X,Y,Z);hold on
        X=[VBarx(i) VBarx(i+1)] ;Y=[-VBary(i) -VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
        plot3(X,Y,Z);hold on
       X=[-VBarx(i) -VBarx(i+1)];Y=[VBary(i) VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
       plot3(X,Y,Z);hold on
       X=[-VBarx(i) -VBarx(i+1)];Y=[-VBary(i) -VBary(i+1)];Z=[VBarz(i) VBarz(i+1)];
       plot3(X,Y,Z);hold on
              
        
    end
    X=[VBarx(length(BarLength)) VBarx(length(BarLength))]; Y=[-VBary(length(BarLength)) VBary(length(BarLength))]; Z=[VBarz(length(BarLength)) VBarz(length(BarLength))];
     plot3(X,Y,Z);hold on
    X=[-VBarx(length(BarLength)) -VBarx(length(BarLength))]; Y=[-VBary(length(BarLength)) VBary(length(BarLength))]; Z=[VBarz(length(BarLength)) VBarz(length(BarLength))];
     plot3(X,Y,Z);hold on
    axis([-BoardLength/2-10 BoardLength/2+10 -BoardWidth-10 BoardWidth+10 0  DeskHeight+10])
    pause(0.1);
    hold off
 end






