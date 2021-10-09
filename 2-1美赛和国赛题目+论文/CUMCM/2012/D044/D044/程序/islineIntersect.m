function z=islineIntersect(A,B,C,D)
Ax=A(1);Ay=A(2);
Bx=B(1);By=B(2);
Cx=C(1);Cy=C(2);
Dx=D(1);Dy=D(2);
if ((Bx-Ax)*(Dy-Cy)-(By-Ay)*(Dx-Cx))*((Bx-Ax)*(Dy-Cy)-(By-Ay)*(Dx-Cx))~=0
    r=((Ay-Cy)*(Dx-Cx)-(Ax-Cx)*(Dy-Cy))/((Bx-Ax)*(Dy-Cy)-(By-Ay)*(Dx-Cx));
    s=((Ay-Cy)*(Bx-Ax)-(Ax-Cx)*(By-Ay))/((Bx-Ax)*(Dy-Cy)-(By-Ay)*(Dx-Cx));
    if r>0&&r<=1&&s>0&&s<=1
        z=1;
    else
        z=0;
    end
else
    z=0;
end