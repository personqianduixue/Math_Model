function y = code3(r,A,B,C,x0)

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
lambda(N+1) = C;

while(test < 0)
    
    oldu = u;
    oldx = x;
    oldlambda = lambda;

    for i = 1:N
        k1 = x(i)*(r+A*u(i)) - B*exp(-x(i))*(u(i))^2;
        k2 = (x(i)+h2*k1)*(r+A*0.5*(u(i)+u(i+1))) - B*exp(-(x(i)+h2*k1))*(0.5*(u(i)+u(i+1)))^2;
        k3 = (x(i)+h2*k2)*(r+A*0.5*(u(i)+u(i+1))) - B*exp(-(x(i)+h2*k2))*(0.5*(u(i)+u(i+1)))^2;
        k4 = (x(i)+h*k3)*(r+A*u(i+1)) - B*exp(-(x(i)+h*k3))*(u(i+1))^2;
        x(i+1) = x(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k1 = -lambda(j)*(r + A*u(j) + B*exp(-x(j))*u(j)^2);
        k2 = -(lambda(j)-h2*k1)*(r + A*0.5*(u(j)+u(j-1)) + B*exp(-0.5*(x(j)+x(j-1)))*(0.5*(u(j)+u(j-1)))^2);
        k3 = -(lambda(j)-h2*k2)*(r + A*0.5*(u(j)+u(j-1)) + B*exp(-0.5*(x(j)+x(j-1)))*(0.5*(u(j)+u(j-1)))^2);
        k4 = -(lambda(j)-h*k3)*(r + A*u(j-1) + B*exp(-x(j-1))*u(j-1)^2);
        lambda(j-1) = lambda(j) - (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    u1 = (A.*lambda.*x)./(2 + 2.*B.*lambda.*exp(-x));
    u = 0.5*(u1 + oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(x)) - sum(abs(oldx - x));
    temp3 = delta*sum(abs(lambda)) - sum(abs(oldlambda - lambda));
    test = min(temp1, min(temp2, temp3));
end

y(1,:) = t;
y(2,:) = x;
y(3,:) = u;