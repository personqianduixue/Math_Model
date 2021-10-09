%ZIPSAVE   Save data in compressed format
%
%	zipsave( filename, data )
%	filename: string variable that contains the name of the resulting 
%	compressed file (do not include '.zip' extension)
%	pkzip25.exe has to be in the matlab path. This file is a compression utility 
%	made by Pkware, Inc. It can be dowloaded from: http://www.pkware.com
%	This function was tested using 'PKZIP 2.50 Command Line for Windows 9x/NT'
%	It is important to use version 2.5 of the utility. Otherwise the command line below
%	has to be changed to include the proper options of the compression utility you 
%	wish to use.
%	This function was tested in MATLAB Version 5.3 under Windows NT.
%	Fernando A. Brucher - May/25/1999
%	
%	Example:
%		testData = [1 2 3; 4 5 6; 7 8 9];
%		zipsave('testfile', testData);
%
% Modified by Kevin Murphy, 26 Feb 2004, to use winzip
%------------------------------------------------------------------------

function zipsave( filename, data )

%--- Save data in a temporary file in matlab format (.mat)---

eval( ['save ''', filename, ''' data'] )


%--- Compress data by calling pkzip (comand line command) ---
% 	Options used: 
%	'add' = add compressed files to the resulting zip file
%	'silent' = no console output 
%	'over=all' = overwrite files

%eval( ['!pkzip25 -silent -add -over=all ', filename, '.zip ', filename,'.mat'] )
eval( ['!zip ', filename, '.zip ', filename,'.mat'] )

%--- Delete temporary matlab format file ---

delete( [filename,'.mat'] )


