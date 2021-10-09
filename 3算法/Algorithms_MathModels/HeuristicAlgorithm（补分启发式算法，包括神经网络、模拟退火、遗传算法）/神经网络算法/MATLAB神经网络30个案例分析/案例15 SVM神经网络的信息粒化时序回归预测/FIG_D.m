function [low,R,up]=FIG_D(XX,MFkind,win_num)
% by Li Yang BNU MATH 05 Email:farutoliyang@gmail.com QQ:516667408
% last modified 2009.2.25
%modified IG based on Pedry by Keqiang Dong
%output
%low:low bounds
%R:representatives
%up:up bounds
%input
%X:times series waited to be IG
%MFkind:the kind of membership function
%triangle trapezoid asygauss asyparabola
%win_num:number of windows
%%

if nargin < 3
    win_num = 10;
end
if nargin < 2
    MFkind = 'trapezoid';
end

[d1,d2] = size(XX);
X = sort(XX);
switch MFkind 
% trapezoid  
    case('trapezoid')       
        if win_num == 1
            if mod(d2,2) ~= 0
                m = X( (d2+1)/2 );
                n = X( (d2+1)/2 );
                mflag = (d2+1)/2;
                nflag = (d2+1)/2;
            else
                m = X( d2/2 );
                n = X( (d2+2)/2 );
                mflag = d2/2;
                nflag = (d2+2)/2;
            end
            
            R(1,1) = m;
            R(2,1) = n;
            
            k1 = mflag;
            k2 = d2 - nflag+1;
            c1 = ( sum(X(1:k1)) )/k1;
            c2 = ( sum(X(nflag:d2)) )/k2;
            
            low = 2*c1 - m;
            up = 2*c2 - n;
            
        else
            low = [];
            R = [];
            up = [];
            k = floor(d2/win_num);
            for i = 1:(win_num-1)
                [l,r,u]=FIG_D(XX( (1+(i-1)*k):(k+(i-1)*k) ),MFkind,1);
                low = [low,l];
                R = [R,r];
                up = [up,u];
            end
            [l,r,u] = FIG_D(XX( (1+(win_num-1)*k):d2 ),MFkind,1);
            low =[low,l];
            R = [R,r];
            up = [up,u];
        end
%% triangle
    case('triangle')
        if win_num == 1
            
            R = median(X);
            m = median(X);
            n = median(X);
            
            mflag = floor(d2/2);
            nflag = ceil(d2/2);
            k1 = mflag;
            k2 = d2-nflag+1;
            c1 = ( sum(X(1:k1)) )/k1;
            c2 = ( sum(X(nflag:d2)) )/k2;
            
            low = 2*c1 - m;
            up = 2*c2 - n;
            
        else
            low = [];
            R = [];
            up = [];
            k = floor(d2/win_num);
            for i = 1:(win_num-1)
                [l,r,u]=FIG_D(XX( (1+(i-1)*k):(k+(i-1)*k) ),MFkind,1);
                low = [low,l];
                R = [R,r];
                up = [up,u];
            end
            [l,r,u] = FIG_D(XX( (1+(win_num-1)*k):d2 ),MFkind,1);
            low =[low,l];
            R = [R,r];
            up = [up,u];
        end
%% asygauss       
    case('asygauss')  %这个与基于Pedrycz的是一样的，因为高斯型的核函数无法修改
        if win_num == 1
            R = median(X);
            m = median(X);
            n = median(X);
            
            mflag = floor(d2/2);
            nflag = ceil(d2/2);
            
            a_final = 0;
            Qa_final = 0;
            for index = 1:( mflag-1 )
                a = X(index);
                Qa=0;              
                x = X( 1:(mflag-1) );
                y = (x<=m).*(exp(-(x-m).^2/a^2) );
                Qa = sum(y);
                Qa = Qa/(m-a);
                    if Qa>=Qa_final
                        Qa_final = Qa;
                        a_final = a;
                    end                              
            end
            
            low = a_final;
            
            b_final = 0;
            Qb_final = 0;
            for index = ( nflag+1 ):d2
                b = X(index);
                Qb = 0;                
                x = X( (nflag+1):d2 );
                y = (x>=m).*(exp(-(x-m).^2/b^2) );   
                Qb = sum(y);
                Qb = Qb/(b-n);
                    if Qb>=Qb_final
                        Qb_final = Qb;
                        b_final = b;
                    end
            end
            
            up = b_final;
            
        else
            low = [];
            R = [];
            up = [];
            k = floor(d2/win_num);
            for i = 1:(win_num-1)
                [l,r,u]=FIG_P(XX( (1+(i-1)*k):(k+(i-1)*k) ),MFkind,1);
                low = [low,l];
                R = [R,r];
                up = [up,u];
            end
            [l,r,u] = FIG_P(XX( (1+(win_num-1)*k):d2 ),MFkind,1);
            low =[low,l];
            R = [R,r];
            up = [up,u];
        end               
%% asyparabola       
    case('asyparabola')   
        if win_num == 1
            R = median(X);
            m = median(X);
            n = median(X);
            
            mflag = floor(d2/2);
            nflag = ceil(d2/2);

            a_final = 0;
            Qa_final = 0;
            for index = 1:( mflag-1 )
                a = X(index);
                Qa=0;             
                x = X( 1:( mflag-1) );          
                y=(x<=m).*(1-(m-x).^2/(m-a)^2);               
                Qa = sum(y);
                Qa = Qa/(m-a);
                    if Qa>=Qa_final
                        Qa_final = Qa;
                        a_final = a;
                    end                                
            end
            
            low = a_final;
            
            b_final = 0;
            Qb_final = 0;
            for index = ( nflag+1 ):d2
                b = X(index);
                Qb = 0;             
                x = X( (nflag+1):d2 );
                y=(x>=m).*(1-(m-x).^2/(m-b)^2);
                Qb = sum(y);
                Qb = Qb/(b-n);
                    if Qb>=Qb_final
                        Qb_final = Qb;
                        b_final = b;
                    end   
            end
            
            up = b_final;
            
       else
            low = [];
            R = [];
            up = [];
            k = floor(d2/win_num);
            for i = 1:(win_num-1)
                [l,r,u]=FIG_P(XX( (1+(i-1)*k):(k+(i-1)*k) ),MFkind,1);
                low = [low,l];
                R = [R,r];
                up = [up,u];
            end
            [l,r,u] = FIG_P(XX( (1+(win_num-1)*k):d2 ),MFkind,1);
            low =[low,l];
            R = [R,r];
            up = [up,u];
        end                
end        
