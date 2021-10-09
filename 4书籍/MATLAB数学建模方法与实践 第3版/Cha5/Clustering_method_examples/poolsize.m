function [ ps ] = poolsize( )
%POOLSIZE This function returns the poolsize of the current parallel pool
%of workers.
%   This function returns 0 if a pool does not exist. Otherwise, it reutns
%   the number of workers in the current parallel pool.

% Copyright 2014 The MathWorks, Inc.

poolobj = gcp('nocreate'); % If no pool, do not a create new one.
if isempty(poolobj)
    ps = 0;
else
    ps = poolobj.NumWorkers;
end

end

