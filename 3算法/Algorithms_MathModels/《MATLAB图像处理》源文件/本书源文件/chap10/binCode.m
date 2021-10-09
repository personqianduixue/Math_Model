function s=binCode(a)
%求任意整数的二进制码
if a>=0
    s=dec2bin(a);
else
%求a的反码，返回“01”字符串，按位取反
    s=dec2bin(abs(a));
    for t=1:numel(s)
        if s(t)=='0'
            s(t)='1';
        else s(t)='0';
        end
    end
end
