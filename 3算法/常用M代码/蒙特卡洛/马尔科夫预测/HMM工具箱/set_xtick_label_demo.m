
% Generate some test data.  Assume that the X-axis represents months.
x = 1:12;
y = 10*rand(1,length(x));

% Plot the data.
h = plot(x,y,'+');

% Add a title.
title('This is a title')

% Set the X-Tick locations so that every other month is labeled.
Xt = 1:2:11;
Xl = [1 12];
set(gca,'XTick',Xt,'XLim',Xl);

% Add the months as tick labels.
months = ['Jan';
	  'Feb';
	  'Mar';
	  'Apr';
	  'May';
	  'Jun';
	  'Jul';
	  'Aug';
	  'Sep';
	  'Oct';
	  'Nov';
	  'Dec'];

set_xtick_label(months(1:2:12, :), 90, 'xaxis label');



if 0


% Generate some test data.  Assume that the X-axis represents months.
x = 1:8;
y = 10*rand(1,length(x));

% Plot the data.
h = plot(x,y,'+');

S = subsets(1:3);
str = cell(1,8);
for i=1:2^3
  str{i} = num2str(S{i});
end
set_xtick_label(str);

end
