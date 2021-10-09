function c = nchoose2(v, f)
%NCHOOSE2 All combinations of N elements taken two at a time.
%
%   NCHOOSE2(1:N) or NCHOOSEK(V) where V is a vector of length N,
%   produces a matrix with N*(N-1)/2 rows and K columns. Each row of
%   the result has K of the elements in the vector V.
%
%   NCHOOSE2(N,FLAG) is the same as NCHOOSE2(1:N) but faster.
%
%   NCHOOSE2(V) is much faster than NCHOOSEK(V,2).
%
%   See also NCHOOSEK, PERMS.

%   Author:      Peter J. Acklam
%   Time-stamp:  2000-03-03 13:03:59
%   E-mail:      jacklam@math.uio.no
%   URL:         http://www.math.uio.no/~jacklam

   nargs = nargin;
   if nargs < 1
      error('Not enough input arguments.');
   elseif nargs == 1
      v = v(:);
      n = length(v);
   elseif nargs == 2
      n = v;
   else
      error('Too many input arguments.');
   end

   [ c(:,2), c(:,1) ] = find( tril( ones(n), -1 ) );

   if nargs == 1
      c = v(c);
   end
