function hanoi(n,A,B,C)                              
%HANOI   梵塔问题                                        
% HANOI(N,'A','B','C')  递归算法求梵塔问题                    
%                                                    
% 输入参数：                                              
%     ---N：盘的个数                                      
%     ---'A','B','C'：三个塔的名称                          
                                                     
fprintf('%d个盘子的移动步骤：\n',n)                           
count=1;                                             
move(n,A,B,C)                                        
    function move(n,A,B,C)                           
        if n==0                                      
            return                                   
        else                                         
            move(n-1,A,C,B)                          
            disp(['第',int2str(count),'步：',A,'-->',C])
            count=count+1;                           
            move(n-1,B,A,C)                          
        end                                          
    end                                              
end                                                  
web -broswer http://www.ilovematlab.cn/forum-221-1.html