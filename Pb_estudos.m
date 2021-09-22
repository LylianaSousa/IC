clc;
clear;
close all;

%% Montando a estrutura da resistividade teorica

%Constantes
theta0 = 86; % em kelvin
gama0 = 2.629;
B = 43.7; % em GPa
Blinha = 0.44; 
K0 = 2091; % em K^-1 cm ohm
beta = 0.87;
delta = 1.2;
alfa = 28.9*10^(-6); % em k^-1
C = 0.55;
ni = 6.5;
resistividade0 = 21.11; % em microOhms cm
resistencia0 = 10; % em Omhs (é só uma suposição do valor)
[T,P] = meshgrid(45:0.1:300,0:0.004:12); % em kelvin e em GPa

%Definindo a relacao do volume, que fica uma versão resumida, ja que
%estamos trabalhando a 300 K
vol_razao = (1 - (((3*C*alfa).*(300 -T)))).*((((P.*Blinha)./B) + 1).^((-1)/Blinha));

%% Resumo das relacoes que dependem do volume

K = K0.*((vol_razao).^beta);
gama = gama0.*((vol_razao).^delta);
theta = theta0.*((vol_razao).^(-gama));

%% Montando a relacao da resistividade com os parametros dados
A = (K.*T)./(4.*(theta.^2));
B = (theta.^2)./(18.*(T.^2));
C = (1/480).*((theta./T).^4);
resistividade_BG = A.*(1 - B + C);

%% Plotando a curva teorica da resistencia
figure;
surf(P,T, resistividade_BG*(resistencia0/resistividade0))
shading flat;
title('Lead resistance ')
xlabel('Pressure (GPa)')
ylabel('Temperature (K)')
zlabel('Resistance (\Omega)')

%% Plotando a curva teorica da resistividade
figure;
surf(P,T, resistividade_BG)
shading flat;
title('Lead resistivity obtained by equation (5)')
xlabel('Pressure (GPa)')
ylabel('Temperature (K)')
zlabel('Resistivity (\mu\Omega*cm)')
%% Chamando os dados
data =  importdata('Pb_teorico');
z = data(:,1); % pressão em GPa
y = data(:,2); % temperatura em K
x = data(:,3); % resistividade me microhmscm

data1 =  importdata('Pb_experimental_P-T-R');
z1 = data1(:,1); % pressão em GPa
y1 = data1(:,2); % temperatura em K
x1 = data1(:,3); % resistividade me microhmscm

data2 =  importdata('Pb_experimental_P-R');
z2 = data2(:,1); % pressão em GPa
x2 = data2(:,2); % resistividade me microhmscm

%% Fazendo o plot com os pontos teoricos e a interpolação da resistividade
%lembrando que os dados estão considerando a temperatura até 300k
figure;
plot3(z1,y1,x1, 'b.');


hold on;
[zz, yy] = meshgrid(0:0.1:15, 0:0.1:300);
xx = griddata(z1, y1,x1, zz, yy);

h = surf(zz, yy, xx);
colormap gray;
shading flat;

grid on;
title('Lead resistivity obtained by data interpolation')
xlabel('Pressure (GPa)');
ylabel('Temperature (K)');
zlabel('Resistivity (\mu\Omega*cm)');

%% Fazendo o plot com os pontos teoricos e a interpolação da resistencia
%lembrando que os dados estão considerando a temperatura até 300k
figure;
plot3(z1,y1,x1*(resistencia0/resistividade0), 'b.');


hold on;
[zz, yy] = meshgrid(0:0.1:15, 0:0.1:300);
xx = griddata(z1, y1,x1*(resistencia0/resistividade0), zz, yy);

h = surf(zz, yy, xx);
colormap gray;
shading flat;

grid on;
title('Lead resistance obtained by data interpolation')
xlabel('Pressure (GPa)');
ylabel('Temperature (K)');
zlabel('Resistance (\Omega)');

%% Localizando pontos no gráfico interpolado teorico
%Falta colocar a relação para resistencia
disp('Encontrando o valor da Pressão')
Tsugerido = input('Para qual temperatura em Kelvin: ');
Rsugerido = input('Para qual resistividade em \mu\Omega*cm: ');
Pl = 0:0.004:12;
r = resistividade_BG(T == Tsugerido);
Pressure = interp1(r,Pl,Rsugerido,'linear','extrap');
fprintf('Para a temperatura %d K e a resistividade %d micro-Ohms*cm, a pressão teorica é %d GPa \n',Tsugerido,Rsugerido,Pressure)

%% Plot da relação da resistividade teorica
figure;
plot(Pl, r,'g');
hold on;
% Plot da relação da resistividade experimental
x11 = 0:0.01:10; %estendendo a pressão
y11 = interp1(z2,x2,x11,'linear','extrap');
Pressure1 = interp1(x2,z2,Rsugerido,'linear','extrap');
fprintf('Para a temperatura %d K e a resistividade %d micro-Ohms*cm, a pressão experimental é %d GPa \n',Tsugerido,Rsugerido,Pressure1)

plot(x11,y11,'.');
hold on;
% Plot do ponto teorico 
x_ponto = [Pressure, Pressure1];
y_ponto = [Rsugerido, Rsugerido];
plot (x_ponto,y_ponto,'ks');
legend('Theoretical Resistivity','Data interpolation','Chosen Data');
title("Lead resistivity for a temperature of " + Tsugerido +" K ");
xlabel('Pressure (GPa)');
ylabel('Resistivity (\mu\Omega*cm)');



