options = optimset('GradObj','on','Hessian','on');
[x,y]=fminunc('fun4',rand(1,2),options)
