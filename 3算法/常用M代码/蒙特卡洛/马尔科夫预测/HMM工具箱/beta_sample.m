function r = betarnd(a,b,m,n);
%BETARND Random matrices from beta distribution.
%   R = BETARND(A,B) returns a matrix of random numbers chosen   
%   from the beta distribution with parameters A and B.
%   The size of R is the common size of A and B if both are matrices.
%   If either parameter is a scalar, the size of R is the size of the other
%   parameter. Alternatively, R = BETARND(A,B,M,N) returns an M by N matrix. 

%   Reference:
%      [1]  L. Devroye, "Non-Uniform Random Variate Generation", 
%      Springer-Verlag, 1986

%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 1.1 $  $Date: 2005/04/26 02:29:17 $

if nargin < 2, 
    error('Requires at least two input arguments'); 
end 

if nargin == 2
    [errorcode rows columns] = rndcheck(2,2,a,b);
end

if nargin == 3
    [errorcode rows columns] = rndcheck(3,2,a,b,m);
end

if nargin == 4
    [errorcode rows columns] = rndcheck(4,2,a,b,m,n);
end

if errorcode > 0
    error('Size information is inconsistent.');
end

r = zeros(rows,columns);

% Use Theorem 4.1, case A (Devroye, page 430) to derive beta
%   random numbers as a ratio of gamma random numbers.
if prod(size(a)) == 1
    a1 = a(ones(rows,1),ones(columns,1));
    g1 = gamrnd(a1,1);
else
    g1 = gamrnd(a,1);
end
if prod(size(b)) == 1
    b1 = b(ones(rows,1),ones(columns,1));
    g2 = gamrnd(b1,1);
else
    g2 = gamrnd(b,1);
end
r = g1 ./ (g1 + g2);

% Return NaN if b is not positive.
if any(any(b <= 0));
    if prod(size(b) == 1)
        tmp = NaN;
        r = tmp(ones(rows,columns));
    else
        k = find(b <= 0);
        tmp = NaN;
        r(k) = tmp(ones(size(k)));
    end
end

% Return NaN if a is not positive.
if any(any(a <= 0));
    if prod(size(a) == 1)
        tmp = NaN;
        r = tmp(ones(rows,columns));
    else
        k = find(a <= 0);
        tmp = NaN;
        r(k) = tmp(ones(size(k)));
    end
end
