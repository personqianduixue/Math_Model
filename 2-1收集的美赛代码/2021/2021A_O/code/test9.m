function test9
x = [1,2,3;4,5,6;7,8,9];
idx = x == 9;
x(idx) = 10
x(~idx) = 0