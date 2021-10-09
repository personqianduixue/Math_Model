mex ind2subv.c
mex subv2ind.c
mex normalise.c
mex -c mexutil.c
if ~isunix 
  mex repmatC.c mexutil.obj
else
  mex repmatC.c mexutil.o
end
