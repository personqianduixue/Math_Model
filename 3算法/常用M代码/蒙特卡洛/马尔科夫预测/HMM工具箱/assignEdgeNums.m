function [edge_id, nedges] = assignEdgeNums(adj_mat)
% give each edge a unique number
% we number (i,j) for j>i first, in row, column order.
% Then we number the reverse links

nnodes = length(adj_mat);
edge_id = zeros(nnodes);
e = 1;
for i=1:nnodes
  for j=i+1:nnodes
    if adj_mat(i,j)
      edge_id(i,j) = e;
      e = e+1;
    end
  end
end

nedges = e-1;
tmp = edge_id;
ndx = find(tmp);
tmp(ndx) = tmp(ndx)+nedges;
edge_id = edge_id + triu(tmp)';


if 0
ndx = find(adj_mat);
nedges = length(ndx);
nnodes = length(adj_mat);
edge_id = zeros(1, nnodes*nnodes);
edge_id(ndx) = 1:nedges; 
edge_id = reshape(edge_id, nnodes, nnodes);
end
