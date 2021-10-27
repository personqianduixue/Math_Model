function x = ispecgram(d, ftsize, sr, win, nov)
% X = ispecgram(D, F, SR, WIN, NOV)           Inverse specgram
%    Overlap-add the inverse of the output of specgram
%    ftsize is implied by sizeof d, sr is ignored, nov defaults to ftsize/2
% dpwe 2005may16.  after istft

[nspec,ncol] = size(d);

if nargin < 2
  ftsize = 2*(nspec-1);
end
if nargin < 3
  % who cares?
end
if nargin < 4
  win = ftsize;  % doesn't matter either - assume it added up OK
end
if nargin < 5
  nov = ftsize/2;
end

hop = win - nov;

if nspec ~= (ftsize/2)+1
  error('number of rows should be fftsize/2+1')
end

xlen = ftsize + (ncol-1) * hop;
x = zeros(xlen,1);

halff = ftsize/2;   % midpoint of win

% No reconstruction win (for now...)

for c = 1:ncol
  ft = d(:,c);
  ft = [ft(1:(ftsize/2+1)); conj(ft([(ftsize/2):-1:2]))];

  if max(imag(ifft(ft))) > 1e-5
    disp('imag oflow');
  end
  
  px = real(ifft(ft));  % no shift in specgram
  
  b = (c-1)*hop;
  x(b+[1:ftsize]) = x(b+[1:ftsize]) + px;
end;

x = x * win/ftsize;  % scale amplitude

