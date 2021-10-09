function s = safeStr(s)
% Change punctuation characters to they print properly

s = strrep(s, '\', '/');
s = strrep(s, '_', '-');
