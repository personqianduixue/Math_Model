clc ;clear;close all
number=0;
f=1.482*cos(38.1*pi/180)+0.2045;
for n=1:fix(15/0.992)
    for m=3:40
       L=0.992*n;
        W=f*m-0.2045;
        S=L*W;
       if (S<=74)
        if number<m*n
            number=m*n;
            a=L;b=W;
        end
    end
    end
end   
number
a
b
