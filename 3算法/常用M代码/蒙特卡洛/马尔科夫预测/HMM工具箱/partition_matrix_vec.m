function [m1, m2, K11, K12, K21, K22] = partition_matrix_vec(m, K, n1, n2, bs)
% PARTITION_MATRIX_VEC Partition a vector and matrix into blocks.
% [m1, m2, K11, K12, K21, K22] = partition_matrix_vec(m, K, blocks1, blocks2, bs)
%
% bs(i) = block size of i'th node
%
% Example:
% n1 = [6 8], n2 = [5], bs = [- - - - 2 1 - 2], where - = don't care
% m = [0.1 0.2   0.3   0.4 0.5], K = some 5*5 matrix,
% So E[X5] = [0.1 0.2], E[X6] = [0.3], E[X8] = [0.4 0.5]
% m1 = [0.3 0.4 0.5], m2 = [0.1 0.2];

dom = myunion(n1, n2);
n1i = block(find_equiv_posns(n1, dom), bs(dom));
n2i = block(find_equiv_posns(n2, dom), bs(dom));
m1 = m(n1i);
m2 = m(n2i);
K11 = K(n1i, n1i);
K12 = K(n1i, n2i);
K21 = K(n2i, n1i);
K22 = K(n2i, n2i);  
