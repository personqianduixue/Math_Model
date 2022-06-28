% forcerow.m
% function to force a vector to be a single row
%
% Brian Birge
% Rev 2.0 - vectorized
% 7/1/98

function[out]=forcerow(in)
len=prod(size(in));
out=reshape(in,[1,len]);