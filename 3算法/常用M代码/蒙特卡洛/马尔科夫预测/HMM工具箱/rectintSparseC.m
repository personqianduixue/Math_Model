function [overlap, normoverlap] = rectintSparseC(A,B)
%
% function [area, normarea] = rectintSparseC(A,B)
% A(i,:) = [x y w h]
% B(j,:) = [x y w h]
% out(i,j) = area of intersection
%
% Same as built-in rectint, but uses less memory.
% Also, returns area of overlap normalized by area of patch.
% See rectintSparse

if isempty(A) | isempty(B)
  overlap = [];
  normoverlap = [];
  return;
end

leftA = A(:,1);
bottomA = A(:,2);
rightA = leftA + A(:,3);
topA = bottomA + A(:,4);

leftB = B(:,1)';
bottomB = B(:,2)';
rightB = leftB + B(:,3)';
topB = bottomB + B(:,4)';

numRectA = size(A,1);
numRectB = size(B,1);

verbose = 0;
[overlap, normoverlap] = rectintSparseLoopC(leftA, rightA, topA, bottomA, leftB, rightB, topB, bottomB, verbose);
