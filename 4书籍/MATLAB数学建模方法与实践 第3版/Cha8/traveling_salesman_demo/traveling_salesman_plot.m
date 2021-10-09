function state = traveling_salesman_plot(options,state,flag,locations)
%   TRAVELING_SALESMAN_PLOT Custom plot function for traveling salesman.
%   STATE = TRAVELING_SALESMAN_PLOT(OPTIONS,STATE,FLAG,LOCATIONS) Plot city
%   LOCATIONS and connecting route between them. This function is specific
%   to the traveling salesman problem.

%   Copyright 2004-2006 The MathWorks, Inc.
persistent x y xx yy
if strcmpi(flag,'init')
  load('usborder.mat','x','y','xx','yy');
end
% plot(x,y,'Color','red');
% hold on;
[unused,i] = min(state.Score);
genotype = state.Population{i};

plot(locations(:,1),locations(:,2),'bo');
axis([-0.1 1.5 -0.2 1.2]);
hold on
plot(locations(genotype,1),locations(genotype,2));
xlabel('城市的横坐标x'); ylabel('城市的纵坐标y'); 
grid on
hold off
