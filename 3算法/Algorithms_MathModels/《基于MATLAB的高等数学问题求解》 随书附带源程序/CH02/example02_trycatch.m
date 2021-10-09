web -broswer http://www.ilovematlab.cn/forum-221-1.html
try                                                       
    index=input('Enter subscript of element to display£º');
    disp(['a(',int2str(index),')=',num2str(a(index))])    
catch                                                     
    disp(['Illegal subscript£º',int2str(index)])           
    A=lasterr;                                            
    disp(['Type of error£º',A])                            
end                                                       
