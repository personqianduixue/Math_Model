x = -4:0.1:4;
y = logsig(x);
dy = dlogsig(x);
subplot(211);
plot(x, y);
title('logsig');
subplot(212);
plot(x, dy);
title('dlogsig');
