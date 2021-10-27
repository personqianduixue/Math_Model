function [d,fp,dt,tc,t]=readhtk(file)
%READHTK  read an HTK parameter file [D,FP,DT,TC,T]=(FILE)
%
% d is data, fp is frame period in seconds
% dt is data type, tc is full type code, t is a text version of the full typecode
% tc is the sum of the following values:
%			0		WAVEFORM
%			1		LPC
%			2		LPREFC
%			3		LPCEPSTRA
%			4		LPDELCEP
%			5		IREFC
%			6		MFCC
%			7		FBANK
%			8		MELSPEC
%			9		USER
%			10		DISCRETE
%                       11              PLP
%			64		-E		Includes energy terms
%			128	_N		Suppress absolute energy
%			256	_D		Include delta coefs
%			512	_A		Include acceleration coefs
%			1024	_C		Compressed
%			2048	_Z		Zero mean static coefs
%			4096	_K		CRC checksum (not implemented yet)
%			8192	_0		Include 0'th cepstral coef


%      Copyright (C) Mike Brookes 1997
%
%      This version modified to read HTK's compressed feature files
%      2005-05-18 dpwe@ee.columbia.edu
%
%   VOICEBOX home page: http://www.ee.ic.ac.uk/hp/staff/dmb/voicebox/voicebox.html
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   This program is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   This program is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You can obtain a copy of the GNU General Public License from
%   ftp://prep.ai.mit.edu/pub/gnu/COPYING-2.0 or by writing to
%   Free Software Foundation, Inc.,675 Mass Ave, Cambridge, MA 02139, USA.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fid=fopen(file,'r','b');
if fid < 0
   error(sprintf('Cannot read from file %s',file));
end
nf=fread(fid,1,'long');
fp=fread(fid,1,'long')*1.E-7;
by=fread(fid,1,'short');
tc=fread(fid,1,'short');
hb=floor(tc*pow2(-14:-6));
hd=hb(9:-1:2)-2*hb(8:-1:1);
dt=tc-64*hb(9);

% hd(7)=1 CRC check
% hd(5)=1 compressed data

if ( dt == 0 ),
  d=fread(fid,Inf,'short');
else
  if (hd(5) == 1) 
    % compressed data - first read scales
    nf = nf - 4;
    ncol = by / 2;
    scales = fread(fid, ncol, 'float');
    biases = fread(fid, ncol, 'float');
    d = fread(fid,[ncol, nf], 'short');
    d = repmat(1./scales,1,nf).*(d+repmat(biases,1,nf));
    d = d.';
  else
    d=fread(fid,[by/4,nf],'float').';
  end
end;
fclose(fid);
if nargout > 2
   hd(7)=0;
   hd(5)=0;
   ns=sum(hd);
   kinds=['WAVEFORM  ';'LPC       ';'LPREFC    ';'LPCEPSTRA ';'LPDELCEP  ';'IREFC     ';'MFCC      ';'FBANK     ';'MELSPEC   ';'USER      ';'DISCRETE  ';'PLP       ';'???       '];
   kind=kinds(min(dt+1,size(kinds,1)),:);
   cc='ENDACZK0';
   t=[kind(1:min(find(kind==' '))-1) reshape(['_'*ones(1,ns);cc(hd>0)],1,2*ns)];
end
