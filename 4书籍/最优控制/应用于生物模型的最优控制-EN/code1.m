function y = code1(A,B,C,x0)

test = -1;

delta = 0.001;
N = 1000;
t = linspace(0,1,N+1);
h = 1/N;
h2 = h/2;

u = zeros(1,N+1);

x = zeros(1,N+1);
x(1) = x0;
lambda = zeros(1,N+1);

while(test < 0)
    
    oldu = u;
    oldx = x;
    oldlambda = lambda;

    for i = 1:N
        k1 = -0.5*x(i)^2 + C*u(i);
        k2 = -0.5*(x(i) + h2*k1)^2 + C*0.5*(u(i) + u(i+1));
        k3 = -0.5*(x(i) + h2*k2)^2 + C*0.5*(u(i) + u(i+1));
        k4 = -0.5*(x(i) + h*k3)^2 + C*u(i+1);
        x(i+1) = x(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k1 = -A + lambda(j)*x(j);
        k2 = -A + (lambda(j) - h2*k1)*0.5*(x(j)+x(j-1));
        k3 = -A + (lambda(j) - h2*k2)*0.5*(x(j)+x(j-1));
        k4 = -A + (lambda(j) - h*k3)*x(j-1);
        lambda(j-1) = lambda(j) - ...
            (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    u1 = C*lambda/(2*B);
    u = 0.5*(u1 + oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(x)) - sum(abs(oldx - x));
    temp3 = delta*sum(abs(lambda)) - ...
        sum(abs(oldlambda - lambda));
    test = min(temp1, min(temp2, temp3));
end

y(1,:) = t;
y(2,:) = x;
y(3,:) = lambda;
y(4,:) = u;