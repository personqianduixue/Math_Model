%% CompertzÇúÏß
clc, clear
global a2 b2 K2

yt = [42.1 47.5 52.7 57.7 62.5 67.1 71.5 75.7 79.8 ...
      83.7 87.5 91.1 94.6 97.9 101.1];
n = length(yt);
m = n/3;
s1 = sum(yt(1:m));
s2 = sum(yt(m+1:2*m));
s3 = sum(yt(2*m+1:end));

b2 = ((s3-s2)/(s2-s1))^(1/m);
a2 = (s2-s1)*(b2-1)/(b2*(b2^m-1)^2);
K2 = (s1-a2*b2*(b2^m-1)/(b2-1))/m;

a2 = exp(a2);
K2 = exp(K2);
y = predict2(1:18);

plot(1:15, yt, '*', 1:18, y)