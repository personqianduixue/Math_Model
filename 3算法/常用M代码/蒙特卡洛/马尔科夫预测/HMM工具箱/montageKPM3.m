function montageKPM3(data)
% data{f}(y,x,b) - each frame can have a different size (can can even be empty)

Nframes = length(data);
Nbands = -inf;
nr = -inf; nc = -inf;
for f=1:Nframes
  if isempty(data{f}), continue; end
  nr = max(nr, size(data{f},1));
  nc = max(nc, size(data{f},2));
  Nbands = max(Nbands, size(data{f},3));
end    
data2 = zeros(nr, nc, Nbands, Nframes);
for f=1:Nframes
  if isempty(data{f}), continue; end
  data2(1:size(data{f},1), 1:size(data{f},2), :, f) = data{f};
end

montageKPM2(data2)
