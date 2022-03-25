clc; clear;  %问题四
global xm L u0
L=50+30.5*11+5*10;
xm=[6.683140781153043e-04;2.498727636628837e+04;8.076275611754757e-04;1.431525270900793e+03;9.743913118484225e-04;8.279199794106737e+02;8.492734595661612e-04;6.547702252291799e+02;5.286841991732021e-04;1.337603876051590e+03];

[x, fv]=SelPSO(@area, 60 ,0.8, 2, 2,[185,205,245,265,10/6],[165,185,225,245,65/60],500,5);

v=x(5);F=[25,x(1),x(2),x(3),x(4),25];
T=L/v;
[S,s1,s2]=area1(x);
t=0:0.5:T;
k=find(u0==max(u0));
figure  
hold on
plot(t*v,f(v*t,F),t*v,u0,t*v,217*ones(length(t),1));
xlabel( '距离（cm）');ylabel('温度（℃）');
title('回焊炉内温度与炉温曲线比较图');

text(L,217,'T=217℃','color','b');
plot(t(k)*v,u0(k),'*');
text(t(k)*v,u0(k),['T=',num2str(u0(k)),'℃'],'color','b');
line([t(k)*v,t(k)*v],[0,270],'color','g');
text(t(k)*v,270,['x=',num2str(t(k)*v),'cm'],'color','b');
legend('回焊炉内温度曲线','炉温曲线');


function y=f(x,F)
l=5; L=30.5; s=25;
x1=0; x2=25;
x3=x2+5*L+4*l; x4=x3+l;
x5=x4+L;x6=x5+l;
x7=x6+L;x8=x7+l;
x9=x8+2*L+l;x10=x9+l;
y=((F(2)-F(1))/s.*(x-x1)+F(1)).*(x<=x2)+F(2).*(x>x2).*(x<=x3)+((F(3)-F(2))/l.*(x-x3)+F(2)).*(x>x3).*(x<=x4)+F(3).*(x>x4).*(x<=x5)...
+((F(4)-F(3))/l.*(x-x5)+F(3)).*(x>x5).*(x<=x6)+F(4).*(x>x6).*(x<=x7)...
+((F(5)-F(4))/l.*(x-x7)+F(4)).*(x>x7).*(x<=x8)+F(5).*(x>x8).*(x<=x9)...
+((F(6)-F(5))/l.*(x-x9)+F(5)).*(x>x9).*(x<=x10) + F(6).*(x>x10);
end

function t=heat(u1,u2,u3,u4,v)     
    global xm L
    F=[25,u1,u2,u3,u4,25]; T=L/v;
    L1=25+5*30.5+5*5; 
    L2=L1+30.5+5;
    L3=L2+30.5+5;
    t1=L1/v;t2=L2/v;t3=L3/v;
    dt=0.5; 
    m1=floor(t1/dt)+1;
    m2=floor(t2/dt)+1;
    m3=floor(t3/dt)+1;
   
    l=0.015; 
    x=1e-4; 
    r1=xm(1)^2*dt/(x^2);
    r2=xm(3)^2*dt/(x^2);
    r3=xm(5)^2*dt/(x^2);
    r4=xm(7)^2*dt/(x^2);
    r5=xm(9)^2*dt/(x^2);
    h1=xm(2);h2=xm(4);h3=xm(6);h4=xm(8);h5=xm(10);
    n=ceil(l/x)+1; m=floor(T/dt)+1;
    u=zeros(n,m);t=ones(m,1)*25;
    u(:,1)=25;
    u0=f(v*(0:floor(T/dt))*dt,F);
    k=ceil(l/2/x);
    A1=diag([1+h1*x,2*ones(1,n-2)*(1+r1),1+h1*x]);
    A1=A1+diag([-1,-r1*ones(1,n-2)],1);
    A1=A1+diag([-r1*ones(1,n-2),-1],-1);          
    B1=diag([0,2*ones(1,n-2)*(1-r1),0]);
    B1=B1+diag([0,r1*ones(1,n-2)],1);
    B1=B1+diag([r1*ones(1,n-2),0],-1);
    C1=A1\B1;
    c=zeros(n,m); c(1,:)=h1*u0*x; 
    c(n,:)=c(1,:);
    c=A1\c;    
    for j=1:m1-1
       u(:,j+1)=C1*u(:,j)+c(:,j+1);
       t(j+1)=u(k,j+1);
    end
    
    A2=diag([1+h2*x,2*ones(1,n-2)*(1+r2),1+h2*x]);
    A2=A2+diag([-1,-r2*ones(1,n-2)],1);
    A2=A2+diag([-r2*ones(1,n-2),-1],-1);          
    B2=diag([0,2*ones(1,n-2)*(1-r2),0]);
    B2=B2+diag([0,r2*ones(1,n-2)],1);
    B2=B2+diag([r2*ones(1,n-2),0],-1);
    C2=A2\B2;
    c=zeros(n,m); c(1,:)=h2*u0*x; 
    c(n,:)=c(1,:);
    c=A2\c;    
    for j=m1:m2-1
       u(:,j+1)=C2*u(:,j)+c(:,j+1);
       t(j+1)=u(k,j+1);
    end
    
    A3=diag([1+h3*x,2*ones(1,n-2)*(1+r3),1+h3*x]);
    A3=A3+diag([-1,-r3*ones(1,n-2)],1);
    A3=A3+diag([-r3*ones(1,n-2),-1],-1);          
    B3=diag([0,2*ones(1,n-2)*(1-r3),0]);
    B3=B3+diag([0,r3*ones(1,n-2)],1);
    B3=B3+diag([r3*ones(1,n-2),0],-1);
    C3=A3\B3;
    c=zeros(n,m); c(1,:)=h3*u0*x; 
    c(n,:)=c(1,:);
    c=A3\c;    
    for j=m2:m3-1
       u(:,j+1)=C3*u(:,j)+c(:,j+1);
       t(j+1)=u(k,j+1);
    end
        
    
    A4=diag([1+h4*x,2*ones(1,n-2)*(1+r4),1+h4*x]);
    A4=A4+diag([-1,-r4*ones(1,n-2)],1);
    A4=A4+diag([-r4*ones(1,n-2),-1],-1);          
    B4=diag([0,2*ones(1,n-2)*(1-r4),0]);
    B4=B4+diag([0,r4*ones(1,n-2)],1);
    B4=B4+diag([r4*ones(1,n-2),0],-1);
    C4=A4\B4;
    c4(1,:)=h4*u0*x; 
    c4(n,:)=c4(1,:);
    c4=A4\c4;    
        
    A5=diag([1+h5*x,2*ones(1,n-2)*(1+r5),1+h5*x]);
    A5=A5+diag([-1,-r5*ones(1,n-2)],1);
    A5=A5+diag([-r5*ones(1,n-2),-1],-1);          
    B5=diag([0,2*ones(1,n-2)*(1-r5),0]);
    B5=B5+diag([0,r5*ones(1,n-2)],1);
    B5=B5+diag([r5*ones(1,n-2),0],-1);
    C5=A5\B5;
    c5(1,:)=h5*u0*x; 
    c5(n,:)=c5(1,:);
    c5=A5\c5;    
    for j=m3:m-1
       if t(j)>=t(j-1)
            u(:,j+1)=C4*u(:,j)+c4(:,j+1);            
       else
           u(:,j+1)=C5*u(:,j)+c5(:,j+1); 
       end
       t(j+1)=u(k,j+1);
    end
