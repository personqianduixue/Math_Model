function [errorcode, rows, columns] = rndcheck(nargs,nparms,arg1,arg2,arg3,arg4,arg5)
%RNDCHECK error checks the argument list for the random number generators.

%   B.A. Jones  1-22-93
%   Copyright (c) 1993-98 by The MathWorks, Inc.
%   $Revision: 1.1 $  $Date: 2005/04/26 02:29:21 $

sizeinfo = nargs - nparms;
errorcode = 0;

if nparms == 3
    [r1 c1] = size(arg1);
    [r2 c2] = size(arg2);
    [r3 c3] = size(arg3);
end

if nparms == 2
    [r1 c1] = size(arg1);
    [r2 c2] = size(arg2);
end 

if sizeinfo == 0        
    if nparms == 1
        [rows columns] = size(arg1);
    end
    
    if nparms == 2
        scalararg1 = (prod(size(arg1)) == 1);
        scalararg2 = (prod(size(arg2)) == 1);
        if ~scalararg1 & ~scalararg2
            if r1 ~= r2 | c1 ~= c2
                errorcode = 1;
                return;         
            end
        end
        if ~scalararg1
            [rows columns] = size(arg1);
        elseif ~scalararg2
            [rows columns] = size(arg2);
        else
            [rows columns] = size(arg1);
        end
    end
    
    if nparms == 3
        scalararg1 = (prod(size(arg1)) == 1);
        scalararg2 = (prod(size(arg2)) == 1);
        scalararg3 = (prod(size(arg3)) == 1);

        if ~scalararg1 & ~scalararg2
            if r1 ~= r2 | c1 ~= c2
                errorcode = 1;
                return;         
            end
        end

        if ~scalararg1 & ~scalararg3
            if r1 ~= r3 | c1 ~= c3
                errorcode = 1;
                return;                 
            end
        end

        if ~scalararg3 & ~scalararg2
            if r3 ~= r2 | c3 ~= c2
                errorcode = 1;
                return;         
            end
        end
            if ~scalararg1
                [rows columns] = size(arg1);
            elseif ~scalararg2
            [rows columns] = size(arg2);
            else
                [rows columns] = size(arg3);
            end
    end 
end

if sizeinfo == 1
    scalararg1 = (prod(size(arg1)) == 1);
    if nparms == 1
        if prod(size(arg2)) ~= 2
            errorcode = 2;
            return;
        end
        if  ~scalararg1 & arg2 ~= size(arg1)
            errorcode = 3;
            return;
        end
        if (arg2(1) < 0 | arg2(2) < 0 | arg2(1) ~= round(arg2(1)) | arg2(2) ~= round(arg2(2))),
            errorcode = 4;
            return;
        end 
        rows    = arg2(1);
        columns = arg2(2);
    end
    
    if nparms == 2
        if prod(size(arg3)) ~= 2
            errorcode = 2;
            return;
        end
        scalararg2 = (prod(size(arg2)) == 1);
        if ~scalararg1 & ~scalararg2
            if r1 ~= r2 | c1 ~= c2
                errorcode = 1;
                return;         
            end
        end
        if (arg3(1) < 0 | arg3(2) < 0 | arg3(1) ~= round(arg3(1)) | arg3(2) ~= round(arg3(2))),
            errorcode = 4;
            return;
        end 
        if ~scalararg1
            if any(arg3 ~= size(arg1))
                errorcode = 3;
                return;
            end
            [rows columns] = size(arg1);
        elseif ~scalararg2
            if any(arg3 ~= size(arg2))
                errorcode = 3;
                return;
            end
            [rows columns] = size(arg2);
        else
            rows    = arg3(1);
            columns = arg3(2);
        end
    end
    
    if nparms == 3
        if prod(size(arg4)) ~= 2
            errorcode = 2;
            return;
        end
        scalararg1 = (prod(size(arg1)) == 1);
        scalararg2 = (prod(size(arg2)) == 1);
        scalararg3 = (prod(size(arg3)) == 1);

        if (arg4(1) < 0 | arg4(2) < 0 | arg4(1) ~= round(arg4(1)) | arg4(2) ~= round(arg4(2))),
            errorcode = 4;
            return;
        end 

        if ~scalararg1 & ~scalararg2
            if r1 ~= r2 | c1 ~= c2
                errorcode = 1;
                return;         
            end
        end

        if ~scalararg1 & ~scalararg3
            if r1 ~= r3 | c1 ~= c3
                errorcode = 1;
                return;                 
            end
        end

        if ~scalararg3 & ~scalararg2
            if r3 ~= r2 | c3 ~= c2
                errorcode = 1;
                return;         
            end
        end
        if ~scalararg1
            if any(arg4 ~= size(arg1))
                errorcode = 3;
                return;
            end
            [rows columns] = size(arg1);
        elseif ~scalararg2
            if any(arg4 ~= size(arg2))
                errorcode = 3;
                return;
            end
            [rows columns] = size(arg2);
        elseif ~scalararg3
            if any(arg4 ~= size(arg3))
                errorcode = 3;
                return;
            end
            [rows columns] = size(arg3);
        else
            rows    = arg4(1);
            columns = arg4(2);
        end
    end 
