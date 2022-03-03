function y = code12(K,G,D,x0,z0,M,T)

test = -1;

delta = 0.001;
N = 1000;
t=linspace(0,T,N+1);
h=T/N;
h2 = h/2;

x=zeros(1,N+1);
z=zeros(1,N+1);
lambda=zeros(1,N+1);

x(1)=x0;
z(1)=z0;

u=zeros(1,N+1);

while(test < 0)
    
    oldu = u;
    oldx = x;
    oldlambda = lambda;
    
    for i = 1:N
        k1 = G*u(i)*x(i) - D*x(i)^2;
        k2 = G*(0.5*(u(i)+u(i+1)))*(x(i)+h2*k1) - D*(x(i)+h2*k1)^2;
        k3 = G*(0.5*(u(i)+u(i+1)))*(x(i)+h2*k2) - D*(x(i)+h2*k2)^2;
        k4 = G*u(i+1)*(x(i)+h*k3) - D*(x(i)+h*k3)^2;        
        x(i+1) = x(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N
        j = N + 2 - i;
        k1 = -lambda(j)*(G*u(j) - 2*D*x(j)) - K;
        k2 = -(lambda(j)-h2*k1)*(G*0.5*(u(j)+u(j-1)) - 2*D*0.5*(x(j)+x(j-1))) - K;
        k3 = -(lambda(j)-h2*k2)*(G*0.5*(u(j)+u(j-1)) - 2*D*0.5*(x(j)+x(j-1))) - K;
        k4 = -(lambda(j)-h*k3)*(G*u(j-1) - 2*D*x(j-1)) - K;
        lambda(j-1) = lambda(j) - (h/6)*(k1 + 2*k2 + 2*k3 + k4);
    end
    
    for i = 1:N+1
        temp = G*x(i)*lambda(i) - 1;
        if(temp>=0)
            u1(i) = M;
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

for i=1:N
    k1 = -K*z(i)*x(i);
    k2 = -K*(z(i)+h2*k1)*0.5*(x(i)+x(i+1));
    k3 = -K*(z(i)+h2*k2)*0.5*(x(i)+x(i+1));
    k4 = -K*(z(i)+h*k3)*x(i+1);
    z(i+1) = z(i) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);
end

y(1,:) = t;
y(2,:) = x;
y(3,:) = z;
y(4,:) = u;