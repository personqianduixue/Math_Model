%ZIPLOAD   Load compressed data file created with ZIPSAVE
%
%	[data] = zipload( filename )
%	filename: string variable that contains the name of the 
%	compressed file (do not include '.zip' extension)
%	Use only with files created with 'zipsave'
%	pkzip25.exe has to be in the matlab path. This file is a compression utility 
%	made by Pkware, Inc. It can be dowloaded from:	http://www.pkware.com
%	Or directly from ftp://ftp.pkware.com/pk250c32.exe, for the Windows 95/NT version.
%	This function was tested using 'PKZIP 2.50 Command Line for Windows 9x/NT'
%	It is important to use version 2.5 of the utility. Otherwise the command line below
%	has to be changed to include the proper options of the compression utility you 
%	wish to use.
%	This function was tested in MATLAB Version 5.3 under Windows NT.
%	Fernando A. Brucher - May/25/1999
%	
%	Example:
%		[loadedData] = zipload('testfile');
%--------------------------------------------------------------------

function [data] = zipload( filename )

%--- Decompress data file by calling pkzip (comand line command) ---
% 	Options used: 
%	'extract' = decompress file
%	'silent' = no console output 
%	'over=all' = overwrite files

%eval( ['!pkzip25 -extract -silent -over=all ', filename, '.zip'] )
eval( ['!pkzip25 -extract -silent -over=all ', filename, '.zip'] )


%--- Load data from decompressed file ---
%	try, catch takes care of cases when pkzip fails to decompress a 
%	valid matlab format file

try
   tmpStruc = load( filename );
   data = tmpStruc.data;
catch, return, end


%--- Delete decompressed file ---

delete( [filename,'.mat'] )


