function H=FrequencyTable(X)
%FREQUENCYTABLE   统计数组元素出现的频数
% H=FREQUENCYTABLE(X)  统计矩阵X中各元素出现的频数
%
% 输入参数：
%     ---X：给定的数组或矩阵
% 输出参数：
%     ---H：返回的统计结果
%
% See also tabulate

if ~isa(X,'sym')
    H=tabulate(X);
    H=H(:,1:2);
else
    sortX=sort(X(:));
    D=[simple(sortX(2:end)-sortX(1:end-1));sym(1)];
    uniqueX=(D~=0);
    k=find([1;uniqueX]);
    H=[sortX(uniqueX) diff(k)];
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html