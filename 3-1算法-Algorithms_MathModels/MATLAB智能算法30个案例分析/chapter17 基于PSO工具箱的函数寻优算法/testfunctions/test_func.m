function z=test_func(in)
	nn=size(in);
	x=in(:,1);
	y=in(:,2);
	nx=nn(1);
   for i=1:nx
       temp = 0.5*(x(i)-3)^2+0.2*(y(i)-5)^2-0.1;
       z(i,:) = temp;
   end