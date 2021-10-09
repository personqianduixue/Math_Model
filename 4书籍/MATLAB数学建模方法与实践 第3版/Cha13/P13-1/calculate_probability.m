function p_temp_sub = calculate_probability(m,n,type);
%n选m时各奖项的获奖概率
% type代表当前求解的彩票类型
% K1型是固定概率，无需在这里计算

if (type == 2)
	% K2型的
	p_temp_sub=zeros(7,1);
	p_temp_sub(1)=1/mmmcomb(n,m);
	p_temp_sub(2)=mmmcomb(m,m-1)./mmmcomb(n,m);
	p_temp_sub(3)=mmmcomb(m,m-1).*mmmcomb(n-m-1,1)./mmmcomb(n,m);
	p_temp_sub(4)=mmmcomb(m,m-2).*mmmcomb(n-m-1,1)./mmmcomb(n,m);
	p_temp_sub(5)=mmmcomb(m,m-2).*mmmcomb(n-m-1,2)./mmmcomb(n,m);
	p_temp_sub(6)=mmmcomb(m,m-3).*mmmcomb(n-m-1,2)./mmmcomb(n,m);
	p_temp_sub(7)=mmmcomb(m,m-3).*mmmcomb(n-m-1,3)./mmmcomb(n,m);
elseif (type == 3)
	% K3型的
	p_temp_sub=zeros(7,1);
	p_temp_sub(1)=1./mmmcomb(n,m+1);
	p_temp_sub(2)=mmmcomb(n-m-1,1)./mmmcomb(n,m+1);
	p_temp_sub(3)=mmmcomb(m,m-1).*mmmcomb(n-m-1,1)./mmmcomb(n,m+1);
	p_temp_sub(4)=mmmcomb(m,m-1).*mmmcomb(n-m-1,2)./mmmcomb(n,m+1);
	p_temp_sub(5)=mmmcomb(m,m-2).*mmmcomb(n-m-1,2)./mmmcomb(n,m+1);
	p_temp_sub(6)=mmmcomb(m,m-2).*mmmcomb(n-m-1,3)./mmmcomb(n,m+1);
	p_temp_sub(7)=mmmcomb(m,m-3).*mmmcomb(n-m-1,3)./mmmcomb(n,m+1);
elseif (type == 4)
	% K4型的
	p_temp_sub=zeros(7,1);
	p_temp_sub(1)=1./mmmcomb(n,m);
	p_temp_sub(2)=mmmcomb(m,m-1).*mmmcomb(n-m,1)./mmmcomb(n,m);
	p_temp_sub(3)=mmmcomb(m,m-2).*mmmcomb(n-m,2)./mmmcomb(n,m);
	p_temp_sub(4)=mmmcomb(m,m-3).*mmmcomb(n-m,3)./mmmcomb(n,m);
	p_temp_sub(5)=mmmcomb(m,m-4).*mmmcomb(n-m,4)./mmmcomb(n,m);
	p_temp_sub(6)=0;
	p_temp_sub(7)=0;
else
	error('Error in calculate_probability!');
end


function combi = mmmcomb(n,m)
%求从n个数中取出m个数的组合数
if (isscalar(n)) && (isscalar(m)) &&...
		(isreal(n)) && (isreal(m)) && (n>=m) && (m>0)
    combi=factorial(n)./factorial(m)./factorial(n-m);
else
    error('A mistake occurs when calculating combinations.')
end
