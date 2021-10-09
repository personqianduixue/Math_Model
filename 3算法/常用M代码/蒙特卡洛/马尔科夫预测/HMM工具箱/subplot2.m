function subplot2(nrows, ncols, i, j)
% function subplot2(nrows, ncols, i, j)


sz = [nrows ncols];
%k = sub2ind(sz, i, j)
k = sub2ind(sz(end:-1:1), j, i);
subplot(nrows, ncols, k);

if 0
  ncols_plot = ceil(sqrt(Nplots));
  nrows_plot = ceil(Nplots/ncols_plot);
  Nplots = nrows_plot*ncols_plot;
  for p=1:Nplots
    subplot(nrows_plot, ncols_plot, p);
  end
end
