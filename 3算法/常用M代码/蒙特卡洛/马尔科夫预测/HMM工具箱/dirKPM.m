function filenames = dirKPM(dirname, ext, varargin)
% dirKPM Like the built-in dir command, but returns filenames as a cell array instead of a struct
%
% filenames = dirKPM(dirname)
% returns all files, except '.' and '..'
%
% filenames = dirKPM('images', '*.jpg')
% returns files with this extension
%   eg filenames{1} = 'foo.jpg' etc
%
% OPTIONAL ARGUMENTS [default in brackets]
% filenames = dirKPM('images', '', param1, val1, param2, val2, ...)
%
% 'fileType'='image' ['all'] means return files with extension .jpg, .png, .bmp
%
% 'prepend'=1 [0] means preprend folder name to filename
%    eg filenames{1} = 'images/foo.jpg'
%
% 'doSort'=1 [1] means sort filenames in ascending alphanumerical order (where possible)
%
% 'doRecurse'=1 [0] recursive dir, apply the same dirKPM call on all
% subfolders (decrease MAXDEPTH option to prevent recursion from branching
% too explosively)

if nargin < 1, dirname = '.'; end

if nargin < 2, ext = ''; end

[fileType, prepend, doSort, doRecurse, MAXDEPTH, DEPTH] = process_options(...
	varargin, 'fileType', 'all', 'prepend', 0, 'doSort', 1, 'doRecurse', 0,...
	'MAXDEPTH', 3, 'DEPTH', 0);

tmp = dir(fullfile(dirname, ext));
[filenames I] = setdiff({tmp.name}, {'.', '..'});
tmp = tmp(I);

if doRecurse && sum([tmp.isdir])>0 && DEPTH<MAXDEPTH
	for fi=1:length(tmp)
		subDirFilenames = {};

		if tmp(fi).isdir
			varargin = change_option( varargin, 'prepend', false );
			varargin = change_option( varargin, 'doSort', false );
			varargin = change_option( varargin, 'DEPTH', DEPTH+1 );
			subDirFilenames = dirKPM( fullfile(dirname,tmp(fi).name), ext, varargin{:} );

			for sdfi=1:length(subDirFilenames)
				subDirFilenames{sdfi} = fullfile(tmp(fi).name, subDirFilenames{sdfi});
			end
		end


		nfilenames = length(filenames);
		if length(subDirFilenames)>0
			filenames(nfilenames+1:nfilenames+length(subDirFilenames)) = subDirFilenames;
		end
	end
end

nfiles = length(filenames);
if nfiles==0 return; end

switch fileType
	case 'image',
		for fi=1:nfiles
			good(fi) = isImage(filenames{fi});
		end
		filenames = filenames(find(good));
	case 'all',
		% no-op
	otherwise
		error(sprintf('unrecognized file type %s', fileType));
end

if doSort
% 	% sort filenames alphanumerically (if possible)
%  DJE, buggy, MUST save tmp.anr/snr/str or else we potentially lose
%  filenames
% 	tmp = asort(filenames, '-s', 'ascend');
% 	if ~isempty(tmp.anr)
% 		filenames = tmp.anr';
% 	else
% 		filenames = tmp.str';
% 	end
	% if names could not be sorted, return original order

	filenames=sort(filenames);
	
end


if prepend
	nfiles = length(filenames);
	for fi=1:nfiles
		filenames{fi} = fullfile(dirname, filenames{fi});
	end
end

