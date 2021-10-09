function [val,G] = gaZBGrad(sol)

% Constrain minimizes so we have to take the - to maximize
val = -(21.5 + sol(1) * sin(4*pi*sol(1)) + sol(2)*sin(20*pi*sol(2)));
G=zeros(0);