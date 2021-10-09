function V=SolidVolume(fun,x,a,b,type)
%SOLIDVOLUME   利用定积分求立体体积
% V=SOLIDVOLUME(FUN,X,A,B,TYPE)  计算指定类型的旋转体的体积，若曲线方程中包含
%                                      唯一符号自变量时，则绘制相应的旋转体图形
%
% 输入参数：
%     ---FUN：曲线的函数描述
%     ---X：符号自变量
%     ---A,B：指定的积分下限和上限
%     ---TYPE：旋转体类型，TYPE有以下取值：
%               1.'c'或0：已知平面截面积的立体体积
%               2.'x'或1：绕x轴旋转的旋转体
%               3.'y'或2：绕y轴旋转的旋转体
% 输出参数：
%     ---V：返回的图形面积或旋转体体积
%
% See also int, GraphicArea

s=symvar(fun);
switch type
    case {0,'c'}
        V=simple(int(fun,x,a,b));
    case {1,'x'}
        V=simple(int(pi*fun^2,x,a,b));
        if length(s)==1
            DrawSolid([0,1,0])
        end
    case {2,'y'}
        V=simple(int(pi*fun^2,x,a,b));
        if length(s)==1
            DrawSolid([1,0,0])
        end
    otherwise
        error('Illegal options.')
end
    function DrawSolid(direction)
        t=linspace(a,b,50);
        [X,Y,Z]=cylinder(subs(fun,x,t),50);
        h1=mesh(X,Y,a+(b-a)*Z);
        hidden off
        hold on
        h2=plot3(t,zeros(size(t)),subs(fun,x,t),'k','LineWidth',2);
        x_Lim=get(gca,'xlim');
        y_Lim=get(gca,'ylim');
        z_Lim=get(gca,'zlim');
        axis([x_Lim,y_Lim,z_Lim])
        h3=arrow([0,0,a],[0,0,b],'Length',20,'BaseAngle',30,...
            'TipAngle',20,'Width',2);
        rotate([h1,h2,h3],direction,90,[0,0,0]);
        if isequal(direction,[0,1,0])
            title('旋转轴：x轴')
            axis([z_Lim,y_Lim,x_Lim])
        elseif isequal(direction,[1,0,0])
            title('旋转轴：y轴')
            axis([x_Lim,z_Lim,y_Lim])
        end
        xlabel('x'); ylabel('y')
        h_legend=legend('旋转体','旋转曲线');
        set(h_legend,'Position',[0.13 0.87 0.22 0.1]);
    end
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html