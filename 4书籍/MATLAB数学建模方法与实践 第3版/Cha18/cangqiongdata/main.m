clear all
p1 = [];
p2 = [];
s1 = [];
s2 = [];
q1 = [];
q2 = [];
for i = 17:20
    d = load(strcat('demand',num2str(i),'.txt'));
    s = load(strcat('distribute',num2str(i),'.txt'));
    [c,Q,s] = calcu_c(d,s);
    q1 = [q1;Q];
    s1 = [s1;s];
    c(c==inf) = -1;
    c(c<0) = max(c(:));
    pu = 3.56;
    p1 = [p1;(sum(Q(:))*c*pu)/sum(sum(Q.*c))];
end


for i = 13:16
    d = load(strcat('demand',num2str(i),'.txt'));
    s = load(strcat('distribute',num2str(i),'.txt'));
    [c,Q,s] = calcu_c(d,s);
    q2 = [q2;Q];
    s2 = [s2;s];
    c(c==inf) = -1;
    c(c<0) = max(c(:));
    pu = 1.78;
    p2 = [p2;(sum(Q(:))*c*pu)/sum(sum(Q.*c))];
end


