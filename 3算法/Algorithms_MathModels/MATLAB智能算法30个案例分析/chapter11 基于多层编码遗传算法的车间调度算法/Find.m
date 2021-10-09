function  Pos=Find(FindVal,S)

% S=[1 3 2 3 1 2 1 3 2];
% FindVal=3;

[m n]=size(S);

Pos=-1;
for i=1:n 
    if FindVal==S(i)
      Pos=i;
      break;
    end
end
