function varargout=reshapefile(file,n,extension,type)
%RESHAPEFILE   为程序的各行添加序号或删除程序各行的前n个字符
% RESHAPEFILE(FILE,N)  为FILE文件的各行添加序号并保存为TXT文件
% RESHAPEFILE(FILE,N,EXT)或 RESHAPEFILE(FILE,N,EXT,1)或
% RESHAPEFILE(FILE,N,EXT,'add')  为FILE文件的各行添加序号并
%                                保存为扩展名由EXT指定的文件
% RESHAPEFILE(FILE,N,EXT,2)或
% RESHAPEFILE(FILE,N,EXT,'delete')  删除FILE文件各行的前N个字符并
%                                   保存为扩展名由EXT指定的文件
% S=RESHAPEFILE(...)  将整形后的文件内容赋给S
%
% 输入参数：
%     ---FILE：原文件名，必须包含扩展名
%     ---N：指定序号所占的位数或需要删除字符的个数
%     ---EXT：新文件的扩展名
%     ---TYPE：指定是为文件内容各行添加序号还是删除文件各行前面的字符，
%              TYPE有以下两种取值：
%              1.1或'add'：为文件各行添加序号
%              2.2或'delete'：删除文件各行前面N个字符
% 输出参数：
%     ---S：新文件的内容
%
% See also importdata, fprintf

if nargin<4
    type='add';
end
if nargin<3
    extension='.txt';
end
if ~(isnumeric(n) && isscalar(n))
    error('n must be a scalar numeric.')
end
fid=fopen(file);
tline = fgetl(fid);
count=1;
while ischar(tline)
    S{count}=tline;
    tline = fgetl(fid);
    count=count+1;
end
fclose(fid);
N=length(S);
T=cell(1,N);
for k=1:N
    n=ceil(abs(n));
    L=S{k};
    if any(strcmpi(num2str(type),{'1','add'}))
        L=[sprintf(['%0',num2str(n),'d.',blanks(1)],k),L];
    elseif any(strcmpi(num2str(type),{'2','delete'}))
        if n>length(L)
            n=length(L);
        end
        L(1:n)=[];
    end
    T{k}=L;
end
str=char(T);
if nargout==0
    [~,name]=fileparts(file);
    fid=fopen([name,extension],'wt');
    format=[repmat('%c',1,size(str,2)),'\n'];
    fprintf(fid,format,str');
    fclose(fid);
elseif nargout==1
    varargout{1}=str;
else
    error('Illegal number of output arguments.')
end
web -broswer http://www.ilovematlab.cn/forum-221-1.html