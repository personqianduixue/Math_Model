function b=d_func(x,y)
% d_func.m
%
% distance function
% if nargin=1,return x
% if nargin=2,return sqrt(x^2+y^2)

if nargin==1
    b=x;
else
    b=sqrt(x.^2+y.^2);
end
