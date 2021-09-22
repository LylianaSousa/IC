clc;
clear;
close all;

%% chamando os dados da resistividade
data =  importdata('Pb_experimental_P-R');
%Coluna 1 corresponde a pressao
x = data(:,1);
%Coluna 2 corresponde a resistividade
y = data(:,2);

%% chamando os dados da razão da resistencia
data1 =  importdata('Pb_experimental_P-R:R0');
%Coluna 1 corresponde a pressao
x1 = data1(:,1);
%Coluna 2 corresponde a resistividade
y1 = data1(:,2);

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
T = 300; % em kelvin
P = 0:0.05:12; % em GPa

%Definindo a relacao do volume, que fica uma versão resumida, ja que
%estamos trabalhando a 300 K
vol_razao = (1 - (3*C*alfa*(300-T))).*((((P.*Blinha)./B) + 1).^((-1)/Blinha));

%% Resumo das relacoes que dependem do volume

K = K0.*((vol_razao).^beta);
gama = gama0.*((vol_razao).^delta);
theta = theta0.*((vol_razao).^(-gama));


%% Montando a relacao da resistividade com os parametros dados
A = (K*T)./(4.*(theta.^2));
B = (1/18).*((theta./T).^2);
C = (1/480).*((theta./T).^4);
resistividade_BG = A.*(1 - B + C);

%% Interpolando os dados experimentais da resistividade
interplot = interp1(x,y,P, 'spline');

%% Plotando a curva teorica da resistividade
figure;
plot(P, resistividade_BG,'g');
hold on;
%Plotando o grafico de dispersao dos dados experimentais
plot(x,y, '.');
hold on;
%Plotando a interpolação
plot(P,interplot,'r');
legend('Theoretical Resistivity','Experimental Data','Data Interpretation')
title('Lead resistivity for 300 K temperature')
xlabel('Pressure (GPa)')
ylabel('Resistivity (\mu\Omega*cm)')

%% Localizando pontos no gráfico teorico 
disp('Encontrando o valor da resistidade')
Rsugerido = input('Para qual resistividade em microOhms*cm: ');
Pdes= interp1(y,x,Rsugerido)

%% Interpolando os dados experimentais da resistividade
interplot1 = interp1(x1,y1,P, 'spline');

%% Plotando a curva teorica da razão da resistência
figure;
plot(P, resistividade_BG/21.11,'g');
hold on;
%Plotando o grafico de dispersao dos dados experimentais
plot(x1,y1, '.');
hold on;
%Plotando a interpolação
plot(P,interplot1,'r');
legend('Theoretical Resistivity','Experimental Data','Data Interpretation')
title('Lead resistance for 300 K temperature')
xlabel('Pressure (GPa)')
ylabel('R(P)/R(0)')
%% Localizando pontos no gráfico teorico 
disp('Encontrando o valor da resistidade')
Rsugerido1 = input('Para qual resistividade em microOhms*cm: ');
Pdes= interp1(y1,x1,Rsugerido1)