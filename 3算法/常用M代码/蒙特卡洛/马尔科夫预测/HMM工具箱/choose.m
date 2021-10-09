function c = choose(n,k)
% CHOOSE The number of ways of choosing k things from n 
% c = choose(n,k)

c = factorial(n)/(factorial(k) * factorial(n-k));      
