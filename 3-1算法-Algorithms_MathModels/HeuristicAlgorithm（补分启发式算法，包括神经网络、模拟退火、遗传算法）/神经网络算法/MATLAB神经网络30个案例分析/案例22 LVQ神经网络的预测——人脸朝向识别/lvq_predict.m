function result=lvq_predict(P,Tc,Num_Compet,w1,w2)
n=size(P,2);
result=zeros(2,n);
result(1,:)=Tc;
for i=1:n
    d=zeros(Num_Compet,1);
    for j=1:Num_Compet
        d(j)=sqrt(sse(w1(j,:)'-P(:,i)));
    end
    n1=compet(-1*d);
    n2=purelin(w2*n1);
    result(2,i)=vec2ind(n2);
end
Num_Correct=length(find(result(2,:)==Tc));
accuracy=Num_Correct/n;
disp(['accuracy=' num2str(accuracy*100) '%(' num2str(Num_Correct) '/' num2str(n) ')']);