end

if sizeinfo == 2
    if nparms == 1
        scalararg1 = (prod(size(arg1)) == 1);
        if ~scalararg1
            [rows columns] = size(arg1);
            if rows ~= arg2 | columns ~= arg3 
                errorcode = 3;
                return;
            end
        end
    if (arg2 < 0 | arg3 < 0 | arg2 ~= round(arg2) | arg3 ~= round(arg3)),
        errorcode = 4;
        return;
    end 
        rows = arg2;
        columns = arg3;
    end
    
    if nparms == 2
        scalararg1 = (prod(size(arg1)) == 1);
        scalararg2 = (prod(size(arg2)) == 1);
        if ~scalararg1 & ~scalararg2
            if r1 ~= r2 | c1 ~= c2
                errorcode = 1;
                return;         
            end
        end
        if ~scalararg1
            [rows columns] = size(arg1);
            if rows ~= arg3 | columns ~= arg4 
                errorcode = 3;
                return;
            end     
        elseif ~scalararg2
            [rows columns] = size(arg2);
            if rows ~= arg3 | columns ~= arg4 
                errorcode = 3;
                return;
            end     
        else
            if (arg3 < 0 | arg4 < 0 | arg3 ~= round(arg3) | arg4 ~= round(arg4)),
                errorcode = 4;
                return;
            end 
            rows = arg3;
            columns = arg4;
        end
    end
    
    if nparms == 3
        scalararg1 = (prod(size(arg1)) == 1);
        scalararg2 = (prod(size(arg2)) == 1);
        scalararg3 = (prod(size(arg3)) == 1);

        if ~scalararg1 & ~scalararg2
            if r1 ~= r2 | c1 ~= c2
                errorcode = 1;
                return;         
            end
        end

        if ~scalararg1 & ~scalararg3
            if r1 ~= r3 | c1 ~= c3
                errorcode = 1;
                return;                 
            end
        end

        if ~scalararg3 & ~scalararg2
            if r3 ~= r2 | c3 ~= c2
                errorcode = 1;
                return;         
            end
        end
        
        if ~scalararg1
            [rows columns] = size(arg1);
            if rows ~= arg4 | columns ~= arg5 
                errorcode = 3;
                return;
            end     
        elseif ~scalararg2
            [rows columns] = size(arg2);
            if rows ~= arg4 | columns ~= arg5 
                errorcode = 3;
                return;
            end
        elseif ~scalararg3
            [rows columns] = size(arg3);
            if rows ~= arg4 | columns ~= arg5 
                errorcode = 3;
                return;
            end     
        else
            if (arg4 < 0 | arg5 < 0 | arg4 ~= round(arg4) | arg5 ~= round(arg5)),
                errorcode = 4;
                return;
            end 
            rows    = arg4;
            columns = arg5;
        end
    end 
end
