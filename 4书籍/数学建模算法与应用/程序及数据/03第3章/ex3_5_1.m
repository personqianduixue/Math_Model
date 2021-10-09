options = optimset('GradObj','on');
[x,y]=fminunc('fun3',rand(1,2),options)
