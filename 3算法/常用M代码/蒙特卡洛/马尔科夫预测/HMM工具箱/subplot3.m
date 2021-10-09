function fignum = subplot3(nrows, ncols, fignumBase, plotnumBase)
% function subplot3(nrows, ncols, fignumBase, plotnumBase)
% Choose a subplot number, opening a new figure if necessary
% eg nrows=2, ncols = 2, we plot on (fignum, plotnum) = (1,1), (1,2), (1,3), (1,4), (2,1), ...

nplotsPerFig = nrows*ncols;
fignum = fignumBase + div(plotnumBase-1, nplotsPerFig);
plotnum = wrap(plotnumBase, nplotsPerFig);
figure(fignum);
if plotnum==1, clf; end
subplot(nrows, ncols, plotnum);


