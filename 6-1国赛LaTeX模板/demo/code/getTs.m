function ts = getTs()
global T15 T06 T07 T89 T1011 v deltat l a b 
l=30.5;a=5;b=25;
%t=0:deltat:(11*l+10*a)/v;
len0=floor((b)/(v*deltat));
len1=floor((b+5*l+4*a)/(v*deltat));
len2=floor((b+5*l+5*a)/(v*deltat));
len3=floor((b+6*l+5*a)/(v*deltat));
len4=floor((b+6*l+6*a)/(v*deltat));
len5=floor((b+7*l+6*a)/(v*deltat));
len6=floor((b+7*l+7*a)/(v*deltat));
len7=floor((b+9*l+8*a)/(v*deltat));
len8=floor((b+9*l+9*a)/(v*deltat));
len9=floor((b+11*l+10*a+25)/(v*deltat));
ts(1:len0)=(T15-25)/(25/v)*deltat*[1:len0]+25;
ts(len0+1:len1)=T15;
ts(len1+1:len2)=(T06-T15)/(a/v)*deltat*[1:(len2-len1)]+T15;%429
ts(len2+1:len3)=T06;
ts(len3+1:len4)=(T07-T06)/(a/v)*deltat*[1:(len4-len3)]+T06;
ts(len4+1:len5)=T07;
ts(len5+1:len6)=(T89-T07)/(a/v)*deltat*[1:(len6-len5)]+T07;
ts(len6+1:len7)=T89;
ts(len7+1:len8)=(T1011-T89)/(a/v)*deltat*[1:(len8-len7)]+T89;
ts(len8+1:len9+1)=T1011;