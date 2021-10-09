function fpdfprinter(fignum, figvec, pre)
% fpdfprinter Produces nice pdf files of all the plots
coeff=1;
path='./';
titleornot=0; %reserve title(1) or not(0)
%=============
% nargin=0;
if nargin >3
    error('Too much inputs');
end

switch nargin
    case 1
        figvec=findobj('type','figure');
        pre='Print-';
    case 2
        figvec=lower(idde);
        if  (strcmp(idde,'all'))
            idde=findobj('type','figure');
        end
        pre='Print-';
    case 3
        figvec=lower(idde);
        if  (strcmp(idde,'all'))
            idde=findobj('type','figure');
        end
end

pre=char(pre);

%==saving
for i=1:length(figvec)
    set(figvec(i),'Name',num2str(i));
    if figvec(i)<10
%       figvecstr{i} = ['0' num2str(figvec(i))];
        figvecstr{i} = ['0' get(figvec(i),'Name')];
    else
%         figvecstr{i} = num2str(figvec(i));
        figvecstr{i} = get(figvec(i),'Name');
    end
    pdfname=[pre figvecstr{i} '.pdf'];
    epsname=[pre figvecstr{i} '.eps'];
    figure (figvec(i));
    if not(titleornot)
        title('');
    end
    %     %orient landscape;
    %===============================================
    print ('-depsc',[path epsname]);
    fid=fopen([path epsname]);
    temp=textscan(fid,'%s','delimiter','\n');
    fclose(fid);
    index=find(temp{1}{9}==':');
%   xy=textscan(temp{1}{9}(index+1:end),'%n %n %n %n');
%   x=xy{3}-xy{1};
%   y=xy{4}-xy{2};

    %更改图片大小
    set(gcf,'papersize',[15.4, 15.4]);
    set(gcf,'PaperPositionmode','auto')


    %===============================================
    print ('-dpdf',[path num2str(fignum)]);
    delete([path epsname]);
end
