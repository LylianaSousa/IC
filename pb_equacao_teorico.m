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
[T,P] = meshgrid(5:0.1:300,0:0.004:12); % em kelvin e em GPa

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

%% Plotando a curva teorica
figure;
surf(P,T, resistividade_BG)
shading flat;
title('Resistividade do Chumbo em função da pressão para uma temperatura de 300 K')
xlabel('Pressão (GPa)')
ylabel('Temperatura (K)')
zlabel('Resistividade (microOhms*cm))')
 