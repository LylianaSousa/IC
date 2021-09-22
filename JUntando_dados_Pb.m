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

%% Armazenando dados
%Vou armazenar os dados em vetores
N = 1;
i = 1;
Pl = 0:0.004:12;
j = 5;

vetT = zeros( j,1 );
vetP = zeros( j,1 );
vetR = zeros( j,1 );
while N ~= 0
    vetT(i) = input('Para qual temperatura em Kelvin: ');
    vetR(i) = input('Para qual resistividade em \mu\Omega*cm: ');
    r = resistividade_BG(T == vetT(i));
    vetP(i) = interp1(r,Pl,vetR(i),'linear','extrap');
    N =  input('1 para continuar / 0 para sair ');
    i = i + 1;

end

%% Exibindo tabela
Matriz = [[vetT]'; [vetR]'; [vetP]'];
m = Matriz'