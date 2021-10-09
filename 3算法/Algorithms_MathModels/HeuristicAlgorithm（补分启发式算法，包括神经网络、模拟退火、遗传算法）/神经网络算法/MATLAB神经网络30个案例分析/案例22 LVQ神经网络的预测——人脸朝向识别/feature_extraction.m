% 特征提取子函数
function pixel_value=feature_extraction(m,n)
pixel_value=zeros(50,8);
sample_number=0;
for i=1:m
    for j=1:n
        str=strcat('Images\',num2str(i),'_',num2str(j),'.bmp'); 
        img= imread(str);  
        [rows cols]= size(img);
        img_edge=edge(img,'Sobel');
        sub_rows=floor(rows/6);
        sub_cols=floor(cols/8);
        sample_number=sample_number+1;
        for subblock_i=1:8   
            for ii=sub_rows+1:2*sub_rows
                for jj=(subblock_i-1)*sub_cols+1:subblock_i*sub_cols
                    pixel_value(sample_number,subblock_i)=...
                        pixel_value(sample_number,subblock_i)+img_edge(ii,jj);          
                end
            end     
        end  
     end
end