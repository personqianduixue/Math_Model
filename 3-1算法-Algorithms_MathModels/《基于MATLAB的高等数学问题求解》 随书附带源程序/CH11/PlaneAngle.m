function theta=PlaneAngle(PI1,PI2)
%PLANEANGLE   求两平面的夹角
% T=PLANEANGLE(PI1,PI2)  求平面PI1和PI2的夹角
%
% 输入参数：
%     ---PI1,PI2：两平面的系数向量
% 输出参数：
%     ---T：返回的平面的夹角
%
% See also subspace

if isa([PI1;PI2],'sym')
    PI1=[diff(PI1,'x'),diff(PI1,'y'),diff(PI1,'z')];
    PI2=[diff(PI2,'x'),diff(PI2,'y'),diff(PI2,'z')];
end
if isvector(PI1) && isvector(PI2)
    if length(PI1)==3 && length(PI2)==3
        theta=subspace(PI1(:),PI2(:));
    else
        error('输入向量必须为三维向量.')
    end
else
    error('Illegal Input arguments.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html