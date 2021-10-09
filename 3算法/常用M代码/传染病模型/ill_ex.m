function ill_ex
ts=0:50;
x0=[0.02,0.98];
[t,x]=ode45(@ill,ts,x0);
[t,x]
figure(1)
plot(t,x(:,1),t,x(:,2)),grid
figure(2)
plot(x(:,2),x(:,1)),grid
 
function y=ill(x)
a=1; b=0.3;
y=[a*x(1)*x(2)-b*x(1),-a*x(1)*x(2)]';
