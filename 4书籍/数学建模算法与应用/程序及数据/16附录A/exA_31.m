clc, clear
fid=fopen('data4.txt','w');
a=normrnd(0,1,100,200);
fprintf(fid,'%f\n',a');
fclose(fid);
