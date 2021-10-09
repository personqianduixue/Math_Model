function [out,varargout]=normmat(x,newminmax,flag)
% normmat.m
% takes a matrix and reformats the data to fit between a new range
% 
% Usage:
%    [xprime,mins,maxs]=normmat(x,range,method)
%
% Inputs:
%     x - matrix to reformat of dimension MxN
%     range - a vector or matrix specifying minimum and maximum values for the new matrix
%         for method = 0, range is a 2 element row vector of [min,max]
%         for method = 1, range is a 2 row matrix with same column size as 
%                         input matrix with format of [min1,min2,...minN;
%                                                      max1,max2,...maxM];
%         for method = 2, range is a 2 column matrix with same row size as
%                         input matrix with format of [min1,max1;
%                                                      min2,max2;
%                                                      ... , ...;
%                                                      minM,maxM];
%             alternatively for method 1 and 2, can input just a 2 element vector as in method 0
%             this will just apply the same min/max across each column or row respectively
%     method - a scalar flag with the following function
%         = 1, normalize each column of the input matrix separately
%         = 2, normalize each row of the input matrix separately
%         = 0, normalize matrix globally
% Outputs:
%     xprime - new matrix normalized per method
%     mins,maxs - optional outputs return the min and max vectors of the original matrix x
%         used for recovering original matrix from xprime
%
% example: x = [-10,3,0;2,4.1,-7;3.4,1,0.01]
%          [xprime,mins,maxs]=normmat(x,[0,10],0)

% Brian Birge
% Rev 2.1
% 3/16/06 - changed name of function to avoid same name in robust control
% toolbox
%--------------------------------------------------------------------------------------------------------
if flag==0

  a=min(min((x)));
  b=max(max((x)));
  if abs(a)>abs(b)
     large=a;
     small=b;
  else
     large=b;
     small=a;
  end
  temp=size(newminmax);
  if temp(1)~=1
     error('Error: for method=0, range vector must be a 2 element row vector');
  end  
  den=abs(large-small);  
  range=newminmax(2)-newminmax(1);
  if den==0
     out=x;
  else     
     z21=(x-a)/(den);  
     out=z21*range+newminmax(1)*ones(size(z21));
  end
  
%--------------------------------------------------------------------------------------------------------  
elseif flag==1
 a=min(x,[],1);
 b=max(x,[],1);
  for i=1:length(b)
     if abs(a(i))>abs(b(i))
        large(i)=a(i);
        small(i)=b(i);
     else
        large(i)=b(i);
        small(i)=a(i);
     end
  end
  den=abs(large-small);
  temp=size(newminmax);
  if temp(1)*temp(2)==2
     newminmaxA(1,:)=newminmax(1).*ones(size(x(1,:)));
     newminmaxA(2,:)=newminmax(2).*ones(size(x(1,:)));
  elseif temp(1)>2
     error('Error: for method=1, range matrix must have 2 rows and same columns as input matrix');
  else
     newminmaxA=newminmax;
  end
  
  range=newminmaxA(2,:)-newminmaxA(1,:);  
  for j=1:length(x(:,1))    
     for i=1:length(b)
        if den(i)==0
           out(j,i)=x(j,i);
        else
           z21(j,i)=(x(j,i)-a(i))./(den(i));
           out(j,i)=z21(j,i).*range(1,i)+newminmaxA(1,i);
        end
     end     
  end  
%--------------------------------------------------------------------------------------------------------  
elseif flag==2
  a=min(x,[],2);
  b=max(x,[],2);
  for i=1:length(b)
     if abs(a(i))>abs(b(i))
        large(i)=a(i);
        small(i)=b(i);
     else
        large(i)=b(i);
        small(i)=a(i);
     end 
  end
  den=abs(large-small);
  temp=size(newminmax);
  if temp(1)*temp(2)==2
     newminmaxA(:,1)=newminmax(1).*ones(size(x(:,1)));
     newminmaxA(:,2)=newminmax(2).*ones(size(x(:,1)));    
  elseif temp(2)>2
     error('Error: for method=2, range matrix must have 2 columns and same rows as input matrix');
  else
     newminmaxA=newminmax;
  end
  
  range=newminmaxA(:,2)-newminmaxA(:,1);  
  for j=1:length(x(1,:))
     for i=1:length(b)
        if den(i)==0
           out(i,j)=x(i,j);
        else           
           z21(i,j)=(x(i,j)-a(i))./([forcecol(den(i))]);
           out(i,j)=z21(i,j).*range(i,1)+newminmaxA(i,1);
        end
     end     
  end  
  
end
%--------------------------------------------------------------------------------------------------------
varargout{1}=a;
varargout{2}=b;

return