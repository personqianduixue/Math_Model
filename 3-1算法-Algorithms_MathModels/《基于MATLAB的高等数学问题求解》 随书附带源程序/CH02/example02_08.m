web -broswer http://www.ilovematlab.cn/forum-221-1.html
flag=1;                                                       
while flag                                                    
    r=randi(100);                                             
    k=0;                                                      
    while 1                                                   
        guess=input('Please input the guessed data¡Ê[1,100]£º');
        k=k+1;                                                
        if guess>r                                            
            disp('Too High!')                                 
        elseif guess<r                                        
            disp('Too Low!')                                  
        else                                                  
            disp('Right!')                                    
            flag=input('Try again?[1/0]£º');                   
            break                                             
        end                                                   
    end                                                       
    fprintf('Total Times£º%d\n',k)                             
end                                                           
