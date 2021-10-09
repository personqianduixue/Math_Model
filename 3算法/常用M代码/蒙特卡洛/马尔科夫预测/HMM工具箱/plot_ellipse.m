% PLOT_ELLIPSE
% h=plot_ellipse(x,y,theta,a,b)
%
% This routine plots an ellipse with centre (x,y), axis lengths a,b
% with major axis at an angle of theta radians from the horizontal.

%
% Author: P. Fieguth
%         Jan. 98
%
%http://ocho.uwaterloo.ca/~pfieguth/Teaching/372/plot_ellipse.m

function h=plot_ellipse(x,y,theta,a,b)

np = 100;
ang = [0:np]*2*pi/np;
R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
pts = [x;y]*ones(size(ang)) + R*[cos(ang)*a; sin(ang)*b];
h=plot( pts(1,:), pts(2,:) );
