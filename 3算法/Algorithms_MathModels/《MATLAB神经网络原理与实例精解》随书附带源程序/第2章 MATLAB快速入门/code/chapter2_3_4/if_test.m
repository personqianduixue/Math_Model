% if_test.m
value=input('请输入一个正整数：');		% 从键盘接受输入
if value>=100
    fprintf('三位数以上\n');
elseif value>=10
    fprintf('两位数\n');
else
    fprintf('个位数\n');
end
