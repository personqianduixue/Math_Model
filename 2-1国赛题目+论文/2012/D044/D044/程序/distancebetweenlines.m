function mind=distancebetweenlines(A,B,C,D,M)
Ax=A(1);Ay=A(2);
Bx=B(1);By=B(2);
Cx=C(1);Cy=C(2);
Dx=D(1);Dy=D(2);
if (A(1)-B(1))~=0
    k=(By-Ay)/(Bx-Ax);
    b=By-k*Bx;
    ABXXL=linspace(A(1),B(1),M);
    ABYXL=k.*ABXXL+b;
else
    ABXXL=linspace(A(1),B(1),M);
    ABYXL=linspace(A(2),B(2),M);
end
if (C(1)-D(1))~=0
    k=(Dy-Cy)/(Dx-Cx);
    b=Dy-k*Dx;
    CDXXL=linspace(C(1),D(1),M);
    CDYXL=k.*CDXXL+b;
else
    CDXXL=linspace(C(1),D(1),M);
    CDYXL=linspace(C(2),D(2),M);
end
mind=100000;
for i=1:M
    for j=1:M
        if sqrt((ABXXL(i)-CDXXL(j))^2+(ABYXL(i)-CDYXL(j))^2)<=mind
            mind=sqrt((ABXXL(i)-CDXXL(j))^2+(ABYXL(i)-CDYXL(j))^2);
        end
    end
end
    