function D = dists(X1,X2,p,e)
%DISTS Calculates distances between vectors of points.
%     D = dists(X1,X2,p,e)
%    X1 = n x d matrix of n d-dimensional points
%    X2 = m x d matrix of m d-dimensional points
%     D = n x m matrix of distances
%       = (n-1) x 1 vector of distances between X1 points, if X2 = []
%     p = 2, Euclidean (default): D(i,j) = sqrt(sum((X1(i,:) - X2(j,:))^2))
%       = 1, rectilinear: D(i,j) = sum(abs(X1(i,:) - X2(j,:))
%       = Inf, Chebychev dist: D(i,j) = max(abs(X1(i,:) - X2(j,:))
%       = (1 Inf), lp norm: D(i,j) = sum(abs(X1(i,:) - X2(j,:))^p)^(1/p)
%       = 'rad', great circle distance in radians of a sphere
%         (where X1 and X2 are decimal degree latitudes and longitudes)  
%       = 'mi' or 'sm', great circle distance in statute miles on the earth
%       = 'km', great circle distance in kilometers on the earth
%     e = epsilon for hyperboloid approximation gradient estimation
%       = 0 (default); no error checking if any non-empty 'e' input
%      ~= 0 => general lp used for rect., Cheb., and p outside [1,2] 
%
% Great circle distances are calculated using the Haversine Formula (from R.W.
% Sinnott, "Virtues of the Haversine", Sky and Telescope, vol. 68, no. 2, 1984
% p. 159, as reported in "http://www.census.gov/cgi-bin/geo/gisfaq?Q5.1")

% Copyright (c) 1998 by Michael G. Kay
% Matlog Version 1.0 Apr-3-98

% Input Error Checking *******************************************************
if nargin == 4 & ~isempty(e)		% No error checking is 'e' input
   [n,d] = size(X1);
   m = size(X2,1);
else					% Do error checking
   error(nargchk(1,4,nargin));
   e = 0;				% 'e' default
   [n,d] = size(X1);
   if n == 0 | ~isreal(X1)
      error('X1 must be non-empty real matrix');
   end
   if nargin < 2 | isempty(X2)		% Calc intra-seq dist b/w X1 points
      m = 0;				% X2 default
      if n < 2
	 error('X1 must have more than 1 point');
      end
   else					% Calc dist b/w X1 and X2 points
      [m,dX2] = size(X2);
      if m == 0 | ~isreal(X2)
	 error('X2 must be non-empty real matrix');
      end
      if d ~= dX2
	 error('Rows of X1 and X2 must have same dimensions');
      end
   end
   if nargin < 3 | isempty(p)
      p = 2;				% 'p' default
   elseif ~ischar(p)			% lp distances
      if length(p(:)) ~= 1 | ~isreal(p)
	 error('''p'' must be a real scalar number');
      end
   elseif ischar(p)			% Great circle distances
      p = lower(p);
      if d ~= 2
	 error('Points must be 2-dimensional for great-circle distances');
      end
      if ~any(strcmp(p,{'rad','mi','sm','km'}))
	 error('''p'' must be either ''rad,'' ''mi,'' ''sm,'' or ''km''');
      end
   else
      error('''p'' not valid value');
   end
end
% End (Input Error Checking) ***********************************************

% Interchange if X2 is the only 1 point
intrchg = 0;
if n > 1 & m == 1
   tmp = X2; X2 = X1; X1 = tmp;
   m = n;n = 1;
   intrchg = 1;
end

% 1-dimensional points
if d == 1
   if e == 0
      if m ~= 0
	 D = abs(X1(:,ones(1,m)) - X2(:,ones(1,n))');
      else
	 D = abs(X1(1:n-1) - X1(2:n))';	% X1 intra-seq. dist.
      end
   else
      if m ~= 0
	 D = sqrt((X1(:,ones(1,m)) - X2(:,ones(1,n))').^2 + e);
      else
	 D = sqrt((X1(1:n-1) - X1(2:n)).^2 + e)';
      end
   end

% X1 only 1 point or intra-seq dist   
elseif n == 1 | m == 0
   if n == 1				% Expand X1 to match X2
      X1 = X1(ones(1,m),:);
      n = m;
   else					% X1 intra-seq. dist.
      X2 = X1(2:n,:);		               % X2 = ending points
      n = n - 1;
      X1 = X1(1:n,:); 	                       % X1 = beginning points
   end
   if p == 2				% Euclidean distance
      D = sqrt(sum(((X1 - X2).^2 + e)'));
   elseif ischar(p)			% Great-circle distance
      X1 = pi*X1/180;X2 = pi*X2/180;
      D = 2*asin(min(1,sqrt(sin((X1(:,1) - X2(:,1))/2).^2 + ...
	                    cos(X1(:,1)).*cos(X2(:,1)).* ...
			    sin((X1(:,2) - X2(:,2))/2).^2)))';
   elseif p == 1 & e == 0		% Rectilinear distance
      D = sum(abs(X1 - X2)');
   elseif (p >= 1 & p <= 2) | (e ~= 0 & p > 0) % General lp distance
      D = sum((((X1 - X2).^2 + e).^(p/2))').^(1/p);
   elseif p == Inf & e == 0		% Chebychev distance
      D = max(abs(X1 - X2)');
   else					% Otherwise
      D = zeros(1,n);
      for j = 1:n
         D(j) = norm(X1(j,:) - X2(j,:),p);
      end
   end
   
% X1 and X2 are 2-dimensional points   
elseif d == 2
   if p == 2				% Euclidean distance
      D = sqrt((X1(:,  ones(1,m)) - X2(:,  ones(1,n))').^2 + e + ...
	       (X1(:,2*ones(1,m)) - X2(:,2*ones(1,n))').^2 + e);
   elseif ischar(p)			% Great-circle distance
      X1 = pi*X1/180;X2 = pi*X2/180;
      cosX1lat = cos(X1(:,1));cosX2lat = cos(X2(:,1));
      D = 2*asin(min(1,sqrt(...
	                sin((X1(:,ones(1,m))   - X2(:,ones(1,n))')/2).^2 + ...
	                cosX1lat(:,ones(1,m),1).*cosX2lat(:,ones(1,n))'.* ...
		        sin((X1(:,2*ones(1,m)) - X2(:,2*ones(1,n))')/2).^2)));
   elseif p == 1 & e == 0		% Rectilinear distance 
      D = abs(X1(:,ones(1,m))   - X2(:,ones(1,n))') + ...
	  abs(X1(:,2*ones(1,m)) - X2(:,2*ones(1,n))');
   elseif (p >= 1 & p <= 2) | (e ~= 0 & p > 0)  % General lp distance
      D = (((X1(:,  ones(1,m)) - X2(:,  ones(1,n))').^2 + e).^(p/2) + ...
	   ((X1(:,2*ones(1,m)) - X2(:,2*ones(1,n))').^2 + e).^(p/2)).^(1/p); 
   elseif p == Inf & e == 0		% Chebychev distance
      D = max(abs(X1(:,ones(1,m))   - X2(:,ones(1,n))'),...
	      abs(X1(:,2*ones(1,m)) - X2(:,2*ones(1,n))'));
   else					% Otherwise
      D = zeros(n,m);
      for i = 1:n
	 for j = 1:m
	    D(i,j) = norm(X1(i,:) - X2(j,:),p);
	 end
      end   
   end
   
% X1 and X2 are 3 or more dim. point   
else
   if p == 2				% Euclidean distance
      D = sqrt(sum((repmat(reshape(X1,[n 1 k]),1,m) - ...
	            repmat(reshape(X2,[1 m k]),n,1)).^2 + e,3));
   elseif p == 1 & e == 0		% Rectilinear distance
      D = sum(abs(repmat(reshape(X1,[n 1 k]),1,m) - ...
	          repmat(reshape(X2,[1 m k]),n,1)),3);
   elseif (p >= 1 & p <= 2) | (e ~= 0 & p > 0)  % General lp distance
      D = sum(((repmat(reshape(X1,[n 1 k]),1,m) - ...
	        repmat(reshape(X2,[1 m k]),n,1)).^2 + e).^(p/2),3).^(1/p);
   elseif p == Inf & e == 0		% Chebychev distance
      D = max(abs(repmat(reshape(X1,[n 1 k]),1,m) - ...
	          repmat(reshape(X2,[1 m k]),n,1)),[],3);
   else				        % Otherwise
      D = zeros(n,m);
      for i = 1:n
	 for j = 1:m
	    D(i,j) = norm(X1(i,:) - X2(j,:),p);
	 end
      end   
   end
end      

% Transpose D if X2 was interchanged or X1 intra-seq distances
if intrchg == 1 | m == 0
   D = D.';
end

% Convert 'rad' to 'km' or 'mi' (or 'sm')
if ischar(p) & ~strcmp(p,'rad')
   if strcmp(p,'km')
      D = (6378.388 - 21.476*abs(sin(mean([X1(:,1);X2(:,1)]))))*D;
   else					% 'mi' or 'sm'
      D = (3963.34 - 13.35*abs(sin(mean([X1(:,1);X2(:,1)]))))*D;
   end
end
