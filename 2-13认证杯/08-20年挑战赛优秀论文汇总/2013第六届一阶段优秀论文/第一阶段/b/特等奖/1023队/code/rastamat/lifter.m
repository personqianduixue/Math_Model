function y = lifter(x, lift, invs)
% y = lifter(x, lift, invs)
%   Apply lifter to matrix of cepstra (one per column)
%   lift = exponent of x i^n liftering
%   or, as a negative integer, the length of HTK-style sin-curve liftering.
%   If inverse == 1 (default 0), undo the liftering.
% 2005-05-19 dpwe@ee.columbia.edu

if nargin < 2;   lift = 0.6; end   % liftering exponent
if nargin < 3;   invs = 0; end      % flag to undo liftering

[ncep, nfrm] = size(x);

if lift == 0
  y = x;
else

  if lift > 0
    if lift > 10
      disp(['Unlikely lift exponent of ', num2str(lift),' (did you mean -ve?)']);
    end
    liftwts = [1, ([1:(ncep-1)].^lift)];
  elseif lift < 0
    % Hack to support HTK liftering
    L = -lift;
    if (L ~= round(L)) 
      disp(['HTK liftering value ', num2str(L),' must be integer']);
    end
    liftwts = [1, (1+L/2*sin([1:(ncep-1)]*pi/L))];
  end

  if (invs)
    liftwts = 1./liftwts;
  end

  y = diag(liftwts)*x;

end
