web -broswer http://www.ilovematlab.cn/forum-221-1.html
N=input('Please input an even：');                          
while mod(N,2)~=0 || N<4                                   
    disp('The Number you input is Invalid. Press again...')
    N=input('Please input an even：');                      
end                                                        
p=1; flag=1;                                               
while flag                                                 
    p=p+1;                                                 
    q=N-p;                                                 
    if isprime(p) && isprime(q)                            
        fprintf('验证式子：%d=%d+%d\n',N,p,q)                   
        flag=0;                                            
    end                                                    
end                                                        
