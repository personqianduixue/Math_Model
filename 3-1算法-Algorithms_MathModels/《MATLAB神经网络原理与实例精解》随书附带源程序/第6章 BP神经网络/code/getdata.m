% È¡Êý¾Ý

function [data,label]=getdata(xlsfile)
% [data,label]=getdata('student.xls')
% read height,weight and label from a xls file

[~,label]=xlsread(xlsfile,1,'B2:B261');
[height,~]=xlsread(xlsfile,'C2:C261');
[weight,~]=xlsread(xlsfile,'D2:D261');

data=[height,weight];
l=zeros(size(label));
for i=1:length(l)
   if label{i}== 'ÄÐ'
       l(i)=1;
   end
end

label=l;

