% f6_bubbles_dyn.m
% 2 separate Schaffer's F6 functions, one with min at [-8,-8] and the
% other with min at [8,8]
% as time goes on, each bubbles magnitude cycles up and down, 
% they are 180 deg out of phase with each other
%
% commonly used to test optimization/global minimization problems

function [out]=f6_bubbles_dyn(in)
 persistent tnot
 
% find starting time
 if ~exist('tnot') | length(tnot)==0
    tnot = cputime;
 end
 time = cputime/10 - tnot;
 
% calculate offset for whole function
 %[xc,yc]=spiral_dyn(1,.1);
 xc = 0;
 yc = xc;
 
% parse input
 x    = in(:,1) +xc;
 y    = in(:,2) +yc;
 
% bubble centers 
 x1   = -8;
 y1   = x1;
 x2   = 8;
 y2   = x2;
 
% f6 #1 (bubble #1)
 num  = sin(sqrt((x-x1).^2+(y-y1).^2)).^2 - 0.5;
 den  = (1.0+0.01*((x-x1).^2+(y-y1).^2)).^2;
 f6_1 = (0.5 + num./den).*abs(sin(time+pi/2));
% bubble #1 offset 
 num_ofs  = sin(sqrt((10000-x1).^2+(10000-y1).^2)).^2 - 0.5;
 den_ofs  = (1.0+0.01*((10000-x1).^2+(10000-y1).^2)).^2;
 f6_1_ofs = (0.5 + num_ofs./den_ofs).*abs(sin(time+pi/2));
 
% f6 #2 (bubble #2)
 num  = sin(sqrt((x-x2).^2+(y-y2).^2)).^2 - 0.5;
 den  = (1.0+0.01*((x-x2).^2+(y-y2).^2)).^2;
 f6_2 = (0.5 + num./den).*abs(sin(time));
% bubble #2 offset 
 num_ofs  = sin(sqrt((10000-x2).^2+(10000-y2).^2)).^2 - 0.5;
 den_ofs  = (1.0+0.01*((10000-x2).^2+(10000-y2).^2)).^2;
 f6_2_ofs = (0.5 + num_ofs./den_ofs).*abs(sin(time));
 
% output & return
 out  = 2*((f6_1 + f6_2) - (f6_1_ofs + f6_2_ofs));
 return