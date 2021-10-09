function [x,y]=IntLp(f,G,h,Geq,heq,lb,ub,x,id,options)
%整数线性规划分枝定界法，可求解全整数线性或混合整数线性规划。
% y = min f'*x subject to: G*x <= h Geq*x=heq x为全整数或混合整% 数列向量
%用法
% [x,y]=IntLp(f,G,h)
% [x,y]=IntLp(f,G,h,Geq,heq)
% [x,y]=IntLp(f,G,h,Geq,heq,lb,ub)
% [x,y]=IntLp(f,G,h,Geq,heq,lb,ub,x)
% [x,y]=IntLp(f,G,h,Geq,heq,lb,ub,x,id)
% [x,y]=IntLp(f,G,h,Geq,heq,lb,ub,x,id,options)
%参数说明
% x：最优解列向量； y：目标函数最小值；f：目标函数系数列向量 
% G：约束不等式条件系数矩阵；h：约束不等式条件右端列向量
% Geq：约束等式条件系数矩阵；heq：约束等式条件右端列向量
% lb：解的下界列向量(Default: -inf)；ub：解的上界列向量(Default: inf)
% x：迭代初值列向量；
% id：整数变量指标列向量,1-整数，0-实数(Default: 1)
% options的设置请参见optimset或lingprog
%例 min Z=x1+4x2
% s.t. 2x1+x2<=8
% x1+2x2>=6
% x1, x2>=0且为整数
%先将x1+2x2>=6化为 - x1 - 2x2<= -6
%[x,y]=IntLp([1;4],[2 1;-1 -2],[8;-6],[],[],[0;0])



global upper opt c x0 A b Aeq beq ID options;
if nargin<10, options=optimset({});options.Display='off';
options.LargeScale='off';end
if nargin<9, id=ones(size(f));end
if nargin<8, x=[];end
if nargin<7|isempty(ub), ub=inf*ones(size(f));end
if nargin<6|isempty(lb), lb=zeros(size(f));end
if nargin<5, heq=[];end
if nargin<4, Geq=[];end
upper=inf;c=f;x0=x;A=G;b=h;Aeq=Geq;beq=heq;ID=id;
ftemp=ILP(lb(:),ub(:));
x=opt;y=upper;
%以下子函数
function ftemp=ILP(vlb,vub)
global upper opt c x0 A b Aeq beq ID options;
[x,ftemp,how]=linprog(c,A,b,Aeq,beq,vlb,vub,x0,options);
if how<=0
return;
end;
if ftemp-upper>0.00005 %in order to avoid error
return;
end;
if max(abs(x.*ID-round(x.*ID)))<0.00005
if upper-ftemp>0.00005 %in order to avoid error
opt=x';upper=ftemp;
return;
else 
opt=[opt;x'];
return;
end;end;
notintx=find(abs(x-round(x))>=0.00005); %in order to avoid error
intx=fix(x);tempvlb=vlb;tempvub=vub;
if vub(notintx(1,1),1)>=intx(notintx(1,1),1)+1
tempvlb(notintx(1,1),1)=intx(notintx(1,1),1)+1;
ftemp=ILP(tempvlb,vub);
end;
if vlb(notintx(1,1),1)<=intx(notintx(1,1),1)
tempvub(notintx(1,1),1)=intx(notintx(1,1),1);
ftemp=ILP(vlb,tempvub);
end;
