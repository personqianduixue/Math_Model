function [ T c ] = Fleuf1(d)
%d表示图的权值矩阵
% T表示边的集合，c表示权重和
% 注意：保证输入的矩阵所表示的图的是欧拉图，否则程序将报错
% 若存在欧拉回路，则输出结果将是该回路的顶点，其中顶点标号与
% 权值矩阵顶点标号相对应；若不存在欧拉回路，则输出不存在信息：T=0,c=0

b = d;
b(b==inf)=0;
b(b~=0)=1;
a = sum(b);
% 边的个数
eds = sum(a)/2;
ed = zeros(2,eds);
vexs = zeros(1,eds+1);
matr = b;

% 判断是否存在欧拉回路
a = mod(a,2);
x = sum(a);
if x ~= 0
    fprintf('There is not exist Euler path\n');
    T = 0;c =0;
end

if x==0
    vet = 1;
    flag = 0;
    t1 = find(matr(vet,:)==1);
    for ii = 1:length(t1)
        ed(:,1)=[vet,t1(ii)];
        vexs(1,1)=vet;vexs(1,2)=t1(ii);
        matr(vexs(1,2),vexs(1,1))=0;
        flagg = 1;tem = 1;
        while flagg
            [flagg ed]=edf(matr,eds,vexs,ed,tem);
            tem = tem + 1;
            if ed(1,eds) ~= 0 && ed(2,eds) ~= 0
                T = ed;
                T(2,eds)=1;
                c = 0;
                for g = 1:eds
                    c = c + d(T(1,g),T(2,g));
                end
                flagg=0;
                break;
            end
        end
    end
end
end

