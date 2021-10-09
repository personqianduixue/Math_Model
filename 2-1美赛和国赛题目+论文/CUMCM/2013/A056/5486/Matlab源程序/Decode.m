function ret=Decode(lenchrom,bound,code,opts)
% 本函数对染色体进行解码
% lenchrom   input : 染色体长度
% bound      input : 变量取值范围
% code       input ：编码值
% opts       input : 解码方法标签
% ret        output: 染色体的解码值
switch opts
    case 'binary' % binary coding
        for i=length(lenchrom):-1:1
        data(i)=bitand(code,2^lenchrom(i)-1);  %并低十位，然后将低十位转换成十进制数存在data(i)里面
        code=(code-data(i))/(2^lenchrom(i));   %低十位清零，然后右移十位
        end
        ret=bound(:,1)'+data./(2.^lenchrom-1).*(bound(:,2)-bound(:,1))';  %分段解码，以实数向量的形式存入ret中
        
    case 'grey'   % grey coding
        for i=sum(lenchrom):-1:2
            code=bitset(code,i-1,bitxor(bitget(code,i),bitget(code,i-1)));
        end
        for i=length(lenchrom):-1:1
        data(i)=bitand(code,2^lenchrom(i)-1);
        code=(code-data(i))/(2^lenchrom(i));
        end
        ret=bound(:,1)'+data./(2.^lenchrom-1).*(bound(:,2)-bound(:,1))'; %分段解码，以实数向量的形式存入ret中
        
    case 'float'  % float coding
        ret=code; %解码结果就是编码结果（实数向量），存入ret中
end