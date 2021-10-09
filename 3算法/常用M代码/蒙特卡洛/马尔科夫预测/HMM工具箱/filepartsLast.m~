function [last] = filepartsLast(fname)
% filepartsLast Return the last part of a filename (strip off directory and suffix)
% function filepartsLast(fname)
%
% Examples
% filepartsLast('C:/foo/bar') = 'bar'
% filepartsLast('C:/foo/bar.mat') = 'bar'
% filepartsLast('C:/foo/bar.mat.gz') = 'bar.mat'
% filepartsLast('bar.mat') = 'bar'

[pathstr,name,ext,versn] = fileparts(fname);
last = name;
