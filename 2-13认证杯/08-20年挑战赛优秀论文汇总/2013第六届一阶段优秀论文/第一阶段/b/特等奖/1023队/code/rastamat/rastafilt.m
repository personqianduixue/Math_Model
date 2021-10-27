function y = rastafilt(x)
% y = rastafilt(x)
%
% rows of x = critical bands, cols of x = frame
% same for y but after filtering
% 
% default filter is single pole at 0.94

% rasta filter
numer = [-2:2];
numer = -numer ./ sum(numer.*numer);
denom = [1 -0.94];

% Initialize the state.  This avoids a big spike at the beginning 
% resulting from the dc offset level in each band.
% (this is effectively what rasta/rasta_filt.c does).
% Because Matlab uses a DF2Trans implementation, we have to 
% specify the FIR part to get the state right (but not the IIR part)
%[y,z] = filter(numer, 1, x(:,1:4)');
% 2010-08-12 filter() chooses the wrong dimension for very short
% signals (thanks to Benjamin K otric1@gmail.com)
[y,z] = filter(numer, 1, x(:,1:4)',[],1);
% .. but don't keep any of these values, just output zero at the beginning
y = 0*y';

size(z)
size(x)

% Apply the full filter to the rest of the signal, append it
y = [y,filter(numer, denom, x(:,5:end)',z,1)'];
%y = [y,filter(numer, denom, x(:,5:end)',z)'];