end

function e=area(x)
global u0
    u0=heat(x(1),x(2),x(3),x(4),x(5));
    u=u0(u0>=30);
    tmp2=u(u>=217)-217;
    t2=length(tmp2)*0.5;
    umax=max(u);  
    tmp3=abs(u(2:length(u))-u(1:length(u)-1))/0.5;
    kmax=max(tmp3);
    s=u(u(2:length(u))>=u(1:length(u)-1));
    s=s(s>=150);
    s=s(s<=190);
    t1=length(s)*0.5;   
    y=logical((umax<=250)*(umax>=240)*(t2>=40)*(t2<=90)*(kmax<=3)*(t1<=120)*(t1>=60));
    if y
        k=find(tmp2==max(tmp2));
        if k>2
            a1=(sum(tmp2(1:k))-(tmp2(1)+tmp2(k))/2)*0.5;
        else
            a1=(tmp2(1)+tmp2(k))*0.5/2;
        end
        if length(tmp2)-k>2
            a2=(sum(tmp2(k:length(tmp2)))-(tmp2(length(tmp2))+tmp2(k))/2)*0.5;
        else
            a2=(tmp2(length(tmp2))+tmp2(k))/2*0.5;
        end
        e=max(abs(a1-a2)/max(a1,a2),abs(1+length(tmp2)-2*k)/max(k-1,length(tmp2)-k));
    else
        e=inf;
    end
end

function [a,sigma1,sigma2]=area1(x)
    global u0
    S=3.949241144080618e+02;
    u0=heat(x(1),x(2),x(3),x(4),x(5));
    u=u0(u0>=30);
    tmp2=u(u>=217)-217;
    t2=length(tmp2)*0.5;
    umax=max(u);  
    tmp3=abs(u(2:length(u))-u(1:length(u)-1))/0.5;
    kmax=max(tmp3);
    s=u(u(2:length(u))>=u(1:length(u)-1));
    s=s(s>=150);
    s=s(s<=190);
    t1=length(s)*0.5;   
    y=logical((umax<=250)*(umax>=240)*(t2>=40)*(t2<=90)*(kmax<=3)*(t1<=120)*(t1>=60));
    if y
        k=find(tmp2==max(tmp2));
        if k>2
            a=(sum(tmp2(1:k))-(tmp2(1)+tmp2(k))/2)*0.5;
        else
            a=(tmp2(1)+tmp2(k))*0.5/2;
        end
        if length(tmp2)-k>2
            a2=(sum(tmp2(k:length(tmp2)))-(tmp2(length(tmp2))+tmp2(k))/2)*0.5;
        else
            a2=(tmp2(length(tmp2))+tmp2(k))/2*0.5;
        end
        sigma1=max(abs(a-a2)/max(a,a2),abs(1+length(tmp2)-2*k)/max(k-1,length(tmp2)-k));
        sigma2=abs(a-S)/S;      
    else
        a=inf; sigma1=1;sigma2=1;
    end
end
