function s = sprintf_intvec(v)
% SPRINTF_INTVEC Print a vector of ints as comma separated string, with no trailing comma
% function s = sprintf_intvec(v)
%
% e.g., sprintf_intvec(1:3) returns '1,2,3' 

s = sprintf('%d,', v);
s = s(1:end-1);

