[x,y] = ndgrid(-5:0.8:5);
z = sin(x.^2 + y.^2) ./ (x.^2 + y.^2);
figure;
surf(x,y,z)
F = griddedInterpolant(x,y,z);
[xq,yq] = ndgrid(-5:0.1:5);
vq = F(xq,yq);
figure;
surf(xq,yq,vq)
x = -5:0.8:5;
y = x';
z = sin(x.^2 + y.^2) ./ (x.^2 + y.^2);
F = griddedInterpolant({x,y},z);
xq = -5:0.1:5;
yq = xq';
vq = F({xq,yq});
figure;
surf(xq,yq,vq)