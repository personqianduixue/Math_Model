function X=AF_init(Nfish,lb_ub)
%输入：
% Nfish 鱼群大小
% lb_ub 鱼的活动范围

%输出：
% X     产生的初始人工鱼群

% example：
% Nfish=3;
% lb_ub=[-3.0,12.1,1;4.1,5.8,1]; 
%%这里的lb_ub是2行3列的矩阵，每行中前两个数是范围的上下限，第3个数是在该范围内的数的个数
% X=Inital(Nfish,lb_ub)  
%%就是产生[-3.0,12.1]内的数1个，[4.1,5.8]内的数1个
%%两个数一组，这样的数一共Nfish个
row=size(lb_ub,1);
X=[];
for i=1:row
    lb=lb_ub(i,1);
    ub=lb_ub(i,2);
    nr=lb_ub(i,3);
    for j=1:nr
        X(end+1,:)=lb+(ub-lb)*rand(1,Nfish);
    end
end
