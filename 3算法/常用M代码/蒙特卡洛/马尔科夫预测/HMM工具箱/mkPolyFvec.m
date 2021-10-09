function p = mkPolyFvec(x)
% MKPOLYFVEC Make feature vector by constructing 2nd order polynomial from input data
% function p = mkPolyFvec(x)
%
% x(:,i) for example i
% p(:,i) = [x(1,i) x(2,i) x(3,i) x(1,i)^2 x(2,i)^2 x(3,i)^2 ..
%           x(1,i)*x(2,i) x(1,i)*x(3,i) x(2,i)*x(3,i)]'
%
% Example
% x = [4 5 6]'
% p = [4 5 6  16 25 36  20 24 30]'

fvec = x;
fvecSq = x.*x;
[D N] = size(x);
fvecCross = zeros(D*(D-1)/2, N);
i = 1;
for d=1:D
  for d2=d+1:D
    fvecCross(i,:) = x(d,:) .* x(d2,:);
    i = i + 1;
  end
end
p = [fvec; fvecSq; fvecCross];
