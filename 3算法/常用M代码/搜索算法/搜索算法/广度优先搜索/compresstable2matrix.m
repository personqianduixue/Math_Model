function A=compresstable2matrix(b)
    [n ~]=size(b);
    m=max(b(:));
    A=zeros(m,m);

    for i=1:n
        A(b(i,1),b(i,2))=1;
        A(b(i,2),b(i,1))=1;
    end

end