function varargout=standard_axes(axes_handle)
%STANDARD_AXES   创建标准坐标系
% STANDARD_AXES  将当前坐标系转化为标准坐标系
% STANDARD_AXES(H)  将由H指定的坐标系转化为标准坐标系
% AX=STANDARD_AXES(...)  返回转化后的标准坐标系的横轴和纵轴的句柄向量
% [AX1,AX2]=STANDARD_AXES(...)  返回转化后的标准坐标系的横轴句柄和纵轴句柄
%
% 输入参数：
%     ---H：指定的坐标轴句柄
% 输出参数：
%     ---AX,AX1,AX2：标准坐标系的横轴和纵轴句柄
%
% See also axes, annotation

if nargin==0
    axes_handle=gca;
end
pos=get(axes_handle,'Position');
x_Lim=get(axes_handle,'Xlim');
y_Lim=get(axes_handle,'Ylim');
x_Scale=get(axes_handle,'XScale');
y_Scale=get(axes_handle,'YScale');
color=get(gcf,'Color');
if prod(y_Lim)>0
    position_x=[pos(1),pos(2)+pos(4)/2,pos(3),eps];
else
    position_x=[pos(1),pos(2)-y_Lim(1)/diff(y_Lim)*pos(4),pos(3),eps];
end
axes_x=axes('Position',position_x,'Xlim',x_Lim,'Color',color,...
    'XScale',x_Scale,'YScale',y_Scale);
if prod(x_Lim)>0
    position_y=[pos(1)+pos(3)/2,pos(2),eps,pos(4)];
else
    position_y=[pos(1)-x_Lim(1)/diff(x_Lim)*pos(3),pos(2),eps,pos(4)];
end
axes_y=axes('Position',position_y,'Ylim',y_Lim,'Color',color,...
    'XScale',x_Scale,'YScale',y_Scale);
set(axes_handle,'Visible','off')
annotation('arrow',[pos(1)-0.065*pos(3),pos(1)+pos(3)+0.065*pos(3)],...
    [position_x(2)-0.001,position_x(2)-0.001],'HeadLength',6,'HeadWidth',6);
annotation('arrow',[position_y(1)+0.001,position_y(1)+0.001],...
    [pos(2)-0.065*pos(4),pos(2)+pos(4)+0.065*pos(4)],...
    'HeadLength',6,'HeadWidth',6);
if nargout==1
    varargout{1}=[axes_x,axes_y];
elseif nargout==2
    varargout{1}=axes_x;varargout{2}=axes_y;
elseif nargout>2
    error('Too many output arguments.');
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html