function z= hz2bark(f)
%       HZ2BARK         Converts frequencies Hertz (Hz) to Bark
%	function z= hz2bark(f)
%	Uses 
%         Traunmueller-formula    for    f >  200 Hz
%         linear mapping          for    f <= 200 Hz
%
%	Author:   Kyrill, Oct. 1996
%                 Kyrill, March 1997   (linear mapping added)
%

%z_gt_200 = 26.81 .* f ./ (1960 + f) - 0.53;
%z_le_200 = f ./ 102.9; 
%
%z = (f>200) .* z_gt_200 + (f<=200) .* z_le_200;

% Inverse of Hynek's formula (see bark2hz)
z = 6 * asinh(f/600);

% Formula used in rasta/rasta.h
%z = 6 * log(f/600 + sqrt(1+ ((f/600).^2)));
% They are the same!