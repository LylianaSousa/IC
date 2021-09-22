%% Comandos basicos
a = 5 + 7;
b = 5 - 7; 
c = 2 / 3; % divisão normal
d = 2 \ 3; % divisão invertida é tipo 3/2
e = 2 ^ 3;
fprintf('a = %d, b = %d, c = %d, d = %d, e = %d \n',a,b,c,d,e)
%% Funções
disp('\n Funçoes \n')
x = 3.14; % as funções trigonometricas devem receber o argumento em radianos
a = sin(x);
b = cos(x);
c = tan(x);
d = asin(x);
e = acos(x);
f = atan(x);
g = log(x);
h = exp(x);
i = abs(x);
fprintf('a = %d, b = %d, c = %d, d = %d, e = %d,\n f = %d, g = %d, h = %d, i = %d \n',a,b,c,d,e,f,g,h,i)
%% Matrizes
%Basicamente cada elemento antes dos ; são os termos das colunas e o ;  é a
%separção das linhas
a = [1,2;3,4]; % matriz dois por dois
b = [1,2;3,4;5,6]; %matriz dois por três
c = a(1,1);
fprintf('Um elemento da coluna %d',c)
%Comandos pra manipuar matrizes
a(:,1); %  todas as linhas da coluna 1
a(1,:); %todas as colunas da linha 1
b([1 3 2],:); %todas as colunas das linhas 1 e 3
%Operações com matrizes: As operações de adição, subtração, multiplicação e divisão (+ - * / ) seguem as regras de operações matriciais, enquanto que o operador ponto antecedendo as operações de multiplicação e divisão, faz com que a mesma seja realizada elemento a elemento
d = [5,6;7,8];
e = a * d;
f = a .* d;
Auto = eig(a); % auto valores/vetores da matriz A
Norma = norm(a); % norma da matriz A
Determinante = det(a); % determinante da matriz A
Inversa = inv(a); % inversa de A
Tamanho = size(b); % vetor com o tamanho da matriz, [linhas colunas]
%% Strings
s = 'Este texto é uma string';
s(5:10); % nos dá uma palavra de um carscter incial a um final
fprintf(s); % printando a string
%% Gráfico 2D
x = [1:10];
y = x;
figure;
plot(x,y,'xg');
figure;
plot(x,x,'r',x,2*x,'--b'); 
figure;
ezplot('cos(x)', [0,pi]);
title('Função co-seno');
xlabel('X'); 
ylabel('Y');
hold on; 
ezplot('sin(x)', [0,pi]); 
legend('cos(x)','sin(x)')
hold off;
subplot(1,2,1);plot(1:10,'*b');
subplot(1,2,2);plot(1:10,'--m');
%% Gráfico 3D
x = 1:10;
y = x;
[X,Y] = meshgrid (x,y);
Z = X.^2 + Y.^2;
mesh(Z);
%% Gráficos especiais
x=[1:10];
y1 = [1.5*x];
y2 = [x];
figure;
bar(x,y1);
hold on;
bar(x,y2);
hold off;
figure;
area(x,y1);
hold on;
area(x,y2);
hold off;
figure;
pie(x);
figure;
scatter(x,y1);
%% Laço FOR
for i = 1:4;
    A(i,1) = i;
    A(i,2) = i^2;
end
A