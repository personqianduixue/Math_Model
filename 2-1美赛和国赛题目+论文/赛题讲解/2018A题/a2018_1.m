clc;
filename="CUMCM-2018-Problem-A-Chinese-Appendix.xlsx";
E=xlsread(filename,2);
E=E(:,2);

% 第三次优化 得h1=8.37, h0=122.3928;  min=0.3496
h0=h(8.36); h1=8.36;
u=heatequation(122.41,h1);
tmp=u-E;
min=sum(tmp.*tmp); 


for i=8.3:0.01:8.7
  u=heatequation(h(i),i);
  tmp=u-E;
  min1=sum(tmp.*tmp);
  if min1<min
      min=min1; h1=h(i); h0=i;
  end
end




% 第二次优化 得h1=8.4
h0=h(8); h1=8;
u=heatequation(h0,h1);
tmp=u-E;
min=sum(tmp.*tmp); 


for i=7.5:0.1:8.5
  u=heatequation(h(i),i);
  tmp=u-E;
  min1=sum(tmp.*tmp);
  if min1<min
      min=min1; h1=h(i); h0=i;
  end
end




%第一次优化， 得h1=8;
h0=h(3); h1=3;
u=heatequation(h0,h1);
tmp=u-E;
min=sum(tmp.*tmp); 


for i=3:10
  u=heatequation(h(i),i);
  tmp=u-E;
  min1=sum(tmp.*tmp);
  if min1<min
      min=min1; h1=h(i); h0=i;
  end
end
        



function h1=h(t)
    k=[0.082 0.37 0.045 0.028];l=[6e-4 6e-3 3.6e-3 5e-3]; u0=75;u1=37; u=48.08;
    t1=sum(l./k);
    h1=t*(u-u1)/(u0-u+t*(u1-u)*t1);
end




function  u=heatequation(h0,h1)
    k=[0.082 0.37 0.045 0.028];c=[1377 2100 1726 1005];density=[300 862 74.2 1.18];
    l=[6e-4 6e-3 3.6e-3 5e-3]; T=90*60; u0=75;u1=37;   
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
    c=zeros(m,1); c(1)=h0*u0*x; c(m)=h1*u1*x; c=A\c;
    for j=1:T
        u(:,j+1)=C*u(:,j)+c;
    end
    u=u(m,:)';
end