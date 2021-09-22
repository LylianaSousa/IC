function semana1(N)
t = 0:(0.99*pi/2):N;
x = t.*cos(t);
y = t.*sin(t);
plot(x,y,'k')
axis square 