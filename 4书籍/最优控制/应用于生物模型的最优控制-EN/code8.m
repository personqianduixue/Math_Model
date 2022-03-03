function y = code8(s,m1,m2,m3,r,Tmax,k,N,T0,Ti0,V0,A,tfinal)

test = -1;

delta = 0.001;
M = 1000;
t=linspace(0,tfinal,M+1);
h=tfinal/M;
h2 = h/2;

T=zeros(1,M+1);
Ti=zeros(1,M+1);
V=zeros(1,M+1);
T(1)=T0;
Ti(1)=Ti0;
V(1)=V0;

lambda1=zeros(1,M+1);
lambda2=zeros(1,M+1);
lambda3=zeros(1,M+1);

u=zeros(1,M+1);

while(test < 0)
   
    oldu = u;
    oldT = T;
    oldTi = Ti;
    oldV = V;
    oldlambda1 = lambda1;
    oldlambda2 = lambda2;
    oldlambda3 = lambda3;
    
    for i=1:M
        k11 = s/(1 + V(i)) + T(i)*(-m1 + r*(1 - (T(i) + Ti(i))/Tmax) - u(i)*k*V(i));
        k12 = u(i)*k*V(i)*T(i) - m2*Ti(i);
        k13 = N*m2*Ti(i) - m3*V(i);
        
        k21 = s/(1 + (V(i)+h2*k13)) + (T(i)+h2*k11)*(-m1 + r*(1 - ((T(i)+h2*k11) + (Ti(i)+h2*k12))/Tmax) - 0.5*(u(i)+u(i+1))*k*(V(i)+h2*k13));
        k22 = 0.5*(u(i)+u(i+1))*k*(V(i)+h2*k13)*(T(i)+h2*k11) - m2*(Ti(i)+h2*k12);
        k23 = N*m2*(Ti(i)+h2*k12) - m3*(V(i)+h2*k13);
        
        k31 = s/(1 + (V(i)+h2*k23)) + (T(i)+h2*k21)*(-m1 + r*(1 - ((T(i)+h2*k21) + (Ti(i)+h2*k22))/Tmax) - 0.5*(u(i)+u(i+1))*k*(V(i)+h2*k23));
        k32 = 0.5*(u(i)+u(i+1))*k*(V(i)+h2*k23)*(T(i)+h2*k21) - m2*(Ti(i)+h2*k22);
        k33 = N*m2*(Ti(i)+h2*k22) - m3*(V(i)+h2*k23);
        
        k41 = s/(1 + (V(i)+h*k33)) + (T(i)+h*k31)*(-m1 + r*(1 - ((T(i)+h*k31) + (Ti(i)+h*k32))/Tmax) - u(i+1)*k*(V(i)+h*k33));
        k42 = u(i+1)*k*(V(i)+h*k33)*(T(i)+h*k31) - m2*(Ti(i)+h*k32);
        k43 = N*m2*(Ti(i)+h*k32) - m3*(V(i)+h*k33);
        
        T(i+1) = T(i) + (h/6)*(k11 + 2*k21 + 2*k31 + k41);
        Ti(i+1) = Ti(i) + (h/6)*(k12 + 2*k22 + 2*k32 + k42);
        V(i+1) = V(i) + (h/6)*(k13 + 2*k23 + 2*k33 + k43);
    end
 
    for i = 1:M
        j = M + 2 - i;
        k11 = -(A + lambda1(j)*(-m1 + r*(1 - (2*T(j) + Ti(j))/Tmax) - u(j)*k*V(j)) + lambda2(j)*(u(j)*k*V(j)));
        k12 = -(lambda1(j)*(-r*T(j)/Tmax) + lambda2(j)*(-m2) + lambda3(j)*(N*m2));
        k13 = -(lambda1(j)*(-s/((1+V(j))^2) - u(j)*k*T(j)) + lambda2(j)*(u(j)*k*T(j)) + lambda3(j)*(-m3));
        
        k21 = -(A + (lambda1(j)-h2*k11)*(-m1 + r*(1 - (2*0.5*(T(j)+T(j-1)) + 0.5*(Ti(j)+Ti(j-1)))/Tmax) - 0.5*(u(j)+u(j-1))*k*0.5*(V(j)+V(j-1))) + (lambda2(j)-h2*k12)*(0.5*(u(j)+u(j-1))*k*0.5*(V(j)+V(j-1))));
        k22 = -((lambda1(j)-h2*k11)*(-r*0.5*(T(j)+T(j-1))/Tmax) + (lambda2(j)-h2*k12)*(-m2) + (lambda3(j)-h2*k13)*(N*m2));
        k23 = -((lambda1(j)-h2*k11)*(-s/((1+0.5*(V(j)+V(j-1)))^2) - 0.5*(u(j)+u(j-1))*k*0.5*(T(j)+T(j-1))) + (lambda2(j)-h2*k12)*(0.5*(u(j)+u(j-1))*k*0.5*(T(j)+T(j-1))) + (lambda3(j)-h2*k13)*(-m3));
        
        k31 = -(A + (lambda1(j)-h2*k21)*(-m1 + r*(1 - (2*0.5*(T(j)+T(j-1)) + 0.5*(Ti(j)+Ti(j-1)))/Tmax) - 0.5*(u(j)+u(j-1))*k*0.5*(V(j)+V(j-1))) + (lambda2(j)-h2*k22)*(0.5*(u(j)+u(j-1))*k*0.5*(V(j)+V(j-1))));
        k32 = -((lambda1(j)-h2*k21)*(-r*0.5*(T(j)+T(j-1))/Tmax) + (lambda2(j)-h2*k22)*(-m2) + (lambda3(j)-h2*k23)*(N*m2));
        k33 = -((lambda1(j)-h2*k21)*(-s/((1+0.5*(V(j)+V(j-1)))^2) - 0.5*(u(j)+u(j-1))*k*0.5*(T(j)+T(j-1))) + (lambda2(j)-h2*k22)*(0.5*(u(j)+u(j-1))*k*0.5*(T(j)+T(j-1))) + (lambda3(j)-h2*k23)*(-m3));
        
        k41 = -(A + (lambda1(j)-h*k31)*(-m1 + r*(1 - (2*T(j-1) + Ti(j-1))/Tmax) - u(j-1)*k*V(j-1)) + (lambda2(j)-h*k32)*(u(j-1)*k*V(j-1)));
        k42 = -((lambda1(j)-h*k31)*(-r*T(j-1)/Tmax) + (lambda2(j)-h*k32)*(-m2) + (lambda3(j)-h*k33)*(N*m2));
        k43 = -((lambda1(j)-h*k31)*(-s/((1+V(j-1))^2) - u(j-1)*k*T(j-1)) + (lambda2(j)-h*k32)*(u(j-1)*k*T(j-1)) + (lambda3(j)-h*k33)*(-m3));
        
        lambda1(j-1) = lambda1(j) - (h/6)*(k11 + 2*k21 + 2*k31 + k41);
        lambda2(j-1) = lambda2(j) - (h/6)*(k12 + 2*k22 + 2*k32 + k42);
        lambda3(j-1) = lambda3(j) - (h/6)*(k13 + 2*k23 + 2*k33 + k43);
    end
    
    temp = ((lambda2 - lambda1).*k.*V.*T + 2)./2;
    u1 =  min(1, max(0, temp));
    u =  0.5*(u1 + oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(T)) - sum(abs(oldT - T));
    temp3 = delta*sum(abs(Ti)) - sum(abs(oldTi - Ti));
    temp4 = delta*sum(abs(V)) - sum(abs(oldV - V));
    temp5 = delta*sum(abs(lambda1)) - sum(abs(oldlambda1 - lambda1));
    temp6 = delta*sum(abs(lambda2)) - sum(abs(oldlambda2 - lambda2));
    temp7 = delta*sum(abs(lambda3)) - sum(abs(oldlambda3 - lambda3));
    test = min(temp1, min(temp2, min(temp3, min(temp4, min(temp5, min(temp6, temp7))))));
end

y(1,:) = t;
y(2,:) = T;
y(3,:) = Ti;
y(4,:) = V;
y(5,:) = u;