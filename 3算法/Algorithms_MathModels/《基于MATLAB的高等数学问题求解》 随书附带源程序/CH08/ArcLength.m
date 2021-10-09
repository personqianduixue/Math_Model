function L=ArcLength(varargin)
%ARCLENGTH   计算平面曲线的弧长
% L=ARCLENGTH(FUNX,FUNY,T,ALPHA,BETA,'dicarl')  计算直角坐标系下由参数方程
%                                                        所描述的平面曲线的弧长
% L=ARCLENGTH(FUN,T,ALPHA,BETA,'polar')  计算极坐标系下有FUN所描述的曲线的弧长
%
% 输入参数：
%     ---FUNX,FUNY：直角坐标系下平面曲线的参数方程
%     ---FUN：平面曲线的极坐标方程
%     ---ALPHA,BETA：积分的下限与上限
%     ---TYPE：坐标系类型，TYPE有以下两种取值：
%               1.'dicarl'或'd'或1：直角坐标系
%               2.'polar'或'p'或2：极坐标系
% 输出参数：
%     ---L：返回的平面曲线的弧长
%
% See also int

args=varargin;
type=args{end};
switch lower(type)
    case {1,'d','dicarl'}
        [funx,funy,t,alpha,beta]=deal(args{1:5});
    case {2,'p','polar'}
        [fun,t,alpha,beta]=deal(args{1:4});
        funx=fun*cos(t);
        funy=fun*sin(t);        
    otherwise
        error('Illegal options.')
end
dfx=diff(funx,t);
dfy=diff(funy,t);
L=simple(int(sqrt(dfx^2+dfy^2),t,alpha,beta));
web -broswer http://www.ilovematlab.cn/forum-221-1.html