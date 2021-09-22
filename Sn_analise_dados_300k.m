clc;
clear;
close all;

%chamando os dados
data =  importdata('Sn_experimental_P-R');
%Coluna 1 corresponde a pressao
x = data(:,1);
%Coluna 2 corresponde a resistividade
y = data(:,2);

%Montando a estrutura da resistividade teorica

%Constantes
theta0 = 210; % em kelvin
gama0 = 2.1;
B = 55.81; % em GPa
Blinha = 0.27152; 
K0 = 7440; % em K^-1 cm ohm
beta = 0.78;
delta = 1.8;
alfa = 21.2*10^(-6); % em k^-1
C = 0.70;
ni = 7.0;
T = 300; % em kelvin
P = 0:0.05:12; % em GPa

%Definindo a relacao do volume, que fica uma versão resumida, ja que
%estamos trabalhando a 300 K
vol_razao = (1 - (3*C*alfa*(300-T))).*((((P.*Blinha)./B) + 1).^((-1)/Blinha));

%Resumo das relacoes que dependem do volume

K = K0.*((vol_razao).^beta);
gama = gama0.*((vol_razao).^delta);
theta = theta0.*((vol_razao).^(-gama));


%Montando a relacao da resistividade com os parametros dados
A = (K*T)./(4.*(theta.^2));
B = (1/18).*((theta./T).^2);
C = (1/480).*((theta./T).^4);
resistividade_BG = A.*(1 - B + C);
%Interpolando os dados experimentais para o novo plot
interplot = interp1(x,y,P, 'spline');
figure;
%Plotando a curva teorica
plot(P, resistividade_BG,'g');
hold on;

%Plotando o grafico de dispersao dos dados experimentais

plot(x,y, '.');
hold on;
%Plotando a interpolação
plot(P,interplot,'r');
legend('Resistividade teorica','Dados experimentais','Interpolacao dos dados')
title('Resistividade do Estanho em função da pressão para uma temperatura de 300 K')
xlabel('Pressão (GPa)')
ylabel('Resistividade (microOhms*cm))')