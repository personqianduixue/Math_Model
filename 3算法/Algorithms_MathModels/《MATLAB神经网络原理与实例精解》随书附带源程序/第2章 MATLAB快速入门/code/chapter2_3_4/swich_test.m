% switch_test.m
value=input('请输入一个0~9的整数：');
switch value,								%switch语句
    case {1,3,5,7,9},
        fprintf('输入的数字是奇数!\n');
    case {0,2,4,6,8},
        fprintf('输入的数字是偶数!\n');
    otherwise
        fprintf('输入的不是0~9的整数!\n');
end
