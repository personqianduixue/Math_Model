function result = logsum(logv)

len = length(logv);
if (len<2);
  error('Subroutine logsum cannot sum less than 2 terms.');
end;

% First two terms
if (logv(2)<logv(1)),
  result = logv(1) + log( 1 + exp( logv(2)-logv(1) ) );
else,
  result = logv(2) + log( 1 + exp( logv(1)-logv(2) ) );
end;

% Remaining terms
for (i=3:len),
  term = logv(i);
  if (result<term),
    result = term   + log( 1 + exp( result-term ) );
  else,
    result = result + log( 1 + exp( term-result ) );
  end;    
end
