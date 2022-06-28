% example7_7.m
rand('state',pi);
a=rand(2,3)	
% a =
% 0.5162    0.1837    0.4272
% 0.2252    0.2163    0.9706
b=rand(2,3)	
% b =
% 0.8215    0.0295    0.2471
%  0.3693    0.1919    0.5672
c=[0; -1];
d=concur(c,3)
% d =
%  0     0     0
% -1    -1    -1
n = netsum({a,b,d})
% n =
% 1.3377    0.2132    0.6743
% -0.4054   -0.5918    0.5378
web -broswer http://www.ilovematlab.cn/forum-222-1.html