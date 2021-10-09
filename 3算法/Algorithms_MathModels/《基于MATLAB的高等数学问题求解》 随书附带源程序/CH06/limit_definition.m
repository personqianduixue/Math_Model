disp('==判断常数A是否是函数f(x)在x0处的左极限==')       
A=input('请输入可能极限值A=');                   
x0=input('请输入极限点x0=');                   
f=input('请输入极限表达式f(x)=','s');            
n=1;flag=1;delta=1;                      
x=x0-delta;                              
while flag==1                            
    epsilon=input('任意输入一个任意小的数ε=');      
    while abs(eval(f)-A)>epsilon         
        delta=delta/2;                   
        x=x0-delta;                      
        if abs(delta)<eps                
            disp('找不到δ')                 
            n=0;break                    
        end                              
    end                                  
    if n==0                              
        disp('左极限不正确')                   
        break                            
    end                                  
    disp(['δ=',num2str(delta)])          
    flag=input('要再试一个ε吗？再试按1，否则按其他数字键：');
end                                      
web -broswer http://www.ilovematlab.cn/forum-221-1.html