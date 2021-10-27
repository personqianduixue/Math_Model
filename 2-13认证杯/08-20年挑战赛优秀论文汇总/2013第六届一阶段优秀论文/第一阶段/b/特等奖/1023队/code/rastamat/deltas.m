function d = deltas(x, w)
% D = deltas(X,W)  Calculate the deltas (derivatives) of a sequence
%    Use a W-point window (W odd, default 9) to calculate deltas using a
%    simple linear slope.  This mirrors the delta calculation performed 
%    in feacalc etc.  Each row of X is filtered separately.
% 2003-06-30 dpwe@ee.columbia.edu

if nargin < 2
  w = 9;
end

[nr,nc] = size(x);

if nc == 0
  % empty vector passed in; return empty vector
  d = x;

else
  % actually calculate deltas
  
  % Define window shape
  hlen = floor(w/2);
  w = 2*hlen + 1;
  win = hlen:-1:-hlen;

  % pad data by repeating first and last columns
  xx = [repmat(x(:,1),1,hlen),x,repmat(x(:,end),1,hlen)];

  % Apply the delta filter
  d = filter(win, 1, xx, [], 2);  % filter along dim 2 (rows)

  % Trim edges
  d = d(:,2*hlen + [1:nc]);

end
