function y = code6(A,k,m,x0,M,T)

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
        k1 = -(m + u(i))*x(i);
        k2 = -(m + 0.5*(u(i)+u(i+1)))*(x(i)+h2*k1);
        k3 = -(m + 0.5*(u(i)+u(i+1)))*(x(i)+h2*k2);
        k4 = -(m + u(i+1))*(x(i)+h*k3);
        x(i+1) = x(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k1 = -A*u(j)*k*t(j)/(t(j)+1) + lambda(j)*(m + u(j));
        k2 = -A*0.5*(u(j)+u(j-1))*k*(t(j)-h2)/(t(j)-h2+1) + (lambda(j)-h2*k1)*(m + 0.5*(u(j)+u(j-1)));
        k3 = -A*0.5*(u(j)+u(j-1))*k*(t(j)-h2)/(t(j)-h2+1) + (lambda(j)-h2*k2)*(m + 0.5*(u(j)+u(j-1)));
        k4 = -A*u(j-1)*k*(t(j)-h)/(t(j)-h+1) + (lambda(j)-h*k3)*(m + u(j-1));
        lambda(j-1) = lambda(j) - (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    temp = -0.5*(lambda.*x - A*k.*t.*x./(t+1));
    u1 = min(M, max(temp,0));
    u = 0.5*(u1 + oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(x)) - sum(abs(oldx - x));
    temp3 = delta*sum(abs(lambda)) - sum(abs(oldlambda - lambda));
    test = min(temp1, min(temp2, temp3));
end

y(1,:) = t;
y(2,:) = x;
y(3,:) = u;