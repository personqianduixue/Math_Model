function z = hz2mel(f,htk)
%  z = hz2mel(f,htk)
%  Convert frequencies f (in Hz) to mel 'scale'.
%  Optional htk = 1 uses the mel axis defined in the HTKBook
%  otherwise use Slaney's formula
% 2005-04-19 dpwe@ee.columbia.edu

if nargin < 2
  htk = 0;
end

if htk == 1
  z = 2595 * log10(1+f/700);
else
  % Mel fn to match Slaney's Auditory Toolbox mfcc.m

  f_0 = 0; % 133.33333;
  f_sp = 200/3; % 66.66667;
  brkfrq = 1000;
  brkpt  = (brkfrq - f_0)/f_sp;  % starting mel value for log region
  logstep = exp(log(6.4)/27); % the magic 1.0711703 which is the ratio needed to get from 1000 Hz to 6400 Hz in 27 steps, and is *almost* the ratio between 1000 Hz and the preceding linear filter center at 933.33333 Hz (actually 1000/933.33333 = 1.07142857142857 and  exp(log(6.4)/27) = 1.07117028749447)

  linpts = (f < brkfrq);

  z = 0*f;

  % fill in parts separately
  z(linpts) = (f(linpts) - f_0)/f_sp;
  z(~linpts) = brkpt+(log(f(~linpts)/brkfrq))./log(logstep);

end
