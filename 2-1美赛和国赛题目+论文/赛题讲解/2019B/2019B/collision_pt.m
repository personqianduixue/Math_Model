function collision_pt(F,t0)

clear;      %欧拉法求解鼓面翻转角
m=8;L=1.7; h=0.11; r0=0.2; dt=0.0001; C1=1;rho=1.2258;g=9.8;M=3.6; T=0.1;
R=sqrt(L^2-h^2)+r0;    %玩家所在圆半径
F0=M*g*L/(m*(R-r0));    % 鼓在平衡位置时绳子的拉力
S=pi*r0^2;   % 鼓面面积
I=M*(r0^3/4+r0^2*h+r0*h^2+2*h^3/3)/(r0+2*h);  % 鼓转动惯量I
J=M*(r0^3+4*r0^2*h)/(2*r0+4*h);               % 鼓转动惯量J
X=zeros(8,3);   %X 玩家坐标， 第一个玩家在x轴正向
x=zeros(8,3); % x 相应的绳鼓端坐标
r1=zeros(8,3);  % 鼓心到绳鼓端的向量
F=[0,0,0,0,80,0,0,80;90,80,80,80,80,80,80,80];
a=sqrt(2)/2;

X(1,:)=R*[1,0,0];X(2,:)=R*[a,a,0];X(3,:)=R*[0,1,0];X(4,:)=R*[-a,a,0];
X(5,:)=-X(1,:);X(6,:)=-X(2,:); X(7,:)=-X(3,:);X(8,:)=-X(4,:);
X(:,3)=X(:,3)+h;  
x(1,:)=r0*[1,0,0];x(2,:)=r0*[a,a,0];x(3,:)=r0*[0,1,0];x(4,:)=r0*[-a,a,0];
x(5,:)=-x(1,:);x(6,:)=-x(2,:); x(7,:)=-x(3,:);x(8,:)=-x(4,:);

if any(F(1,:))
    t=-0.1:dt:T;
else
    t=0:dt:T;
end
v=zeros(length(t),3); w1=v;w2=zeros(length(t),1); theta1=w2;theta2=w2; c=v; n=v; n(1,:)=[0,0,1]; %初始化 v 速度；w1,w2 角速度；theta1: 鼓面翻转角度 theta2: 绕鼓法向的旋转角；c 鼓心坐标；n 鼓面单位法向;
f=zeros(8,3);f1=f;
for i=1:length(t)-1
    if t(i)<0
        Q=F(1,:)+F0;        
    else
        Q=F(2,:)+F0;
    end
    for j=1:8
        f(j,:)=(Q(j))*(X(j,:)-x(j,:))/norm(X(j,:)-x(j,:));
        f1(j,:)=dot(f(j,:),n(i,:))*n(i,:);
    end
    tmp1=sum(f)/M-[0,0,g]-C1*rho*S*norm(v(i,:))*v(i,:)/(2*M);
    v(i+1,:)=v(i,:)+tmp1*dt;
    c(i+1,:)=c(i,:)+v(i,:)*dt;
    tmp21=zeros(8,3); tmp22=0;
    for j=1:8
        r1(j,:)=x(j,:)-c(i,:);
        tmp21(j,:)=cross(r1(j,:),f1(j,:));
        tmp22=tmp22+dot(cross(r1(j,:),f(j,:)),n(i,:));
    end
    tmp31=sum(tmp21)/I;  tmp32=tmp22/J;
    w1(i+1,:)=w1(i,:)+tmp31*dt;
    w2(i+1)=w2(i)+tmp32*dt;
    theta2(i+1)=theta2(i)+w2(i)*dt;
    tmp4=cross(w1(i,:),n(i,:));
    if ~norm(tmp4)
        n(i+1,:)=n(i,:);        
    else
        n(i+1,:)=n(i,:)*cos(norm(w1(i,:))*dt)+tmp4/norm(tmp4)*sin(norm(w1(i,:))*dt);
    end
    xc=zeros(8,3);
    r1c=zeros(8,3);
    for j=1:8
        e2=r1(j,:)/r0;
        if theta2(i+1)-theta2(i)>0
            e1=n(i,:);e3=cross(e1,e2);
            r1c(j,:)=r0*(e2*cos(w2(i)*dt)+e3*sin(w2(i)*dt));
        elseif theta2(i+1)-theta2(i)<0
            e1=-n(i,:);e3=cross(e1,e2);
            r1c(j,:)=r0*(e2*cos(w2(i)*dt)+e3*sin(w2(i)*dt));
        else
            r1c(j,:)=r1(j,:);
        end   
    end
    if ~norm(w1(i,:))
        x(:,1)=r1c(:,1)+c(i+1,1);
        x(:,2)=r1c(:,2)+c(i+1,2);
        x(:,3)=r1c(:,3)+c(i+1,3);
    else
        e1=w1(i,:)/norm(w1(i,:));
        e2=tmp4/norm(tmp4);
        for j=1:8          
          r1(j,:)=dot(r1c(j,:),e1)*e1+dot(r1c(j,:),e2)*(dot(n(i+1,:),n(i,:))*e2-n(i,:)*norm(cross(n(i+1,:),n(i,:))));
          x(j,:)=r1(j,:)+c(i+1,:);            
        end
    end    
end   
for i=1:length(t)
    theta1(i)=acos(dot(n(1,:),n(i,:)))*180/pi;
end