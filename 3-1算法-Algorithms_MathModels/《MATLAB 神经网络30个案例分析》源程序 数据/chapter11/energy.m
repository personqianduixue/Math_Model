% % % % % 计算能量函数
function E=energy(V,d)
global A D
n=size(V,1);
sum_x=sumsqr(sum(V,2)-1);
sum_i=sumsqr(sum(V,1)-1);
V_temp=V(:,2:n);
V_temp=[V_temp V(:,1)];
sum_d=d*V_temp;
sum_d=sum(sum(V.*sum_d));
E=0.5*(A*sum_x+A*sum_i+D*sum_d);