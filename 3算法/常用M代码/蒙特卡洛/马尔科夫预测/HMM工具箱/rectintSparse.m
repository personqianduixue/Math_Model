function [overlap, normoverlap] = rectintSparse(A,B)
%
% A(i,:) = [x y w h]
% B(j,:) = [x y w h]
% overlap(i,j) = area of intersection
% normoverla(i,j)
%
% Same as built-in rectint, but uses less memory.
% Use rectintSparseC for a faster version.
%

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

%out = rectintSparseLoopC(leftA, rightA, topA, bottomA, leftB, rightB, topB, bottomB);

nnz = ceil(0.2*numRectA*numRectB); % guess of number of non-zeroes
overlap = sparse([], [], [], numRectA, numRectB, nnz);
normoverlap = sparse([], [], [], numRectA, numRectB, nnz);
for j=1:numRectB
  for i=1:numRectA
    tmp = (max(0, min(rightA(i), rightB(j)) - max(leftA(i), leftB(j)) ) ) .* ...
	(max(0, min(topA(i), topB(j)) - max(bottomA(i), bottomB(j)) ) );
    if tmp>0
      overlap(i,j) = tmp;
      areaA = (rightA(i)-leftA(i))*(topA(i)-bottomA(i));
      areaB = (rightB(j)-leftB(j))*(topB(j)-bottomB(j));
      normoverlap(i,j) = min(tmp/areaA, tmp/areaB);
    end
    %fprintf('j=%d, i=%d, overlap=%5.3f, norm=%5.3f\n',...
    %	    j, i, overlap(i,j), normoverlap(i,j));
  end
end


if 0
N = size(bboxDense01,2); % 1000;
rect = bboxToRect(bboxDense01)';
A = rect(1:2,:);
B = rect(1:N,:);

tic; out1 = rectint(A, B); toc
tic; out2 = rectintSparse(A, B); toc
tic; out3 = rectintSparseC(A, B); toc
tic; out4 = rectintC(A, B); toc
assert(approxeq(out1, out2))
assert(approxeq(out1, full(out3)))
assert(approxeq(out1, out4))
end
