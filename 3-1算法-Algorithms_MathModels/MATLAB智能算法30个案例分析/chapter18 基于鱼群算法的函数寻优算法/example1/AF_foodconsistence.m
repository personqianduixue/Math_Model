function [Y]=AF_foodconsistence(X)
fishnum=size(X,2);
for i=1:fishnum
     Y(1,i)=X(i)*sin(10*pi*X(i))+2;
end

