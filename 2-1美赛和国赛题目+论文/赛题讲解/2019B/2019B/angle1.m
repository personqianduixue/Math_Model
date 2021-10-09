function theta=angle1(x)
%只调整两个力的大小和时机
n=10;L=2;g=9.8;M=3.6; H0=0.2; h=0.6; m=0.27;
F=L/(4*n*M*H0^2)*(m*sqrt(2*g*h)+sqrt(2*m^2*g*h+4*M^2*H0*g))^2;     %第一问下的最小拉力
t0=pi/2*sqrt(M*L/n/F);                                            %第一问下的碰撞时刻（平衡态初始时刻t=0）
a=sqrt(2*g*h);
v0=a*[tan(pi/180)*cos(pi/15),tan(pi/180)*sin(pi/15),-1];
F=[zeros(1,n);F*ones(1,n)];
F(1,1)=x(1); F(1,2)=x(2); F(2,1)=x(3); F(2,2)=x(4);
[e,v]=drum_angle1(F,t0);
v1=dot(v0,e);
v2=v0-v1*e;
V1=dot(v,e);
v=((m-M)*v1+2*M*V1)/(M+m)*e+v2;
if v(3)<a
    theta=2;
else
    theta=acos(v(3)/norm(v))*180/pi;    
end