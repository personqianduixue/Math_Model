% MATPRINT - prints a matrix with specified format string
%
% Usage: matprint(a, fmt, fid)
%
%                 a   - Matrix to be printed.
%                 fmt - C style format string to use for each value.
%                 fid - Optional file id.
%
% Eg. matprint(a,'%3.1f') will print each entry to 1 decimal place

% Peter Kovesi
% School of Computer Science & Software Engineering
% The University of Western Australia
% pk @ csse uwa edu au
% http://www.csse.uwa.edu.au/~pk
%
% March 2002

function matprint(a, fmt, fid)
    
    if nargin < 3
	fid = 1;
    end
    
    [rows,cols] = size(a);
    
    % Construct a format string for each row of the matrix consisting of
    % 'cols' copies of the number formating specification
    fmtstr = [];
    for c = 1:cols
      fmtstr = [fmtstr, ' ', fmt];
    end
    fmtstr = [fmtstr '\n'];    % Add a line feed
    
    fprintf(fid, fmtstr, a');  % Print the transpose of the matrix because
                               % fprintf runs down the columns of a matrix.