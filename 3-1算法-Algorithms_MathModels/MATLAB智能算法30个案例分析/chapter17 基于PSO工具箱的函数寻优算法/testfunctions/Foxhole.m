% Foxhole.m
% Foxhole function, 2D multi-minima function
% 
% from: http://www.cs.rpi.edu/~hornda/pres/node10.html
%
% f(x) = 0.002 + sum([1/(j + sum( [x(i) - a(i,j)].^6 ) )])
% 
% x = 2 element row vector containing [ x, y ]
% each row is processed independently,
% you can feed in matrices of timeX2 no prob
%
% example: cost = Foxhole([1,2;3,4])
% note: known minimum =0 @ (-32,-32) unless you change 'a' in the function

% Brian Birge
% Rev 1.0
% 9/12/04
function [out]=Foxhole(in)
 x=in(:,1);
 y=in(:,2);
 
% location of foxholes, you can change this, these are what DeJong used
% if you change 'em, a{1} and a{2} must each have same # of elements
 a{1} = [... 
         -32 -16   0  16  32 ;...
         -32 -16   0  16  32 ;...
         -32 -16   0  16  32 ;...
         -32 -16   0  16  32 ;...
         -32 -16   0  16  32 ;...
        ];

 a{2} = [...
         -32 -32 -32 -32 -32 ;...
         -16 -16 -16 -16 -16 ;...
           0   0   0   0   0 ;...
          16  16  16  16  16 ;...
          32  32  32  32  32 ;...
        ];

 term_sum=0;   
 for j=1:prod(size((a{1})))
    ax=a{1} (j);
    ay=a{2} (j);
    term_num = (x - ax).^6 + (y - ay).^6;
    term_sum=term_sum+ 1./(j+term_num);
 end
 out = .002 + term_sum;