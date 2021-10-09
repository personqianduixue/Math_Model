% REP.m         Replicate a matrix
%
% This function replicates a matrix in both dimensions. 
%
% Syntax:       MatOut = rep(MatIn,REPN);
%
% Input parameters:
%   MatIn    - Input Matrix (before replicating)
%
%   REPN     - Vector of 2 numbers, how many replications in each dimension
%              REPN(1): replicate vertically
%              REPN(2): replicate horizontally
%
%              Example:
%
%              MatIn = [1 2 3]
%              REPN = [1 2]: MatOut = [1 2 3 1 2 3]
%              REPN = [2 1]: MatOut = [1 2 3;
%                                      1 2 3]
%              REPN = [3 2]: MatOut = [1 2 3 1 2 3;
%                                      1 2 3 1 2 3;
%                                      1 2 3 1 2 3]
%
% Output parameter:
%   MatOut   - Output Matrix (after replicating)
%

% Author:   Carlos Fonseca & Hartmut Pohlheim
% History:  14.02.94        file created


function MatOut = rep(MatIn,REPN)

% Get size of input matrix
   [N_D,N_L] = size(MatIn);

% Calculate
   Ind_D = rem(0:REPN(1)*N_D-1,N_D) + 1;
   Ind_L = rem(0:REPN(2)*N_L-1,N_L) + 1;

% Create output matrix
   MatOut = MatIn(Ind_D,Ind_L);


% End of function
