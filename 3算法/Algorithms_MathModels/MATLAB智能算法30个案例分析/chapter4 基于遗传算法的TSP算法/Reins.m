 %% 重插入子代的新种群
 %输入：
 %Chrom  父代的种群
 %SelCh  子代种群
 %ObjV   父代适应度
 %输出
 % Chrom  组合父代与子代后得到的新种群
function Chrom=Reins(Chrom,SelCh,ObjV)
NIND=size(Chrom,1);
NSel=size(SelCh,1);
[TobjV,index]=sort(ObjV);
Chrom=[Chrom(index(1:NIND-NSel),:);SelCh];
