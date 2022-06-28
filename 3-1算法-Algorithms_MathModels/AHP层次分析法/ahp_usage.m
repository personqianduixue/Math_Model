clear all
w=[1 1 1 1 1 5 5 1;
    1 1 1 1 1 5 5 1;
    1 1 1 1 1 5 5 1;
    1 1 1 1 1 5 5 1;
    1 1 1 1 1 5 5 1;
    1/5 1/5 1/5 1/5 1/5 1 1 1/5;
    1/5 1/5 1/5 1/5 1/5 1 1 1/5;
    1 1 1 1 1 1/5 1/5 1];
[x,y]=eig(w);
eigenvalue=diag(y);
lamda=max(eigenvalue);
ci1=abs(lamda-8)/7;
cr1=ci1/1.41;
cr1
w1=x(:,1)/sum(x(:,1))                    %W1和W2的权向量

w=[1 5/3 5/3 5/3 5/3 5 5 1;
    3/5 1 1 1 1 3 3 3/5;
    3/5 1 1 1 1 3 3 3/5;
    3/5 1 1 1 1 3 3 3/5; 
    3/5 1 1 1 1 3 3 3/5;
    1/5 1/3 1/3 1/3 1/3 1 1 1/5; 
    1/5 1/3 1/3 1/3 1/3 1 1 1/5;
    1 5/3 5/3 5/3 5/3 5 5 1];
[x,y]=eig(w);
eigenvalue=diag(y);
lamda=max(eigenvalue);
ci1=abs(lamda-8)/7;
cr1=ci1/1.41;
cr1
w1=x(:,1)/sum(x(:,1))                     %W3的权向量

w=[1 1 5/3; 1 1 5/3;3/5 3/5 1];
[x,y]=eig(w);
eigenvalue=diag(y);
lamda=max(eigenvalue);
ci1=(lamda-3)/2;
cr1=ci1/0.52;
cr1
w1=x(:,1)/sum(x(:,1))         %W总的权向量
