web -broswer http://www.ilovematlab.cn/forum-221-1.html
sum1=0;sum2=0;                                                   
n=input('Enter the number of points：');  % 提示键入数值个数              
if n<2                                                           
    warning('MATLAB:Numberofinputs','At least 2 values needed.') 
else                                                             
    for k=1:n                                                    
       x=input('Enter values：');                                 
       sum1=sum1+x;                                              
       sum2=sum2+x^2;                                            
    end                                                          
    xaver=sum1/n;  % 平均值计算公式                                     
    s=sqrt((n*sum2-sum1^2)/(n*(n-1)));  % 标准差计算公式                
    disp(['平均值：',num2str(xaver),sprintf('\n'),'标准差：',num2str(s)])
end                                                              
