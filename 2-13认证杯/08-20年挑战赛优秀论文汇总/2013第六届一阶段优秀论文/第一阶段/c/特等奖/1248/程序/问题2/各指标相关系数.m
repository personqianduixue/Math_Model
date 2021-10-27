r=zeros(10,4);
x=xlsread('模糊综合评价得分','最发达地区','B2:K180');
x=zscore(x);
rr=corrcoef(x);
r(:,1)=rr(:,end);

x=xlsread('模糊综合评价得分','较发达地区','B2:K2008');
x=zscore(x);
rr=corrcoef(x);
r(:,2)=rr(:,end);

x=xlsread('模糊综合评价得分','中度发达','B2:K298');
x=zscore(x);
rr=corrcoef(x);
r(:,3)=rr(:,end);

x=xlsread('模糊综合评价得分','欠发达','B2:K564');
x=zscore(x);
rr=corrcoef(x);
r(:,4)=rr(:,end);
