function [w1,w2]=lvq1_train(P,Tc,Num_Compet,pc,lr,maxiter)
%% 初始化权系数矩阵
% 输入层与竞争层之间权值
bound=minmax(P);
w1=repmat(mean(bound,2)',Num_Compet,1);
% 竞争层与输出层之间权值
Num_Output=length(pc);
pc=pc(:);
indices=[0;floor(cumsum(pc)*Num_Compet)];
w2=zeros(Num_Output,Num_Compet);
for i=1:Num_Output
  w2(i,(indices(i)+1):indices(i+1)) = 1;
end
%% 迭代计算
n=size(P,2);
for k=1:maxiter
    for i=1:n
        d=zeros(Num_Compet,1);
        for j=1:Num_Compet
            d(j)=sqrt(sse(w1(j,:)'-P(:,i)));
        end
        [min_d,index]=min(d);
        n1=compet(-1*d);
        n2=purelin(w2*n1);
        if isequal(Tc(i),vec2ind(n2));
            w1(index,:)=w1(index,:)+lr*(P(:,i)'-w1(index,:));
        else
            w1(index,:)=w1(index,:)-lr*(P(:,i)'-w1(index,:));
        end
    end
end