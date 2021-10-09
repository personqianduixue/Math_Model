function opt_vect = foptions()
% FOPTIONS Sets default parameters for optimisation routines
% For compatibility with MATLAB's foptions()
%
% Copyright (c) Dharmesh Maniyar, Ian T. Nabney (2004)
  
opt_vect      = zeros(1, 18);
opt_vect(2:3) = 1e-4;
opt_vect(4)   = 1e-6;
opt_vect(16)  = 1e-8;
opt_vect(17)  = 0.1;