function y = code13(a,b,A,B,d1,d2,M,N10,N20,T)

flag = -1;

z = sweep(a,A,d1,d2,M,N10,N20,T);
Ta = z(5,1001) - B;
disp('1 iteration completed.')
z = sweep(b,A,d1,d2,M,N10,N20,T);
Tb = z(5,1001) - B;
disp('2 iterations completed.')

n = 2;

while(flag < 0)
    if(abs(Ta) > abs(Tb))
        t = a;
        a = b;
        b = t;
        t = Ta;
        Ta = Tb;
        Tb = t;
    end

    d = Ta*(b - a)/(Tb - Ta);
    b = a;
    Tb = Ta;
    a = a - d;
    z = sweep(a,A,d1,d2,M,N10,N20,T);
    Ta = z(5,1001) - B;
    
    if(abs(Ta) < 1E-10)
        flag = 1;
    else
        n = n+1;
        disp([num2str(n) ' iterations completed.'])
    end
end

disp(['Final guess was ' num2str(a) '.'])

y = z;

%--------------------------------------------------------------------------
function y = sweep(theta,A,d1,d2,M,N10,N20,T)

test = -1;

delta = 0.001;
N = 1000;
t = linspace(0,T,N+1);
h = T/N;
h2 = h/2;

N1 = zeros(1,N+1);
N2 = zeros(1,N+1);
z = zeros(1,N+1);
N1(1) = N10;
N2(1) = N20;

lambda1 = zeros(1,N+1);
lambda1(N+1) = 1;
lambda2 = zeros(1,N+1);
lambda3 = zeros(1,N+1) + theta;

u = zeros(1,N+1);

while(test < 0)
    
    oldu = u;
    oldN1 = N1;
    oldN2 = N2;
    oldz = z;
    oldlambda1 = lambda1;
    oldlambda2 = lambda2;
    oldlambda3 = lambda3;
    
    for i=1:N
        m11 = (1 - N2(i) - d1*u(i))*N1(i);
        m12 = (N1(i) - 1 - d2*u(i))*N2(i);
        m13 = u(i);
        
        m21 = (1 - (N2(i)+h2*m12) - d1*0.5*(u(i) + u(i+1)))*(N1(i)+h2*m11);
        m22 = ((N1(i)+h2*m11) - 1 - d2*0.5*(u(i) + u(i+1)))*(N2(i)+h2*m12);
        m23 = 0.5*(u(i) + u(i+1));
        
        m31 = (1 - (N2(i)+h2*m22) - d1*0.5*(u(i) + u(i+1)))*(N1(i)+h2*m21);
        m32 = ((N1(i)+h2*m21) - 1 - d2*0.5*(u(i) + u(i+1)))*(N2(i)+h2*m22);
        m33 = 0.5*(u(i) + u(i+1));
        
        m41 = (1 - (N2(i)+h*m32) - d1*u(i+1))*(N1(i)+h*m31);
        m42 = ((N1(i)+h*m31) - 1 - d2*u(i+1))*(N2(i)+h*m32);
        m43 = u(i+1);
        
        N1(i+1) = N1(i) + (h/6)*(m11 + 2*m21 + 2*m31 + m41);
        N2(i+1) = N2(i) + (h/6)*(m12 + 2*m22 + 2*m32 + m42);
        z(i+1) = z(i) + (h/6)*(m13 + 2*m23 + 2*m33 + m43);
    end
    
    for i = 1:N
        j = N + 2 - i;
        m11 = -lambda1(j)*(1 - N2(j) - d1*u(j)) - N2(j)*lambda2(j);
        m12 = -lambda2(j)*(N1(j) - 1 - d2*u(j)) + N1(j)*lambda1(j);
        
        m21 = -(lambda1(j)-h2*m11)*(1 - 0.5*(N2(j)+N2(j-1)) - d1*0.5*(u(j)+u(j-1))) - 0.5*(N2(j)+N2(j-1))*(lambda2(j)-h2*m12);
        m22 = -(lambda2(j)-h2*m12)*(0.5*(N1(j)+N1(j-1)) - 1 - d2*0.5*(u(j)+u(j-1))) + 0.5*(N1(j)+N1(j-1))*(lambda1(j)-h2*m11);
        
        m31 = -(lambda1(j)-h2*m21)*(1 - 0.5*(N2(j)+N2(j-1)) - d1*0.5*(u(j)+u(j-1))) - 0.5*(N2(j)+N2(j-1))*(lambda2(j)-h2*m22);
        m32 = -(lambda2(j)-h2*m22)*(0.5*(N1(j)+N1(j-1)) - 1 - d2*0.5*(u(j)+u(j-1))) + 0.5*(N1(j)+N1(j-1))*(lambda1(j)-h2*m21);
        
        m41 = -(lambda1(j)-h*m31)*(1 - N2(j-1) - d1*u(j-1)) - N2(j-1)*(lambda2(j)-h*m32);
        m42 = -(lambda2(j)-h*m32)*(N1(j-1) - 1 - d2*u(j-1)) + N1(j-1)*(lambda1(j)-h*m31);
        
        lambda1(j-1) = lambda1(j) - (h/6)*(m11 + 2*m21 + 2*m31 + m41);
        lambda2(j-1) = lambda2(j) - (h/6)*(m12 + 2*m22 + 2*m32 + m42);
    end
        
    temp = (d1*N1.*lambda1 + d2*N2.*lambda2 - lambda3)/A;
    u1 = min(M,max(0,temp));
    u = 0.5*(u1 + oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(N1)) - sum(abs(oldN1 - N1));
    temp3 = delta*sum(abs(N2)) - sum(abs(oldN2 - N2));
    temp4 = delta*sum(abs(z)) - sum(abs(oldz - z));
    temp5 = delta*sum(abs(lambda1)) - sum(abs(oldlambda1 - lambda1));
    temp6 = delta*sum(abs(lambda2)) - sum(abs(oldlambda2 - lambda2));
    test = min(temp1, min(temp2, min(temp3, min(temp4, min(temp5, temp6)))));
end

y(1,:) = t;
y(2,:) = N1;
y(3,:) = N2;
y(4,:) = u;
y(5,:) = z;