function ff = DF1function(X1,Y1,H1,X2,Y2,H2)
%% 根据双峰函数返回数字坐标
% X1 Y1 H1   input    con1参数
% X2 Y2 H2   input    con2参数

%% 基本参数
XX=[X1,X2];
YY=[Y1,Y2];
N=2;
Hbase=[H1,H2];
%两山峰距离
D_ab=sqrt((XX(1)-XX(2))^2+(YY(1)-YY(2))^2);
[x,y]=meshgrid(-50:0.2:50);

%% 数字地图坐标
Hbase(1)=Hbase(1);
Rbase=[Hbase(1)/D_ab,Hbase(2)/D_ab];
for i=1:N
    H(i)=Hbase(i);
    R(i)=Rbase(i);
    f(:,:,i)=H(i)-R(i)*sqrt((x-XX(i)).^2+(y-YY(i)).^2);
end
[m,n,p]=size(f);
for i=1:m
    for j=1:n
       [OrderZ,IndexZ]=sort(f(i,j,:));
       ff(i,j)=f(i,j,IndexZ(N));
   end
end

end
