function [x] = parse(inStr)
% parse is a function which takes in a string vector of blank separated text
% and parses out the individual string items into a n item matrix, one row
% for each string.
%
% function [x] = parse(inStr)
% x     - the return matrix of strings
% inStr - the blank separated string vector

% Binary and Real-Valued Simulation Evolution for Matlab 
% Copyright (C) 1996 C.R. Houck, J.A. Joines, M.G. Kay 
%
% C.R. Houck, J.Joines, and M.Kay. A genetic algorithm for function
% optimization: A Matlab implementation. ACM Transactions on Mathmatical
% Software, Submitted 1996.
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 1, or (at your option)
% any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details. A copy of the GNU 
% General Public License can be obtained from the 
% Free Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

sz=size(inStr);
strLen=sz(2);
x=blanks(strLen);
wordCount=1;
last=0;
for i=1:strLen,
  if inStr(i) == ' '
    wordCount = wordCount + 1;
    x(wordCount,:)=blanks(strLen);
    last=i;
  else
    x(wordCount,i-last)=inStr(i);
  end
end
