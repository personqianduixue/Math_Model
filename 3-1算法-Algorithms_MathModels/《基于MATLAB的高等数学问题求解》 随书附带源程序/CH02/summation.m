function S = summation(n)                          
%SUMMATION   求和式1+2*3+3*4+4*5+...                  
% S=SUMMATION(N)  利用递归算法求和1+2*3+3*4+4*5+...+N*(N+1)
%                                                  
% 输入参数：                                            
%     ---N：项数                                      
% 输出参数：                                            
%     ---S：和式的和                                    
%                                                  
% See also sum, prod                               
                                                   
if n==1                                            
    S=1;                                           
else                                               
    S=n*(n+1)+summation(n-1);                      
end                                                
web -broswer http://www.ilovematlab.cn/forum-221-1.html