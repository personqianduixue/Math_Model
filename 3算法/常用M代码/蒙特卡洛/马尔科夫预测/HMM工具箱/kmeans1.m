function [Yc,c,errlog]=kmeans1(Y,K,maxiter)
  [M, N]=size(Y);
  if  (K>M)
      error('MORE CENTROID than data vectors.')
  end 
  errlog=zeros(maxiter,1);
  %%%%%%%%%%%%%%%%%%%
  perm=randperm(M);
  Yc=Y(perm(1:K),:);
  d2y=(ones(K,1)*sum((Y.^2)'))';
  for i=1:maxiter
      Yc_old=Yc;
      d2=d2y+ones(M,1)*sum((Yc.^2)')-2*Y*Yc';
      [errvals,c]=min(d2');
      for k=1:K
          if(sum(c==k)>0)
          Yc(k,:) =sum(Y(c==k,:))/sum(c==k);   
          end 
      end
      errlog(i)=sum(errvals);
      fprintf(1,'...iteration%4d...Error%11.6f\n',i,errlog(i));
      %
      if (max(max(abs(Yc-Yc_old)))<10*eps)
          errlog=errlog(1:i);
          return
      end
  end
      