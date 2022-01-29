%% ENTREGA 1: EJERCICIO 3

%% NOTA:
%% Se ha observado mientras se representaba graficamente la diferencia entre los polinomios
%% que, si cada resultado de una funcion se asigna a una variable y luego se pasa esa variable 
%% como parametro a otra funcion, la diferencia entre ambos polinomios es distinta respecto a 
%% como sale si se hace pasandole directamente a una funcion el resultado de otra funcion sin
%% guardarla en ninguna variable "intermedia". Por ejemplo, hacer 
%% polyinterpolador(interpolNewton(x_3, y_3), x_3);
%% en vez de 
%% coefs = interpolNewton(x_3, y_3); 
%% polyinterpolador(coefs, x_3);
%% En el caso concreto de 3 nodos equiespaciados si se hace de la primera manera (como esta hecho en el codigo)
%% la diferencia de los polinomios sale una recta y si se hace de la segunda forma sale una funcion
%% que no es una recta.
%% Creo que tiene que ver con como almacena, aproxima y trabaja Octave con las variables de muy pequeño tamaño 
%% ya que como se puede observar en los coeficientes mostrados en la terminal, hablamos de coeficientes 
%% tan pequeños como 10^-32 en el caso de 3 nodos equiespaciados.

clc;
clear all;
addpath("./Biblioteca");

f=@(x) sin(x);
x_3 = linspace(0, 2*pi, 3);       %% vector con 3 nodos equiespaciados entre 0 y 2*pi
x_5 = linspace(0, 2*pi, 5);       %% vector con 5 nodos equiespaciados entre 0 y 2*pi
x_15 = linspace(0, 2*pi, 15);     %% vector con 15 nodos equiespaciados entre 0 y 2*pi
y_3 = f(x_3);                     %% vector con las ordenadas de x_3
y_5 = f(x_5);                     %% vector con las ordenadas de x_15
y_15 = f(x_15);                   %% vector con las ordenadas de x_15

%% Apartado 3 
valores = linspace(0, 2*pi, 200);
newtonEstandar_x_3 = polyinterpolador(interpolNewton(x_3, y_3), x_3);
coefLagrange_3 = coefLagrange(x_3, y_3, factoresLagrange(x_3));
dif_3 = newtonEstandar_x_3 - coefLagrange_3;
figure(1);
plot(valores, polyval(dif_3, valores));
title('Diferencia entre polinomio de Lagrange y de Newton con 3 nodos de interpolación');
hold off;
%% Mostramos por consola el vector diferencia de los coeficientes
display(dif_3);

newtonEstandar_x_5 = polyinterpolador(interpolNewton(x_5, y_5), x_5);
coefLagrange_5 = coefLagrange(x_5, y_5, factoresLagrange(x_5));
dif_5 = newtonEstandar_x_5 - coefLagrange_5;
figure(2);
plot(valores, polyval(dif_5, valores));
title('Diferencia entre polinomio de Lagrange y de Newton con 5 nodos de interpolación');
hold off;
%% Mostramos por consola el vector diferencia de los coeficientes
display(dif_5);

newtonEstandar_x_15 = polyinterpolador(interpolNewton(x_15, y_15), x_15);
coefLagrange_15 = coefLagrange(x_15, y_15, factoresLagrange(x_15));
dif_15 = newtonEstandar_x_15 - coefLagrange_15;
figure(3);
plot(valores, polyval(dif_15, valores));
title('Diferencia entre polinomio de Lagrange y de Newton con 15 nodos de interpolación');
hold off;
%% Mostramos por consola el vector diferencia de los coeficientes
display(dif_15);


%% Apartado 4
figure(4);
x_40 = linspace(0, 2*pi, 40);      %% vector con 40 nodos equiespaciados entre 0 y 2*pi
x_50 = linspace(0, 2*pi, 50);      %% vector con 50 nodos equiespaciados entre 0 y 2*pi
y_40 = f(x_40);                    %% vector con las ordenadas de x_40
y_50 = f(x_50);                    %% vector con las ordenadas de x_50
coefLagrange_40 = coefLagrange(x_40, y_40, factoresLagrange(x_40));
newtonEstandar_x_40 = polyinterpolador(interpolNewton(x_40, y_40), x_40);
dif_40 = newtonEstandar_x_40 - coefLagrange_40;
coefLagrange_50 = coefLagrange(x_50, y_50, factoresLagrange(x_50));
newtonEstandar_x_50 = polyinterpolador(interpolNewton(x_50, y_50), x_50);
dif_50 = newtonEstandar_x_50 - coefLagrange_50;

figure(4);
plot(valores, polyval(dif_40, valores));
title('Diferencia entre polinomio de Lagrange y de Newton con 40 nodos de interpolación');
hold off;
%% Mostramos por consola el vector diferencia de los coeficientes
display(dif_40);
figure(5);
plot(valores, polyval(dif_50, valores));
title('Diferencia entre polinomio de Lagrange y de Newton con 50 nodos de interpolación');
hold off;
%% Mostramos por consola el vector diferencia de los coeficientes
display(dif_50);

rmpath("./Biblioteca");

%% La diferencia entre ambos polinomios ahora es, en ambos casos, mucho mayor que antes.
%% Tal y como se puede ver por la salida en el terminal, obviamente, ahora la diferencia 
%% entre los polinomios es mayor. El problema probablemente venga de hacer operaciones con 
%% números relativamente pequeños que a su vez se restan y multiplican con números más 
%% pequeños, lo cual provoca errores de aproximación. 
