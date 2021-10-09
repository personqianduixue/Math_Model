function S=GraphicArea(varargin)
%GRAPHICAREA   使用定积分求平面图形的面积
% S=GRAPHICAREA(F,G,A,B,'dicarl')  计算直角坐标系下曲线F和G与直线X=A、X=B所围图形
%                                         的面积，适用于函数F和G只包含一个符号变量的情形
% S=GRAPHICAREA(F,G,X,A,B,'dicarl')  计算直角坐标系下曲线F和G与直线X=A、X=B所围
%                                           图形的面积，并指定符号自变量为X
% S=GRAPHICAREA(R,ALPHA,BETA,'polar')  计算极坐标系下曲线R与T=ALPHA、T=BETA所围图形
%                                              的面积，其中R只包含一个符号变量T
% S=GRAPHICAREA(R,T,ALPHA,BETA,'polar')  计算极坐标系下曲线R与T=ALPHA、T=BETA所围
%                                                图形的面积，并指定符号自变量为T
%
% 输入参数：
%     ---F,G：直角坐标系下曲线的函数描述
%     ---R：极坐标系下曲线的函数描述
%     ---A,B：直角坐标系下的积分下限与上限
%     ---ALPHA,BETA：极坐标系下的积分下限与上限
%     ---TYPE：坐标系类型，有'dicarl'和'polar'两种取值
% 输出参数：
%     ---S：返回的图形的面积
%
% See also int

args=varargin;
type=args{end};
switch lower(type)
    case 'dicarl'
        f1=args{1};
        f2=args{2};
        s=unique([symvar(f1),symvar(f2)]);
        if length(s)>1 || nargin==6
            x=args{3};
            a=args{4};
            b=args{5};
        else
            if nargin==5
                x=s;
                a=args{3};
                b=args{4};
            end
        end
        S=simple(int(f1-f2,x,a,b));
    case 'polar'
        r=args{1};
        s=symvar(r);
        if length(s)>1 || nargin==5
            t=args{2};
            alpha=args{3};
            beta=args{4};
        else
            if nargin==4
                t=s;
                alpha=args{2};
                beta=args{3};
            end
        end
        S=simple(1/2*int(r^2,t,alpha,beta));
    otherwise
        error('Illegal options.')
end
S=abs(S);
web -broswer http://www.ilovematlab.cn/forum-221-1.html