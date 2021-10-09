% % % % º∆À„du
function du=diff_u(V,d)
global A D
n=size(V,1);
sum_x=repmat(sum(V,2)-1,1,n);
sum_i=repmat(sum(V,1)-1,n,1);
V_temp=V(:,2:n);
V_temp=[V_temp V(:,1)];
sum_d=d*V_temp;
du=-A*sum_x-A*sum_i-D*sum_d;