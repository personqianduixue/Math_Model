function h=drawvec(r,x0)
%DRAWVEC   绘制向量
% DRAWVEC(R)  绘制起点为原点，终点为R的向量
% DRAWVEC(R,X0)  绘制起点为X0，终点为R的向量
% H=DRAWVEC(...)  绘制向量并返回向量句柄
%
% 输入参数：
%     ---R：需要绘制的向量，numel(R)=2或3
%     ---X0：向量的起点
% 输出参数：
%     ---H：向量句柄，是一个组对象
%
% See also line, patch

if nargin==1
    x0=zeros(size(r));
end
if ~isvector(r)
    error('The Input argument must a vector.')
end
r=r(:)'; x0=x0(:)';
n=length(r);
hp=hggroup;
if n==2
    line('XData',[x0(1),x0(1)+r(1)],'YData',[x0(2),x0(2)+r(2)],...
        'Parent',hp,'Tag','handle');
    [X,Y]=CalArrow(r,pi/9);
    patch('XData',X+x0(1),'YData',Y+x0(2),'Parent',hp,...
        'FaceColor','k','EdgeColor','k','Tag','arrow');
elseif n==3
    if all(r==0)
        error('输入向量不能为零向量.')
    elseif isequal(r(1:2),zeros(1,2))
        line('XData',[x0(1),x0(1)+r(1)],'YData',[x0(2),x0(2)+r(2)],...
            'ZData',[x0(3),x0(3)+r(3)],'Parent',hp,'Tag','handle');
        [Y,Z]=CalArrow(r(2:3),pi/9);
        patch('XData',x0(1)*ones(size(Y)),'YData',Y+x0(2),'ZData',Z+x0(3),...
            'Parent',hp,'FaceColor','k','EdgeColor','k','Tag','arrow');
        view(3)
    else
        line('XData',[x0(1),x0(1)+r(1)],'YData',[x0(2),x0(2)+r(2)],...
            'ZData',[x0(3),x0(3)+r(3)],'Parent',hp,'Tag','handle');
        [X,Y]=CalArrow(r(1:2),pi/9);
        X=norm(r)/norm(r(1:2))*X;
        Y=norm(r)/norm(r(1:2))*Y;
        if r(3)>=0  % 第Ⅰ、Ⅱ、Ⅲ、Ⅳ卦限
            theta=atan(abs(r(3))/norm(r(1:2)));
        else  % 第Ⅴ、Ⅵ、Ⅶ、Ⅷ卦限
            theta=-atan(abs(r(3))/norm(r(1:2)));
        end
        [X,Y,Z]=rotation(X,Y,zeros(size(X)),cross(r,[0,0,1]),theta);
        patch('XData',X+x0(1),'YData',Y+x0(2),'ZData',Z+x0(3),...
            'Parent',hp,'FaceColor','k','EdgeColor','k','Tag','arrow');
        view(3)
    end
else
    error('The Input argument must a 1-by-2 or 1-by-3 vector.')
end
grid on
if nargout==1
    h=hp;
end
    function [X,Y]=CalArrow(r,theta)
        if ~isvector(r)
            error('The Input argument must a vector.')
        end
        if length(r)~=2
            error('The Input argument must a 1-by-2 vector.')
        end
        r=r(:);
        T=@(t)[cos(t),-sin(t);sin(t),cos(t)];
        x1=[zeros(size(r)),1/15*r];
        xu=bsxfun(@plus,T(pi-theta)*x1,r);
        xd=bsxfun(@plus,T(pi+theta)*x1,r);
        xm=29/30*r;
        X=[xu(1,:),xm(1),fliplr(xd(1,:))];
        Y=[xu(2,:),xm(2),fliplr(xd(2,:))];
    end
    function [X,Y,Z]=rotation(x,y,z,direction,alpha,origin)
        if nargin==5
            origin=[0,0,0];
        end
        if ~isequal(size(x),size(y)) || ~isequal(size(x),size(z)) ||...
                ~isequal(size(y),size(z))
            error('坐标数据维数不匹配.')
        end
        x1=x(:); y1=y(:); z1=z(:);
        if ~(isvector(direction) && length(direction)==3)
            error('旋转向量必须为1-by-3向量.')
        end
        dirct=direction(:)/norm(direction);
        D=dirct*dirct';
        A=[0,-dirct(3),dirct(2);
            dirct(3),0,-dirct(1);
            -dirct(2),dirct(1),0];
        I=eye(3);
        M=D+cos(alpha)*(I-D)+sin(alpha)*A;
        origin=repmat(origin(:)',length(x1),1);
        Pr=([x1,y1,z1]-origin)*M'+origin;
        X=reshape(Pr(:,1),size(x));
        Y=reshape(Pr(:,2),size(y));
        Z=reshape(Pr(:,3),size(z));
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html