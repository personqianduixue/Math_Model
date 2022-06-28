%% 变异操作
%输入：
%SelCh  被选择的个体
%Pm     变异概率
%输出：
% SelCh 变异后的个体
function SelCh=Mutate(SelCh,Pm)
[NSel,L]=size(SelCh);
for i=1:NSel
    if Pm>=rand
        R=randperm(L);
        SelCh(i,R(1:2))=SelCh(i,R(2:-1:1));
    end
end
