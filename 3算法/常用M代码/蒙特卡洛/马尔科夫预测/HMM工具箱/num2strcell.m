function c = num2strcell(n, format)
% num2strcell Convert vector of numbers to cell array of strings
% function c = num2strcell(n, format)
%
% If format is omitted, we use
% c{i} = sprintf('%d', n(i))

if nargin < 2, format = '%d'; end

N = length(n);
c = cell(1,N);
for i=1:N
  c{i} = sprintf(format, n(i));
end
  
  
