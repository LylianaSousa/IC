clc;
clear;
close all;

%chamando os dados
data =  importdata('Pb_teorico');
x = data(:,1);
y = data(:,2);
z = data(:,3);

%Fazendo o plot com interpolação

figure;
plot3(x,y,z, '.');
hold on;
[xx, yy] = meshgrid(0:0.1:15, 0:0.1:300);
zz = griddata(x, y, z, xx, yy);

surf(xx, yy, zz);
colormap gray;
shading flat;

grid on;
xlabel('Pressao (GPa)');
ylabel('Temperatura (K)');
zlabel('Ressistividade (microOhms*cm)');

%Localizando pontos no gráfico interpolado 
disp('Encontrando o valor da Pressão')
Tsugerido = input('Para qual temperatura em Kelvin: ');
Rsugerido = input('Para qual resistividade em microOhms*cm: ');

Pdes = interp2(x,y,z,Tsugerido,Rsugerido)
