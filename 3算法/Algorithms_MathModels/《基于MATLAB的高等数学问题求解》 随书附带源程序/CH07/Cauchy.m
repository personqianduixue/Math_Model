function xi=Cauchy(fx,Fx,range)                                 
%CAUCHY   验证函数在某个区间上是否满足柯西中值定理                                  
% CAUCHY(F,G,RANGE)  以图形的方式演示函数在某个区间上的柯西中值定理                    
% XI=CAUCHY(F,G,RANGE)  返回函数在指定区间上的一个柯西中值点                      
%                                                               
% 输入参数：                                                         
%     ---F,G：函数的MATLAB描述，可以是匿名函数、内联函数和M文件                       
%     ---RANGE：指定的区间                                            
% 输出参数：                                                         
%     ---XI：柯西中值点                                               
%                                                               
% Sea also Rolle, Lagange                                       
                                                                
fab=subs(fx,range);                                             
Fab=subs(Fx,range);                                             
df=diff(fx);                                                    
dF=diff(Fx);                                                    
while 1                                                         
    x=fzero(inline(df/dF-diff(fab)/diff(Fab)),rand);            
    if prod(subs(Fx,x)-range)<=0                                
        break                                                   
    end                                                         
end                                                             
if nargout==1                                                   
    xi=x;                                                       
else                                                            
    ezplot(Fx,fx,range)                                         
    hold on                                                     
    x_range=[subs(Fx,x)-diff(Fab)/10,subs(Fx,x)+diff(Fab)/10];  
    y_range=diff(fab)/diff(Fab)*(x_range-subs(Fx,x))+subs(fx,x);
    plot(x_range,y_range,'k--')                                 
    title(['\xi=',num2str(x)])                                  
end                                                             
web -broswer http://www.ilovematlab.cn/forum-221-1.html