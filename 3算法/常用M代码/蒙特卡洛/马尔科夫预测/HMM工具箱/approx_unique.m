function [B, keep] = approx_unique(A, thresh, flag)
% APPROX_UNIQUE Return elements of A that differ from the rest by less than thresh
% B = approx_unique(A, thresh)
% B = approx_unique(A, thresh, 'rows')

keep = [];

if nargin < 3 | isempty(flag)
  A = sort(A)
  B = A(1);
  for i=2:length(A)
    if ~approxeq(A(i), A(i-1), thresh)
      B = [B A(i)];
      keep = [keep i];
    end
  end
else
%   A = sortrows(A);
%   B = A(1,:);
%   for i=2:size(A,1)
%     if ~approxeq(A(i,:), A(i-1,:), thresh)
%       B = [B; A(i,:)];
%       keep = [keep i];
%     end
%   end
  B = [];
  for i=1:size(A,1)
    duplicate = 0;
    for j=i+1:size(A,1)
      if approxeq(A(i,:), A(j,:), thresh)
	duplicate = 1;
	break;
      end
    end
    if ~duplicate    
      B = [B; A(i,:)];
      keep = [keep i];
    end
  end
end

