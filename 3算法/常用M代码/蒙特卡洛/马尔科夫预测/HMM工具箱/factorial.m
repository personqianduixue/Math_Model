function x = factorial(n)
% FACTORIAL Compute n!
% x = factorial(n)

if n == 0
  x = 1;
else
  x = n*factorial(n-1);
end    
