function z=huchang(A,B,C,r)
%C为圆心坐标
%A,B为圆弧端点坐标,r为半径
D=dot(A-C,B-C)/(norm(A-C)*norm(B-C));%ｄｏｔ向量点积
theta=acos(D);%弧度表示
z=theta*r;
