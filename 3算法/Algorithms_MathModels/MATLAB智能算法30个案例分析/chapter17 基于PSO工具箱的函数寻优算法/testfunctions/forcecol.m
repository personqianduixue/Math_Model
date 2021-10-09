% forcecol.m
% function to force a vector to be a single column
%
% Brian Birge
% Rev 1.0
% 7/1/98

function[out]=forcecol(in)
len=prod(size(in));
out=reshape(in,[len,1]);
