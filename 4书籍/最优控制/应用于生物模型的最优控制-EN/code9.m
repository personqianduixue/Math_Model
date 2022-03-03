function y = code9(r,K,mp,mf,P0,F0,O0,cp,cf,T)

test = -1;

delta = 0.001;
N = 1000;
t=linspace(0,T,N+1);
h=T/N;
h2 = h/2;

P=zeros(1,N+1);
F=zeros(1,N+1);
O=zeros(1,N+1);
P(1)=P0;
F(1)=F0;
O(1)=O0;

lambda1=zeros(1,N+1);
lambda2=zeros(1,N+1);
lambda3=zeros(1,N+1);

up=zeros(1,N+1);
uf=zeros(1,N+1);

while(test < 0)
   
    oldup = up;
    olduf = uf;
    oldP = P;
    oldF = F;
    oldO = O;
    oldlambda1 = lambda1;
    oldlambda2 = lambda2;
    oldlambda3 = lambda3;
    
    for i=1:N
        k11 = P(i)*(r - (r/K)*P(i) - up(i)) + (mf/K)*r*(1 - P(i)/K)*F(i)^2;
        k12 = F(i)*(r - (r/K)*F(i) - uf(i)) + (mp/K)*r*(1 - F(i)/K)*P(i)^2;
        k13 = (1 - mp)*(r/K)*P(i)^2 + (1 - mf)*(r/K)*F(i)^2 + (mf*r/K^2)*P(i)*F(i)^2 + (mp*r/K^2)*F(i)*P(i)^2;
        
        k21 = (P(i)+h2*k11)*(r - (r/K)*(P(i)+h2*k11) - 0.5*(up(i) + up(i+1))) + (mf/K)*r*(1 - (P(i)+h2*k11)/K)*(F(i)+h2*k12)^2;
        k22 = (F(i)+h2*k12)*(r - (r/K)*(F(i)+h2*k12) - 0.5*(uf(i) + uf(i+1))) + (mp/K)*r*(1 - (F(i)+h2*k12)/K)*(P(i)+h2*k11)^2;
        k23 = (1 - mp)*(r/K)*(P(i)+h2*k11)^2 + (1 - mf)*(r/K)*(F(i)+h2*k12)^2 + (mf*r/K^2)*(P(i)+h2*k11)*(F(i)+h2*k12)^2 + (mp*r/K^2)*(F(i)+h2*k12)*(P(i)+h2*k11)^2;
        
        k31 = (P(i)+h2*k21)*(r - (r/K)*(P(i)+h2*k21) - 0.5*(up(i) + up(i+1))) + (mf/K)*r*(1 - (P(i)+h2*k21)/K)*(F(i)+h2*k22)^2;
        k32 = (F(i)+h2*k22)*(r - (r/K)*(F(i)+h2*k22) - 0.5*(uf(i) + uf(i+1))) + (mp/K)*r*(1 - (F(i)+h2*k22)/K)*(P(i)+h2*k21)^2;
        k33 = (1 - mp)*(r/K)*(P(i)+h2*k21)^2 + (1 - mf)*(r/K)*(F(i)+h2*k22)^2 + (mf*r/K^2)*(P(i)+h2*k21)*(F(i)+h2*k22)^2 + (mp*r/K^2)*(F(i)+h2*k22)*(P(i)+h2*k21)^2;
        
        k41 = (P(i)+h*k31)*(r - (r/K)*(P(i)+h*k31) - up(i+1)) + (mf/K)*r*(1 - (P(i)+h*k31)/K)*(F(i)+h*k32)^2;
        k42 = (F(i)+h*k32)*(r - (r/K)*(F(i)+h*k32) - uf(i+1)) + (mp/K)*r*(1 - (F(i)+h*k32)/K)*(P(i)+h*k31)^2;
        k43 = (1 - mp)*(r/K)*(P(i)+h*k31)^2 + (1 - mf)*(r/K)*(F(i)+h*k32)^2 + (mf*r/K^2)*(P(i)+h*k31)*(F(i)+h*k32)^2 + (mp*r/K^2)*(F(i)+h*k32)*(P(i)+h*k31)^2;
        
        P(i+1) = P(i) + (h/6)*(k11 + 2*k21 + 2*k31 + k41);
        F(i+1) = F(i) + (h/6)*(k12 + 2*k22 + 2*k32 + k42);
        O(i+1) = O(i) + (h/6)*(k13 + 2*k23 + 2*k33 + k43);
    end
 
    for i = 1:N
        j = N + 2 - i;
        k11 = -lambda1(j)*(r - 2*(r/K)*P(j) - (mf*r/K^2)*F(j)^2 - up(j)) - lambda2(j)*(2*mp*(r/K)*(1 - F(j)/K)*P(j)) - lambda3(j)*(2*(r/K)*(1-mp)*P(j) + (mf*r/K^2)*F(j)^2 + 2*(mp*r/K^2)*P(j)*F(j));
        k12 = -lambda1(j)*(2*mf*(r/K)*(1 - P(j)/K)*F(j)) - lambda2(j)*(r - 2*(r/K)*F(j) - (mp*r/K^2)*P(j)^2 - uf(j)) - lambda3(j)*(2*(r/K)*(1-mf)*F(j) + (mp*r/K^2)*P(j)^2 + 2*(mf*r/K^2)*P(j)*F(j));
        k13 = -1;
        
        k21 = -(lambda1(j)-h2*k11)*(r - 2*(r/K)*0.5*(P(j)+P(j-1)) - (mf*r/K^2)*(0.5*(F(j)+F(j-1)))^2 - 0.5*(up(j)+up(j-1))) - (lambda2(j)-h2*k12)*(2*mp*(r/K)*(1 - 0.5*(F(j)+F(j-1))/K)*0.5*(P(j)+P(j-1))) - (lambda3(j)-h2*k13)*(2*(r/K)*(1-mp)*0.5*(P(j)+P(j-1)) + (mf*r/K^2)*(0.5*(F(j)+F(j-1)))^2 + 2*(mp*r/K^2)*0.5*(P(j)+P(j-1))*0.5*(F(j)+F(j-1)));
        k22 = -(lambda1(j)-h2*k11)*(2*mf*(r/K)*(1 - 0.5*(P(j)+P(j-1))/K)*0.5*(F(j)+F(j-1))) - (lambda2(j)-h2*k12)*(r - 2*(r/K)*0.5*(F(j)+F(j-1)) - (mp*r/K^2)*(0.5*(P(j)+P(j-1)))^2 - 0.5*(uf(j)+uf(j-1))) - (lambda3(j)-h2*k13)*(2*(r/K)*(1-mf)*0.5*(F(j)+F(j-1)) + (mp*r/K^2)*(0.5*(P(j)+P(j-1)))^2 + 2*(mf*r/K^2)*0.5*(P(j)+P(j-1))*0.5*(F(j)+F(j-1)));
        k23 = -1;
        
        k31 = -(lambda1(j)-h2*k21)*(r - 2*(r/K)*0.5*(P(j)+P(j-1)) - (mf*r/K^2)*(0.5*(F(j)+F(j-1)))^2 - 0.5*(up(j)+up(j-1))) - (lambda2(j)-h2*k22)*(2*mp*(r/K)*(1 - 0.5*(F(j)+F(j-1))/K)*0.5*(P(j)+P(j-1))) - (lambda3(j)-h2*k23)*(2*(r/K)*(1-mp)*0.5*(P(j)+P(j-1)) + (mf*r/K^2)*(0.5*(F(j)+F(j-1)))^2 + 2*(mp*r/K^2)*0.5*(P(j)+P(j-1))*0.5*(F(j)+F(j-1)));
        k32 = -(lambda1(j)-h2*k21)*(2*mf*(r/K)*(1 - 0.5*(P(j)+P(j-1))/K)*0.5*(F(j)+F(j-1))) - (lambda2(j)-h2*k22)*(r - 2*(r/K)*0.5*(F(j)+F(j-1)) - (mp*r/K^2)*(0.5*(P(j)+P(j-1)))^2 - 0.5*(uf(j)+uf(j-1))) - (lambda3(j)-h2*k23)*(2*(r/K)*(1-mf)*0.5*(F(j)+F(j-1)) + (mp*r/K^2)*(0.5*(P(j)+P(j-1)))^2 + 2*(mf*r/K^2)*0.5*(P(j)+P(j-1))*0.5*(F(j)+F(j-1)));
        k33 = -1;
        
        k41 = -(lambda1(j)-h*k31)*(r - 2*(r/K)*P(j-1) - (mf*r/K^2)*F(j-1)^2 - up(j-1)) - (lambda2(j)-h*k32)*(2*mp*(r/K)*(1 - F(j-1)/K)*P(j-1)) - (lambda3(j)-h*k33)*(2*(r/K)*(1-mp)*P(j-1) + (mf*r/K^2)*F(j-1)^2 + 2*(mp*r/K^2)*P(j-1)*F(j-1));
        k42 = -(lambda1(j)-h*k31)*(2*mf*(r/K)*(1 - P(j-1)/K)*F(j-1)) - (lambda2(j)-h*k32)*(r - 2*(r/K)*F(j-1) - (mp*r/K^2)*P(j-1)^2 - uf(j-1)) - (lambda3(j)-h*k33)*(2*(r/K)*(1-mf)*F(j-1) + (mp*r/K^2)*P(j-1)^2 + 2*(mf*r/K^2)*P(j-1)*F(j-1));
        k43 = -1;
        
        lambda1(j-1) = lambda1(j) - (h/6)*(k11 + 2*k21 + 2*k31 + k41);
        lambda2(j-1) = lambda2(j) - (h/6)*(k12 + 2*k22 + 2*k32 + k42);
        lambda3(j-1) = lambda3(j) - (h/6)*(k13 + 2*k23 + 2*k33 + k43);
    end
    
    tempp = (lambda1.*P)./(2*cp);
    up1 = min(1,max(0,tempp));
    up = 0.5*(up1 + oldup);
    tempf = (lambda2.*F)./(2*cf);
    uf1 = min(1,max(0,tempf));
    uf = 0.5*(uf1 + olduf);
    
    temp1 = delta*sum(abs(up)) - sum(abs(oldup - up));
    temp2 = delta*sum(abs(uf)) - sum(abs(olduf - uf));
    temp3 = delta*sum(abs(P)) - sum(abs(oldP - P));
    temp4 = delta*sum(abs(F)) - sum(abs(oldF - F));
    temp5 = delta*sum(abs(O)) - sum(abs(oldO - O));
    temp6 = delta*sum(abs(lambda1)) - sum(abs(oldlambda1 - lambda1));
    temp7 = delta*sum(abs(lambda2)) - sum(abs(oldlambda2 - lambda2));
    temp8 = delta*sum(abs(lambda3)) - sum(abs(oldlambda3 - lambda3));
    test = min(temp1, min(temp2, min(temp3, min(temp4, min(temp5, min(temp6, min(temp7,temp8)))))));
end

y(1,:) = t;
y(2,:) = P;
y(3,:) = F;
y(4,:) = O;
y(5,:) = up;
y(6,:) = uf;