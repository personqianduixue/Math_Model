function NewStr = replacezhiti(str)
if iscell(str)
    strlist = cell(1,length(str));
    for i = 1:length(str)
        str1 = char(str(i));
        newstr1 = replace_each(str1);
        strlist(1,i) = {newstr1};
    end
    NewStr = strlist;
else
    NewStr = replace_each(str);
end

end    
    
function NewString = replace_each(string)    
    [startIndex_CN, endIndex_CN] = regexp(string, '[\x4e00-\x9fa5]+');
    [startIndex_EN, endIndex_EN] = regexp(string, '[^\x4e00-\x9fa5]+');
    newstring2 = string;
    for i = 1:length(startIndex_CN)
        newstring = ['\fontname{宋体}',string(startIndex_CN(i):endIndex_CN(i))];
        newstring2 = strrep(newstring2,string(startIndex_CN(i):endIndex_CN(i)),newstring);
    end
    for i = 1:length(startIndex_EN)
        newstring = ['\fontname{Times New Roman}',string(startIndex_EN(i):endIndex_EN(i))];
        newstring2 = strrep(newstring2,string(startIndex_EN(i):endIndex_EN(i)),newstring);
    end
    NewString = newstring2;
end
