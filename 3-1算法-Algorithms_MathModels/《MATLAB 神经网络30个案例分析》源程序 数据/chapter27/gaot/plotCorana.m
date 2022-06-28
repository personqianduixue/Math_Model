function [z, a] = coranaEval(per)
i=0;
a=-0.9:per:0.9;
sz=size(a,2);
z=zeros(sz,sz);
for x=a
  i=i+1; j=0;
  for y=a
    j=j+1;
    z(i,j)=coranaFeval([x y]);
  end
end
%Done!

%First let's look at it in each dimension independently
clg
plot(z(:,1)) %Plot a slice of the function in x max 250.25
%Notice the range is [250.0-250.25]
pause %Strike any key to continue
clg
plot(z(1,:)) %Plot a slice of the function in y 
%Notice the range is [0-250]
pause %Strike any key to continue
mesh(a,a,z);
view(30,60);
grid;
