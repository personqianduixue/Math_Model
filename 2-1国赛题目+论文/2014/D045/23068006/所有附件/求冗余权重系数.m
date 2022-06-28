function B = jryl( A )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(A);

for i=1:m
    
    if A(i,1)<=15&A(i,1)>=10
        B(i,2)=(19-A(i,1)-4)*A(i,3);
        B(i,1)=A(i,1);
    elseif A(i,1)<=27&A(i,1)>=16
        B(i,2)=(31-A(i,1)-4)*A(i,3);
         B(i,1)=A(i,1);
    elseif A(i,1)<=35&A(i,1)>=28
             B(i,2)=(39-A(i,1)-4)*A(i,3);
         B(i,1)=A(i,1);
         
         elseif A(i,1)<=45&A(i,1)>=36
             B(i,2)=(49-A(i,1)-4)*A(i,3);
         B(i,1)=A(i,1);
         
 elseif A(i,1)<=56&A(i,1)>=46
        B(i,2)=(60-A(i,1)-4)*A(i,3);
          B(i,1)=A(i,1);
    end
end
end