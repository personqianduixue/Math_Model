function N = cell2num(C)
% CELL2NUM Convert a 2D cell array to a 2D numeric array 
% N = cell2num(C)
% If the cells contain column vectors, they must have the same number of rows in each row of C.
% Each column will be concatenated.
%
% Example 1:
% C = num2cell(rand(2,2))
%    [0.4565]    [0.8214]
%    [0.0185]    [0.4447]
% N = cell2num(C)
%     0.4565    0.8214
%     0.0185    0.4447
%
% Example 2:
% C = cell(2, 3);
% for i=1:2
%   for j=1:3
%     C{i,j} = rand(i, 1);
%   end
% end
% C = 
%     [    0.8998]    [    0.8216]    [    0.6449]
%     [2x1 double]    [2x1 double]    [2x1 double]
% C{2,1} = 
%     0.8180
%     0.6602
% N=cell2num(C)
%     0.8998    0.8216    0.6449
%     0.8180    0.3420    0.3412
%     0.6602    0.2897    0.5341


%  error('use cell2mat in matlab 7')


if isempty(C)
  N = [];
  return;
end

if any(cellfun('isempty', C)) %any(isemptycell(C))
  error('can''t convert cell array with empty cells to matrix')
end

[nrows ncols] = size(C);
%N = reshape(cat(1, C{:}), [nrows ncols]); % this only works if C only contains scalars
r = 0;
for i=1:nrows
  r = r + size(C{i,1}, 1);
end
c = 0;
for j=1:ncols
  c = c + size(C{1,j}, 2);
end
N = reshape(cat(1, C{:}), [r c]);

