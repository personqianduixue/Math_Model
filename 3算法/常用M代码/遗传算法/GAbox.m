%求解y=variable .* sin(10 * pi * variable) + 2.0的最大值
figure(1);
fplot('variable .* sin(10 * pi * variable) + 2.0',[-1, 2]);%画出目标函数图
%定义遗传算法参数
NIND = 40;%个体数目
MAXGEN = 25;%最大遗传代数
PRECI = 20;%变量的二进制位数（注：也就是精度）
GGAP = 0.9;%代沟
trace = zeros(2, MAXGEN);%寻优结果，初始值
FieldD = [20; -1;2;1;0;1;1];%区域描述器
Chrom = crtbp(NIND,PRECI);%初始种群
gen = 0;%代计数器
variable = bs2rv(Chrom,FieldD);%初始种群转成十进制数
ObjV = variable .* sin(10 * pi * variable) + 2.0;%目标函数值
while gen <= MAXGEN,

    FitnV = ranking(-ObjV);%分配适应度值
%（注：函数ranking的功能是：基于排序的适应度值分配，根据个体的目标值由小到大的顺序对它们进行排序，
%并返回一包含对应个体适应度值FitnV的列向量。
%压差是指：分配的个体适应度值的差距，最好的和最坏的，他对原来的函数值没有影响，只是根据原来的函数值来分配一个体现个体优劣的一个值。）
SelCh = select('sus',Chrom,FitnV,GGAP);%选择
SelCh = recombin('xovsp',SelCh,0.7);%重组，即交叉
SelCh = mut(SelCh); %变异
variable = bs2rv(SelCh,FieldD);%子代十进制转换
ObjVSel = variable .* sin(10 * pi * variable) + 2.0;%子代目标函数值
[Chrom ObjV] = reins(Chrom, SelCh, 1, 1, ObjV, ObjVSel);%重插入子代新种群
gen = gen + 1; %(注：matlab不支持gen += 1）
[Y,I] = max(ObjV),hold on;
plot(variable, Y, 'bo');
trace(1, gen) = max(ObjV); %遗传算法性能跟踪
trace(2, gen) = sum(ObjV) / length(ObjV);
end
variable = bs2rv(Chrom, FieldD);%最优个体的十进制转换
hold on,
grid;
plot(variable, ObjV, 'b*');
figure(2);
plot(trace(1, :));
hold on
plot(trace(2, :),'-.'); grid;
legend('解的变化', '种群均值的变化');