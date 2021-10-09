function y = my_first_SA(x)
%   y = (4 - 2.1*x(1)^2 + x(1)^4/3)*x(1)^2 + x(1)*x(2) + (-4 + 4*x(2)^2)*x(2)^2;

% Rastrigin's function
y = 20 + x(1)^2 + x(2)^2 - 10*(cos(2*pi*x(1))+cos(2*pi*x(2)));