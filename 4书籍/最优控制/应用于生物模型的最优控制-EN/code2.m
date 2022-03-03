function y = code2(r,M,A,x0,T)

test = -1;

delta = 0.001;
N = 1000;
t = linspace(0,T,N+1);
h = T/N;
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
        k1 = r*(M - x(i)) - u(i)*x(i);
        k2 = r*(M - (x(i)+h2*k1)) - 0.5*(u(i)+u(i+1))*(x(i)+h2*k1);
        k3 = r*(M - (x(i)+h2*k2)) - 0.5*(u(i)+u(i+1))*(x(i)+h2*k2);
        k4 = r*(M - (x(i)+h*k3)) - u(i+1)*(x(i)+h*k3);
        x(i+1) = x(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k1 = -2*A*x(j) + (u(j) + r)*lambda(j);
        k2 = -2*A*0.5*(x(j)+x(j-1)) + (0.5*(u(j)+u(j-1)) + r)*(lambda(j)-h2*k1);
        k3 = -2*A*0.5*(x(j)+x(j-1)) + (0.5*(u(j)+u(j-1)) + r)*(lambda(j)-h2*k2);
        k4 = -2*A*x(j-1) + (u(j-1) + r)*(lambda(j)-h*k3);
        lambda(j-1) = lambda(j) - (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    u1 = (lambda.*x)/(2);
    u = 0.5*(oldu + u1);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(x)) - sum(abs(oldx - x));
    temp3 = delta*sum(abs(lambda)) - sum(abs(oldlambda - lambda));
    test = min(temp1, min(temp2, temp3));
end

y(1,:) = t;
y(2,:) = x;
y(3,:) = u;