function mkdirKPM(dname)
% function mkdirKPM(dname)
% If directory does not exist, make it
% 
% mkdirKPM('foo\bar\baz') makes subdirectories bar and baz
% mkdirKPM('foo\bar\baz.txt') makes subdirectories bar 

% convert foo\bar\baz to pathstr=foo\bar, name=baz
% convert foo\bar\baz.txt to pathstr=foo\bar, name=baz
[pathstr, name, ext, versn] = fileparts(dname);
if ~isempty(ext) % we stripped off something after final period
  % convert foo\bar to pathstr=foo, name=bar
  % convert foo\bar.bad to pathstr=foo, name=bar.bad
  [pathstr, name, ext, versn] = fileparts(pathstr);
  name = sprintf('%s%s', name, ext); % in case there is a period in the directory name
end

dname = fullfile(pathstr, name);
if ~exist(dname, 'dir')
  %fprintf('mkdirKPM: making %s, %s \n', pathstr, name);
  mkdir(pathstr, name)
else
  %fprintf('mkdirKPM: %s already exists\n', dname)
end
