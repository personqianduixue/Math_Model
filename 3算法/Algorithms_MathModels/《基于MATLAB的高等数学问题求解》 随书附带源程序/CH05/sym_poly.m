function c=sym_poly(s,v,flag)                                
%SYM_POLY   符号多项式与多项式系数之间的相互转换                               
% C=SYM_POLY(S,V,1)或C=SYM_POLY(S,V,'sym2poly')  提取符号多项式S的系数向量
% S=SYM_POLY(C,V,2)或S=SYM_POLY(C,V,'poly2sym')  由系数向量C创建符号多项式
%                                                            
% 输入参数：                                                      
%     ---S：输入的符号多项式                                          
%     ---V：符号多项式的符号自变量                                       
%     ---C：输入的系数向量                                           
%     ---FLAG：指定转化方向，当FLAG=1或'sym2poly'表示由多项式向系数向量转化；        
%                当FLAG=2或'poly2sym'表示由系数向量向多项式转化             
% 输出参数：                                                      
%     ---C：返回的符号多项式的系数向量                                     
%     ---S：由系数向量创建得到的符号多项式                                   
%                                                            
% See also poly2sym, sym2poly                                
                                                             
k=1;                                                         
switch flag                                                  
    case {1,'sym2poly'}                                      
        c=subs(s,v,0);                                       
        while 1                                              
            ds=diff(s,v);                                    
            c=[subs(ds,v,0)/prod(1:k),c];                    
            s=ds;                                            
            if ~ismember(sym(v),symvar(ds))                  
                break                                        
            end                                              
            k=k+1;                                           
        end                                                  
    case {2,'poly2sym'}                                      
        n=length(s);                                         
        c=s*(sym(v)).^(n-1:-1:0).';                          
    otherwise                                                
        error('Error flag.')                                 
end                                                          
web -broswer http://www.ilovematlab.cn/forum-221-1.html