function C=Direction_Cosine(r)
%DIRECTION_COSINE   求向量的方向余弦
% DIRECTION_COSINER(R)  绘制向量R与各坐标轴的位置关系
% C=DIRECTION_COSINE(R)  求向量R的方向余弦
%
% 输入参数：
%     ---R：给定向量
% 输出参数：
%     ---C：向量的方向余弦
%
% See also Distance, drawvec

[m,n]=size(r);
if m~=1 && n~=1
    error('向量的坐标表示形式有误.')
end
L=Distance(r);
Cosine=r/L;
if nargout==0
    if isnumeric(Cosine) && (n==2 || n==3)
        drawvec(r)
        hold on
        drawvec([r(1),0,0])
        drawvec([0,r(2),0])
        drawvec([0,0,r(3)])
        title(['方向余弦：[',num2str(Cosine),']'])
    else
        C=Cosine;
    end
else
    C=Cosine;
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html