function C=mat_add(varargin)                    
%MAT_ADD   求任意个相同维数矩阵的和                         
% C=MAT_ADD(A,B,...)  计算多个矩阵的和                  
%                                               
% 输入参数：                                         
%     ---A,B,...：维数相同的矩阵                        
% 输出参数：                                         
%     ---C：返回的和矩阵                               
                                                
error(nargchk(2,inf,nargin))                    
C=varargin{1};                                  
s=size(C);                                      
for k=2:numel(varargin)                         
    B=varargin{k};                              
    s1=size(B);                                 
    if isequal(s,s1)                            
        C=C+B;                                  
    else                                        
        error('Martix dimension does''t match.')
    end                                         
end                                             
web -broswer http://www.ilovematlab.cn/forum-221-1.html