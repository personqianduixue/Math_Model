web -broswer http://www.ilovematlab.cn/forum-221-1.html
s=input('请输入明文：','s');                                 
for k=1:length(s)                                      
    if s(k)>='a' && s(k)<='z' || s(k)>='A' && s(k)<='Z'
        s(k)=s(k)+4;                                   
        if s(k)>'Z' && s(k)<='Z'+4 || s(k)>'z'         
            s(k)=s(k)-26;                              
        end                                            
    end                                                
end                                                    
fprintf('相应的密文：%s\n',s)                                
