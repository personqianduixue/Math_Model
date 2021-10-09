function sub = block(blocks, block_sizes)
% BLOCK Return a vector of subscripts corresponding to the specified blocks.
% sub = block(blocks, block_sizes)
% 
% e.g., block([2 5], [2 1 2 1 2]) = [3 7 8].

blocks = blocks(:)';
block_sizes = block_sizes(:)';
skip = [0 cumsum(block_sizes)];
start = skip(blocks)+1;
fin = start + block_sizes(blocks) - 1;
sub = [];
for j=1:length(blocks)
  sub = [sub start(j):fin(j)];
end
