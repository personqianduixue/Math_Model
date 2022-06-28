function s=Judgment(f,str)
%JUDGMENT   判断函数的单调性或凹凸性
% S=JUDGMENT(F,STR)
%
% 输入参数：
%     ---F：实数
%     ---STR：性质类型字符串元胞数组
% 输出参数：
%     ---S：返回的性质类型字符串
%
% See also iscellstr, cellstr

if ~iscellstr(str) || numel(str)~=2
    error('Input argument str is Illegal.')
end
if f<0
    s=str{1};
else
    s=str{2};
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html