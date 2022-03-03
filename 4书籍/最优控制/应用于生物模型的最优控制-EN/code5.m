function y = code5(r,a,d,n0,T)

test = -1;

delta = 0.001;
M = 1000;
t = linspace(0,T,M+1);
h = T/M;
h2 = h/2;

N = zeros(1,M+1);
N(1) = n0;
lambda = zeros(1,M+1);

u = zeros(1,M+1);

while(test < 0)
    
    oldu = u;
    oldN = N;
    oldlambda = lambda;
    
    for i=1:M
        k1 = r*N(i)*log(1/N(i)) - u(i)*d*N(i);
        k2 = r*(N(i)+ h2*k1)*log(1/(N(i)+ h2*k1)) - 0.5*(u(i)+u(i+1))*d*(N(i)+ h2*k1);
        k3 = r*(N(i)+ h2*k2)*log(1/(N(i)+ h2*k2)) - 0.5*(u(i)+u(i+1))*d*(N(i)+ h2*k2);
        k4 = r*(N(i)+ h*k3)*log(1/(N(i)+ h*k3)) - u(i+1)*d*(N(i)+ h*k3);
        N(i+1) = N(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i=1:M
        j = M + 2 - i;
        k1 = -2*a*N(j) - lambda(j)*r*log(1/(N(j))) + lambda(j)*r + lambda(j)*u(j)*d;
        k2 = -2*a*0.5*(N(j)+N(j-1)) - (lambda(j)-h2*k1)*r*log(1/(0.5*(N(j)+N(j-1)))) + (lambda(j)-h2*k1)*r + (lambda(j)-h2*k1)*0.5*(u(j)+u(j-1))*d;
        k3 = -2*a*0.5*(N(j)+N(j-1)) - (lambda(j)-h2*k2)*r*log(1/(0.5*(N(j)+N(j-1)))) + (lambda(j)-h2*k2)*r + (lambda(j)-h2*k2)*0.5*(u(j)+u(j-1))*d;
        k4 = -2*a*N(j-1) - (lambda(j)-h*k3)*r*log(1/(N(j-1))) + (lambda(j)-h*k3)*r + (lambda(j)-h*k3)*u(j-1)*d;
        lambda(j-1) = lambda(j) - (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    temp = (lambda.*d.*N)./2;
    u1 = max(temp,0);
    u = 0.5*(u1 + oldu);
    
    temp1 = delta*sum(abs(u)) - sum(abs(oldu - u));
    temp2 = delta*sum(abs(N)) - sum(abs(oldN - N));
    temp3 = delta*sum(abs(lambda)) - sum(abs(oldlambda - lambda));
    test = min(temp1, min(temp2, temp3));
end

y(1,:) = t;
y(2,:) = N;
y(3,:) = u;