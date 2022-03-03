function y = code10(a,b,c,x10,A,l,T)

test = -1;

delta = 0.001;
N = 1000;
t = linspace(0,T,N+1);
h = T/N;
h2 = h/2;

x1 = zeros(1,N+1);
x2 = zeros(1,N+1);
x1(1) = x10;

lambda1 = zeros(1,N+1);
lambda2 = zeros(1,N+1);

u = zeros(1,N+1);

while(test < 0)
    
    oldu = u;
    oldx1 = x1;
    oldx2 = x2;
    oldlambda1 = lambda1;
    oldlambda2 = lambda2;
    
    for i = 1:N
        k11 = -a*x1(i) - b*x2(i);
        k12 = -c*x2(i) + u(i);
        
        k21 = -a*(x1(i)+h2*k11) - b*(x2(i)+h2*k12);
        k22 = -c*(x2(i)+h2*k12) + 0.5*(u(i)+u(i+1));
        
        k31 = -a*(x1(i)+h2*k21) - b*(x2(i)+h2*k22);
        k32 = -c*(x2(i)+h2*k22) + 0.5*(u(i)+u(i+1));
        
        k41 = -a*(x1(i)+h*k31) - b*(x2(i)+h*k32);
        k42 = -c*(x2(i)+h*k32) + u(i+1);
        
        x1(i+1) = x1(i) + (h/6)*(k11 + 2*k21 + 2*k31 + k41);
        x2(i+1) = x2(i) + (h/6)*(k12 + 2*k22 + 2*k32 + k42);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k11 = -2*A*(x1(j) - l) + a*lambda1(j);
        k12 = b*lambda1(j) + c*lambda2(j);
        
        k21 = -2*A*(0.5*(x1(j)+x1(j-1)) - l) + a*(lambda1(j)-h2*k11);
        k22 = b*(lambda1(j)-h2*k11) + c*(lambda2(j)+h2*k12);
        
        k31 = -2*A*(0.5*(x1(j)+x1(j-1)) - l) + a*(lambda1(j)-h2*k21);
        k32 = b*(lambda1(j)-h2*k21) + c*(lambda2(j)+h2*k22);
        
        k41 = -2*A*(x1(j-1) - l) + a*(lambda1(j)-h*k31);
        k42 = b*(lambda1(j)-h*k31) + c*(lambda2(j)+h*k32);
        
        lambda1(j-1) = lambda1(j) - (h/6)*(k11 + 2*k21 + 2*k31 + k41);
        lambda2(j-1) = lambda2(j) - (h/6)*(k12 + 2*k22 + 2*k32 + k42);
    end
    
    u1 = -lambda2./2;
    u = 0.5*(u1+oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(x1)) - sum(abs(oldx1 - x1));
    temp3 = delta*sum(abs(x2)) - sum(abs(oldx2 - x2));
    temp4 = delta*sum(abs(lambda1)) - sum(abs(oldlambda1 - lambda1));
    temp5 = delta*sum(abs(lambda2)) - sum(abs(oldlambda2 - lambda2));
    test = min(temp1, min(temp2, min(temp3, min(temp4, temp5))));
end

y(1,:) = t;
y(2,:) = x1;
y(3,:) = x2;
y(4,:) = u;