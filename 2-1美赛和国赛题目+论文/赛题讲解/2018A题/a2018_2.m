clc; clear;

%第三问解答, 取L2=19.2750;  成本重量最小
l1=19.25; l2=19.3;
while 1
    t=(l1+l2)/2;
    u=heatequation(80,1800,t,6.4);
    if u(1801)<=47 && u(1501)<=44
        l2=t;
    else 
        l1=t;
    end
    if l2-l1<0.001
        break;
    end
end




%第二问解答
l1=0.6; l2=25;
while 1
    t=(l1+l2)/2;
    u=heatequation(65,3600,t,5.5);
    if u(3601)<=47 && u(55*60+1)<=44
        l2=t;
    else 
        l1=t;
    end
    if l2-l1<0.01
        break;
    end
end
% 可得最佳l2=17.5954
function  u=heatequation(u0,T,l2,l4)
    k=[0.082 0.37 0.045 0.028];c=[1377 2100 1726 1005];density=[300 862 74.2 1.18];
    l=[6e-4 l2*1e-3 3.6e-3 l4*1e-3]; u1=37;   h0=122.3928; h1=8.37;
    x=1e-5; 
    r=k./(c.*density.*x*x);
    n=int16(l/x);m=sum(n)+1;
    u=zeros(m,T+1);
    u(:,1)=37;
    
    A=diag([k(1)+h0*x,2*ones(1,n(1)-1)*(1+r(1)),k(1)+k(2),2*ones(1,n(2)-1)*(1+r(2)),k(2)+k(3),2*ones(1,n(3)-1)*(1+r(3)),k(3)+k(4),2*ones(1,n(4)-1)*(1+r(4)),k(4)+h1*x]);
    A=A+diag([-k(1),-r(1)*ones(1,n(1)-1),-k(2),-r(2)*ones(1,n(2)-1),-k(3),-r(3)*ones(1,n(3)-1),-k(4),-r(4)*ones(1,n(4)-1)],1);
    A=A+diag([-r(1)*ones(1,n(1)-1),-k(1),-r(2)*ones(1,n(2)-1),-k(2),-r(3)*ones(1,n(3)-1),-k(3),-r(4)*ones(1,n(4)-1),-k(4)],-1);

    B=diag([0,2*ones(1,n(1)-1)*(1-r(1)),0,2*ones(1,n(2)-1)*(1-r(2)),0,2*ones(1,n(3)-1)*(1-r(3)),0,2*ones(1,n(4)-1)*(1-r(4)),0]);
    B=B+diag([0,r(1)*ones(1,n(1)-1),0,r(2)*ones(1,n(2)-1),0,r(3)*ones(1,n(3)-1),0,r(4)*ones(1,n(4)-1)],1);
    B=B+diag([r(1)*ones(1,n(1)-1),0,r(2)*ones(1,n(2)-1),0,r(3)*ones(1,n(3)-1),0,r(4)*ones(1,n(4)-1),0],-1);
    C=A\B;
    c=zeros(m,1); c(1)=h0*u0*x; c(m)=h1*u1*x; 
    c=A\c;
    for j=1:T
        u(:,j+1)=C*u(:,j)+c;
    end
    u=u(m,:)';
end