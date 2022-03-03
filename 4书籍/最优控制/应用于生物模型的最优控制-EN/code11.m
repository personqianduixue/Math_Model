function y = code11(x0,k,r,T)

test = -1;

delta = 0.001;
N = 1000;
t = linspace(0,T,N+1);
h = T/1000;
h2 = h/2;

x = zeros(1,N+1);
lambda = zeros(1,N+1);
u = zeros(1,N+1);

x(1) = x0;

while(test < 0)
    
    oldu = u;
    oldx = x;
    oldlambda = lambda;
    
    for i = 1:N
        k1 = k*u(i)*x(i);
        k2 = k*0.5*(u(i)+u(i+1))*(x(i)+h2*k1);
        k3 = k*0.5*(u(i)+u(i+1))*(x(i)+h2*k2);
        k4 = k*u(i+1)*(x(i)+h*k3);
        x(i+1) = x(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k1 = u(j)*(exp(-r*t(j)) - k*lambda(j)) - exp(-r*t(j));
        k2 = 0.5*(u(j)+u(j-1))*(exp(-r*(t(j)-h2)) - k*(lambda(j)-h2*k1)) - exp(-r*(t(j)-h2));
        k3 = 0.5*(u(j)+u(j-1))*(exp(-r*(t(j)-h2)) - k*(lambda(j)-h2*k2)) - exp(-r*(t(j)-h2));
        k4 = u(j-1)*(exp(-r*(t(j)-h)) - k*(lambda(j)-h*k3)) - exp(-r*(t(j)-h));
        lambda(j-1) = lambda(j) - (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i=1:N+1
        temp = x(i)*(k*lambda(i)-exp(-r*t(i)));
        if(temp>0)
            u1(i) = 1;
        else
            u1(i) = 0;
        end
    end
    u = 0.5*(oldu + u1);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(x)) - sum(abs(oldx - x));
    temp3 = delta*sum(abs(lambda)) - sum(abs(oldlambda - lambda));
    test = min(temp1, min(temp2, temp3));
end

y(1,:) = t;
y(2,:) = x;
y(3,:) = u;