% ASORT
% a pedestrian NUMERICAL SORTER of ALPHANUMERIC data

% - create some data
		d = {
%		strings with one valid alphanumeric number
%		sorted numerically
			'-inf'
			'x-3.2e4y'
			'f-1.4'
			'-.1'
			'+ .1d-2'
			'.1'
			'f.1'
			'f -+1.4'
			'f.2'
			'f.3'
			'f.10'
			'f.11'
			'+inf'
			' -nan'
			'+ nan'
			'nan'
%		strings with many numbers or invalid/ambiguous numbers
%		sorted in ascii dictionary order
			' nan nan'
			'+ .1e-.2'
			'-1 2'
			'Z12e12ez'
			'inf -inf'
			's.3TT.4'
			'z12e12ez'
%		strings without numbers
%		sorted in ascii dictionary order
			' . .. '
			'.'
			'...'
			'.b a.'
			'a string'
			'a. .b'
		};
%   ... and scramble it...
		rand('seed',10);
		d=d(randperm(numel(d)));

% - run ASORT with
%   verbose output:		<-v>
%   keep additional results:	<-d>
		o=asort(d,'-v','-d');
% - or
%		p=asort(char(d),'-v','-d');

% - show results
		o
		o.anr

% - run ASORT with no-space/template options
%   NOTE the impact of -w/-t order!
		s={'ff - 1','ff + 1','- 12'};
%   RAW
		o=asort(s,'-v');
%   remove SPACEs
		o=asort(s,'-v','-w');
%   remove TEMPLATE(s)
		o=asort(s,'-v','-t',{'ff','1'});
%   remove TEMPLATE(s) than SPACEs
		o=asort(s,'-v','-t','1','-w');
%   remove SPACEs than TEMPLATE(s)
		o=asort(s,'-v','-w','-t','1');

