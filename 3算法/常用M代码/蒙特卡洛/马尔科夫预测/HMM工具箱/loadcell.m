function [lc,dflag,dattype]=loadcell(fname,delim,exclusions,options);
%function [lc,dflag,numdata]=loadcell(fname,delim,exclusions);
%  
%  loadcell loads a cell array with character delimited
%  data, which can have variable length lines and content.
%  Numeric values are converted from string to double 
%  unless options is a string containing 'string'.
%  
%  loadcell is for use with small datasets. It is not optimised
%  for large datasets.
% 
%  fname is the filename to be loaded
%
%  delim is/are the relevant delimiter(s). If char(10) is included
%  newlines are simply treated as delimiters and a 1-d array is created.
%
%  exclusions  are the set of characters to be treated as paired
%    braces: line ends or delimiters within braces are ignored.
%    braces are single characters and any brace can pair with 
%    any other brace: no type pair checking is done.
%
%  options can be omitted or can contain 'string' if no numeric
%    conversion is required, 'single' if multiple adjacent seperators
%    should not be treated as one, 'free' if all linefeeds should be stripped
%    first and 'empty2num' if empty fields are to be treated as numeric 
%    zeros rather than an empty character set. Combine options using 
%    concatenation.
%
%  lc is a cell array containing the loaded data.
%
%  dflag is a set of flags denoting the (i,j) values where data was entered
%  dflag(i,j)=1 implies lc(i,j) was loaded from the data, and not just set
%  to empty, say, by default.
%
%  numdata is an array  numdata(i,j)=NaN implies
%    lc(i,j) is a string, otherwise it stores the number at i,j.
%    This will occur regardless of whether the 'string' option is set.
%
%  lc will return -1 if the file is not found or could not be
%  opened.
%
%  Hint: numdata+(1/dflag-1) provides a concise descriptor for the numeric data
%  Inf=not loaded
%  NaN=was string or empty set.
%  otherwise numeric
%
%  EXAMPLE
%
%[a,b]=loadcell('resultsfile',[',' char(9)],'"','single-string');
%   will load file 'resultsfile' into variable a, treating any of tab or 
%   comma as delimiters. Delimiters or carriage returns lying 
%   between two double inverted commas will be ignored. Two adjacent delimiters
%   will count twice, and all data will be kept as a string.
%
%   Note: in space-separated data 'single' would generally be omitted,
%   wheras in comma-seperated data it would be included.
%  
%   Note the exclusion characters will remain in the final data, and any data
%   contained within or containing exclusion characters will not be 
%   converted to numerics.
%
%   (c) Amos Storkey 2002
%    v b160702

% MATLAB is incapable of loading variable length lines or variable type values
% with a whole file command under the standard library sets. This mfile 
% fills that gap.
if (nargin<4) 
    options=' ';
end;
dflag = [];
%Open file
fid=fopen(fname,'rt');
%Cannot open: return -1
if (fid<0)
  lc=-1;
else
  fullfile=fread(fid,'uchar=>char')';
  %Strip LF if free is set
  if ~isempty(findstr(options,'free'))
      fullfile=strrep(fullfile,char(10),'');
  end;
  %Find all delimiters
  delimpos=[];
  for s=1:length(delim)
    delimpos=[delimpos find(fullfile==delim(s))];
  end
  %Find all eol
  endpos=find(fullfile==char(10));
  endpos=setdiff(endpos,delimpos);
  %find all exclusions
  xclpos=[];
  for s=1:length(exclusions);
    xclpos=[xclpos find(fullfile==exclusions(s))];
  end
  sort(xclpos);
  xclpos=[xclpos(1:2:end-1);xclpos(2:2:end)];
  %Combine eol and delimiters
  jointpos=union(delimpos,endpos);
  t=1;
  %Remove delim/eol within exclusion pairs
  removedelim=[];
  for s=1:length(jointpos)
    if any((jointpos(s)>xclpos(1,:)) & (jointpos(s)<xclpos(2,:)))
      removedelim(t)=jointpos(s);
      t=t+1;
    end;

  end
  %and add start point
  jointpos=[0 setdiff(jointpos,removedelim)];
  i=1;
  j=1;
  posind=1;
  multflag=isempty(findstr(options,'single'));
  stringflag=~isempty(findstr(options,'string'));
  emptnum=~isempty(findstr(options,'empty2num'));
  %Run through
  while (posind<(length(jointpos)))
    %Get current field
    tempstr=fullfile(jointpos(posind)+1:jointpos(posind+1)-1);
    %If empty only continue if adjacent delim count.
    if ~(isempty(tempstr) & multflag);
      %This ij is set
      dflag(i,j)=1;
      %Convert to num
      tempno=str2double([tempstr]);
      %If emptystring convert to zero if emptnum set
      if (isempty(tempstr) & emptnum)
          tempno=0;
      end;
      %Set dattype to no (or NaN if not a num
      dattype(i,j)=tempno;
      %If NaN set lc to string else to num if stringflag not set
      if (isnan(tempno) |  stringflag) 
        lc{i,j}=tempstr;
      else
        lc{i,j}=tempno;
      end;
      %Next j
      j=j+1;
    end;
    %If eol inc i and reset j
    if ismember(jointpos(posind+1),endpos)
        i=i+1;
        j=1;
    end;
    %Inc to next delim
    posind=posind+1;      
  end;
end;
%Logicalise dflag
dflag=logical(dflag);
