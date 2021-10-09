function [W] = Huffman(A)
%求Huffman树
% arg:A表示已知的叶子顶点的权重向量
%     W表示Huffman树

k = 1;
Y = sort(A);
n = length(A);
B = Y(1) + Y(2);
W = [Y(1) Y(2) B];
m = 0;
while m == 0
    k = k + 1;
    B = [B Y(3:length(Y))];
    f = length(B);
    if f >= 2
        Y = sort(B);
        B = Y(1) + Y(2);
        W(k,:) = [Y(1) Y(2) B];
    else
        m = 1;
    end
end


end

