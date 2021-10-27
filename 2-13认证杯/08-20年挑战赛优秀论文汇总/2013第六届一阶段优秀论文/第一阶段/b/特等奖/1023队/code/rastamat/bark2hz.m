function hz=bark2hz(z)
%       BARK2HZ         Converts frequencies Bark to Hertz (Hz)
%	function hz=bark2hz(z)
%         Traunmueller-formula    for    z >  2 Bark
%         linear mapping          for    z <= 2 Bark
%
%	Author:   Kyrill, Oct. 1996
%                 Kyrill, March 1997   (linear mapping added)
%

%hz_gt_2 = 1960 .* (z + 0.53) ./ (26.28 - z);
%hz_le_2 = z .* 102.9;
%
%hz = (z>2) .* hz_gt_2 + (z<=2) .* hz_le_2;

% Hynek's formula (2003-04-11 dpwe@ee.columbia.edu)
% (taken from rasta/audspec.c)
hz = 600 * sinh(z/6);
