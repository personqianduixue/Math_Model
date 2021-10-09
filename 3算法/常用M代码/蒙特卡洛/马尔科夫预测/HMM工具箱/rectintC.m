function [overlap, normoverlap] = rectintC(A,B)
%
% A(i,:) = [x y w h]
% B(j,:) = [x y w h]
% overlap(i,j) = area of intersection
% normoverlap(i,j) = overlap(i,j) / min(area(i), area(j))
%
% Same as built-in rectint, but faster and uses less memory (since avoids repmat).


leftA = A(:,1);
bottomA = A(:,2);
rightA = leftA + A(:,3);
topA = bottomA + A(:,4);

leftB = B(:,1)';
bottomB = B(:,2)';
rightB = leftB + B(:,3)';
topB = bottomB + B(:,4)';

verbose = 0;
[overlap, normoverlap] = rectintLoopC(leftA, rightA, topA, bottomA, leftB, rightB, topB, bottomB, verbose);
