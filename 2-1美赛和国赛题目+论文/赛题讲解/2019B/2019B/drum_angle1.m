function [e,v]=drum_angle1(F,T)
% F: 拉力及发力时间列表
% h: 鼓面下降高度
% T: 结束时间
% e: 鼓面单位法线
% v: 鼓速度
m=10;L=2; r0=0.2; dt=0.001;g=9.8;M=3.6;h=0.2;H=0.11;
F0=M*g*L/(m*h);    % 鼓在平衡位置时绳子的拉力
I=M*(r0^2/2+H^2/3);  % 鼓绕x轴或y轴的转动惯量I
J=M*r0^2;               % 鼓绕z轴的转动惯量J
X=zeros(m,3);   %X 玩家坐标， 第一个玩家在x轴正向
x=zeros(m,3); % x 相应的绳鼓端坐标
r1=zeros(m,3);  % 鼓心到绳鼓端的向量


t=min([0,F(1,:)]):dt:T;
e1=zeros(length(t),3); e2=e1;e3=e1;     %分配x,y,z轴单位向量内存
w=e1;                                   %分配角速度向量内存
e1(1,:)=[1,0,0]; e2(1,:)=[0,1,0]; e3(1,:)=[0,0,1];   %x,y,z轴初始单位向量
v=zeros(length(t),3);                   % 分配鼓平动速度向量内存        
c=v;                                    %分配鼓心坐标内存;
f=zeros(m,3);
for i=1:length(t)-1
    
    for j=1:m
        r1(j,:)=r0*(e1(i,:)*cos(2*pi*(j-1)/m)+e2(i,:)*sin(2*pi*(j-1)/m));
    end
    
    for j=1:m
        x(j,:)=r1(j,:)+c(i,:);
    end
    
    for j=1:m
      tmp=dot([x(j,1),x(j,2)],[cos(2*pi*(j-1)/m),sin(2*pi*(j-1)/m)])+sqrt(L^2-x(j,1)^2-x(j,2)^2-(x(j,3)-h)^2);  
      X(j,:)=[tmp*[cos(2*pi*(j-1)/m),sin(2*pi*(j-1)/m)],h];
    end
    
    
    Q=F0+(F(1,:)<=t(i)).*(F(2,:)-F0);
    for j=1:m
        f(j,:)=(Q(j))*(X(j,:)-x(j,:))/norm(X(j,:)-x(j,:));    %力向量
    end
    
    
    tmp1=sum(f)/M-[0,0,g];
    vp=v(i,:)+tmp1*dt;                                   %中间速度与鼓心坐标
    cp=c(i,:)+v(i,:)*dt;
     
       
    M0=zeros(1,3);   %力矩向量
    for j=1:m
        M0=M0+cross(r1(j,:),f(j,:));
    end
    
    M1=dot(M0,e1(i,:));                   % M在e1 方向的分量
    M2=dot(M0,e2(i,:));                   % M在e2 方向的分量
    M3=dot(M0,e3(i,:));                   % M在e3 方向的分量
    
    
    tmp=-(J/I-1)*w(i,2)*w(i,3)+M1/I;
    w1p=w(i,1)+tmp*dt;
    
    tmp=(J/I-1)*w(i,1)*w(i,3)+M2/I;
    w2p=w(i,2)+tmp*dt;
    
    tmp=M3/J;
    w3p=w(i,3)+tmp*dt;                           %新角速度向量： w(1)*e1+w(2)*e2+w3*e3
    
    tmp=cross(w(i,2)*e2(i,:)+w(i,3)*e3(i,:),e1(i,:));
    e1p=(e1(i,:)+tmp*dt)/(norm(e1(i,:)+tmp*dt));
    
    tmp=cross(w(i,1)*e1(i,:)+w(i,3)*e3(i,:),e2(i,:));
    e2p=(e2(i,:)+tmp*dt)/(norm(e2(i,:)+tmp*dt));
    
    tmp=cross(w(i,1)*e1(i,:)+w(i,2)*e2(i,:),e3(i,:));
    e3p=(e3(i,:)+tmp*dt)/(norm(e3(i,:)+tmp*dt));     %新的x,y,z轴
    
    for j=1:m
        r1(j,:)=r0*(e1p*cos(2*pi*(j-1)/m)+e2p*sin(2*pi*(j-1)/m));
    end
    
    for j=1:m
        x(j,:)=r1(j,:)+cp;
    end
    
    
    for j=1:m
      tmp=dot([x(j,1),x(j,2)],[cos(2*pi*(j-1)/m),sin(2*pi*(j-1)/m)])+sqrt(L^2-x(j,1)^2-x(j,2)^2-(x(j,3)-h)^2);  
      X(j,:)=[tmp*[cos(2*pi*(j-1)/m),sin(2*pi*(j-1)/m)],h];
    end                                                         %新的手端坐标
    
    for j=1:m
        f(j,:)=(Q(j))*(X(j,:)-x(j,:))/norm(X(j,:)-x(j,:));    
    end
    tmp1=sum(f)/M-[0,0,g];
    vc=v(i,:)+tmp1*dt;                                   %中间速度与鼓心坐标
    cc=c(i,:)+vp*dt;
    
     M0=zeros(1,3);   %力矩向量
    for j=1:m
        M0=M0+cross(r1(j,:),f(j,:));
    end
    
    M1=dot(M0,e1p);                   % M在e1 方向的分量
    M2=dot(M0,e2p);                   % M在e2 方向的分量
    M3=dot(M0,e3p);                   % M在e3 方向的分量
    
    
    tmp=-(J/I-1)*w2p*w3p+M1/I;
    w1c=w(i,1)+tmp*dt;
    
    tmp=(J/I-1)*w1p*w3p+M2/I;
    w2c=w(i,2)+tmp*dt;
    
    tmp=M3/J;
    w3c=w(i,3)+tmp*dt;                           %新角速度向量： w(1)*e1+w(2)*e2+w3*e3
    
    tmp=cross(w2p*e2p+w3p*e3p,e1p);
    e1c=(e1(i,:)+tmp*dt)/(norm(e1(i,:)+tmp*dt));
    
    tmp=cross(w1p*e1p+w3p*e3p,e2p);
    e2c=(e2(i,:)+tmp*dt)/(norm(e2(i,:)+tmp*dt));
    
    tmp=cross(w1p*e1p+w2p*e2p,e3p);
    e3c=(e3(i,:)+tmp*dt)/(norm(e3(i,:)+tmp*dt));     %新的x,y,z轴
    
    v(i+1,:)=(vp+vc)/2;
    c(i+1,:)=(cc+cp)/2;
    w(i+1,1)=(w1p+w1c)/2;
    w(i+1,2)=(w2p+w2c)/2;
    w(i+1,3)=(w3p+w3c)/2;
    e1(i+1,:)=(e1p+e1c)/2;
    e2(i+1,:)=(e2p+e2c)/2;
    e3(i+1,:)=(e3p+e3c)/2;    
end
[n,~]=size(v);
v=v(n,:);
e=e3(n,:);