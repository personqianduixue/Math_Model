function [AX,H1,H2]=plotxy(varargin)                                   
%PLOTXY   绘制双坐标系                                                       
% PLOTXY(X1,Y1,X2,Y2)  在双坐标系中使用plot函数分别绘制数据对X1-Y1和X2-Y2的图形             
% PLOTXY(X1,Y1,X2,Y2,FUN)  在双坐标系中使用绘图函数FUN分别绘制数据对X1-Y1和X2-Y2的          
%                               图形，FUN可以是MATLAB自带绘图函数，比如plot、semilogx、 
%                               loglog、stem等，也可以是用户自编绘图函数，但该自编函数必须     
%                               具有形如h=function(x,y)的调用格式               
% PLOTXY(X1,Y1,X2,Y2,FUN1,FUN2)  在双坐标系中使用绘图函数FUN1和FUN2分别绘制数据对X1-Y1     
%                                      和X2-Y2的图形，其中FUN1和FUN2的格式与FUN完全一样
% AX=PLOTXY(...)  绘制双坐标系图形并返回双坐标系的坐标轴句柄向量                              
% [AX,H1,H2]=PLOTXY(...)  绘制双坐标系图形并返回坐标轴句柄向量、坐标轴中的图形对象句柄               
%                                                                      
% 输入参数：                                                                
%     ---X1,Y1,X2,Y2：绘图数据                                              
%     ---FUN,FUN1,FUN2：指定的绘图函数                                         
% 输出参数：                                                                
%     ---AX：坐标轴句柄向量                                                    
%     ---H1,H2：两坐标系中的图形对象句柄                                            
%                                                                      
% See also PLOTYY                                                      
%                                                                      
args=varargin;                                                         
[x1,y1,x2,y2]=deal(args{1:4});                                         
if nargin<5, fun1 = @plot; else fun1 = args{5}; end                    
if nargin<6, fun2 = fun1;  else fun2 = args{6}; end                    
set(gcf,'NextPlot','add')                                              
hAxes1=axes;                                                           
h1=feval(fun1,hAxes1,x1,y1,'Color','b');                               
set(hAxes1,'XColor','b','YColor','b','Box','off')                      
hAxes2=axes('Position',get(hAxes1,'Position'));                        
h2=feval(fun2,hAxes2,x2,y2,'Color','r');                               
set(hAxes2,'Color','none','XColor','r','YColor','r','Box','off',...    
    'XAxisLocation','top','YAxisLocation','right')                     
if nargout==1                                                          
    AX=[hAxes1,hAxes2];                                                
elseif nargout==3                                                      
    AX=[hAxes1,hAxes2]; H1=h1; H2=h2;                                  
end                                                                    
web -broswer http://www.ilovematlab.cn/forum-221-1.html