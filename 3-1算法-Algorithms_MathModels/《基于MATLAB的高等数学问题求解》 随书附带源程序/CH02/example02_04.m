web -broswer http://www.ilovematlab.cn/forum-221-1.html
month=input('请输入月份month=');  % 提示输入月份            
if month>12 || month<1 || mod(month,1)~=0  % 判断条件
    error('输入的月份必须是1~12的整数！')  % 不符合条件则给出错误提示    
end                                              
switch month                                     
    case {3 4 5}                                 
        season='spring';                         
    case {6 7 8}                                 
        season='summer';                         
    case {9 10 11}                               
        season='autumn';                         
    otherwise                                    
        season='winter';                         
end                                              
