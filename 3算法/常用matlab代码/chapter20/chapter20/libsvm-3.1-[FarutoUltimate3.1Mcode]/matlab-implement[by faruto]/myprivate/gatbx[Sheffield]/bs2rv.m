% BS2RV.m - Binary string to real vector
%
% This function decodes binary chromosomes into vectors of reals. The
% chromosomes are seen as the concatenation of binary strings of given
% length, and decoded into real numbers in a specified interval using
% either standard binary or Gray decoding.
%
% Syntax:       Phen = bs2rv(Chrom,FieldD)
%
% Input parameters:
%
%               Chrom    - Matrix containing the chromosomes of the current
%                          population. Each line corresponds to one
%                          individual's concatenated binary string
%			   representation. Leftmost bits are MSb and
%			   rightmost are LSb.
%
%               FieldD   - Matrix describing the length and how to decode
%			   each substring in the chromosome. It has the
%			   following structure:
%
%				[len;		(num)
%				 lb;		(num)
%				 ub;		(num)
%				 code;		(0=binary     | 1=gray)
%				 scale;		(0=arithmetic | 1=logarithmic)
%				 lbin;		(0=excluded   | 1=included)
%				 ubin];		(0=excluded   | 1=included)
%
%			   where
%				len   - row vector containing the length of
%					each substring in Chrom. sum(len)
%					should equal the individual length.
%				lb,
%				ub    - Lower and upper bounds for each
%					variable. 
%				code  - binary row vector indicating how each
%					substring is to be decoded.
%				scale - binary row vector indicating where to
%					use arithmetic and/or logarithmic
%					scaling.
%				lbin,
%				ubin  - binary row vectors indicating whether
%					or not to include each bound in the
%					representation range
%
% Output parameter:
%
%               Phen     - Real matrix containing the population phenotypes.

%
% Author: Carlos Fonseca, 	Updated: Andrew Chipperfield
% Date: 08/06/93,		Date: 26-Jan-94

function Phen = bs2rv(Chrom,FieldD)

% Identify the population size (Nind)
%      and the chromosome length (Lind)
[Nind,Lind] = size(Chrom);

% Identify the number of decision variables (Nvar)
[seven,Nvar] = size(FieldD);

if seven ~= 7
	error('FieldD must have 7 rows.');
end

% Get substring properties
len = FieldD(1,:);
lb = FieldD(2,:);
ub = FieldD(3,:);
code = ~(~FieldD(4,:));
scale = ~(~FieldD(5,:));
lin = ~(~FieldD(6,:));
uin = ~(~FieldD(7,:));

% Check substring properties for consistency
if sum(len) ~= Lind,
	error('Data in FieldD must agree with chromosome length');
end

if ~all(lb(scale).*ub(scale)>0)
	error('Log-scaled variables must not include 0 in their range');
end

% Decode chromosomes
Phen = zeros(Nind,Nvar);

lf = cumsum(len);
li = cumsum([1 len]);
Prec = .5 .^ len;

logsgn = sign(lb(scale));
lb(scale) = log( abs(lb(scale)) );
ub(scale) = log( abs(ub(scale)) );
delta = ub - lb;

Prec = .5 .^ len;
num = (~lin) .* Prec;
den = (lin + uin - 1) .* Prec;

for i = 1:Nvar,
    idx = li(i):lf(i);
    if code(i) % Gray decoding
	    Chrom(:,idx)=rem(cumsum(Chrom(:,idx)')',2);
    end
    Phen(:,i) = Chrom(:,idx) * [ (.5).^(1:len(i))' ];
    Phen(:,i) = lb(i) + delta(i) * (Phen(:,i) + num(i)) ./ (1 - den(i));
end

expand = ones(Nind,1);
if any(scale)
	Phen(:,scale) = logsgn(expand,:) .* exp(Phen(:,scale));
end
