%% ENTREGA 1: EJERCICIO 1
clc;
clear all;
addpath("./Biblioteca");

%% Apartado 3
%% La grafica de estos polinomios y sus funciones originales se hacen en el apartado 4

%% a)
f=@(x) sin(x);
m = 15;                 %% Numero de subintervalos. Se puede cambiar para probar con el resto de ejemplos.
d = 4;                  %% Grado de un polinomio (d+1 nodos en cada subintervalo). Se puede cambiar para probar con el resto de ejemplos.
x = linspace(0, pi, m*d+1);
y = f(x);

matriz = lagrangeTrozos(x, y, m, d);
v=[pi/4, pi/2];
resultado_trozos = eval_LagrangeTrozos(x, matriz, v);
printf("f(x) = sin(x)\n\n");
display(v);
printf("Con interpolación a trozos de Lagrange: m=%d, d=%d\n", m, d);
display(resultado_trozos);
printf("\n");
%% Ahora con el polinomio interpolador de Newton
printf("Con el polinomio interpolador de Newton:\n");
resultado_newton = polyinterpolador_eval(interpolNewton(x, y), x, v);
display(resultado_newton);
printf("----------------------------------------------------------\n");
printf("\n");

%% b)
g=@(x) 1./(1+x.^2);
x1 = linspace(-5, 5, m*d+1);      %% vector de nodos de 1/(1+x^2)
y1 = g(x1);                       %% vector de ordendas de los nodos de 1/(1+x^2)

matriz1 = lagrangeTrozos(x1, y1, m, d);
v1=[-4.7, -1, 0, 1, 4.7];
%% Mostramos el resultado de la interpolacion a trozos en un vector 
resultado_trozos1 = eval_LagrangeTrozos(x1, matriz1, v1);
printf("g(x) = 1/(1+x^2)\n\n");
display(v1);
printf("Con interpolación a trozos de Lagrange: m=%d, d=%d\n", m, d);
display(resultado_trozos1);
printf("\n");
%% Ahora con el polinomio interpolador de Newton
printf("Con el polinomio interpolador de Newton:\n");
nodosNewton = linspace(-5, 5, m);
ordenadasNewton = g(nodosNewton);
coefRungeNewton = interpolNewton(nodosNewton, ordenadasNewton);
resultado_newton1 = polyinterpolador_eval(coefRungeNewton, ordenadasNewton, v1);
display(resultado_newton1); 
printf("----------------------------------------------------------\n");
printf("\n");  

%% c)
h=@(x) x.^(5/2);
temp = linspace(0,1, m*d+1);
x2 = temp.^2;      %% Para que haya nodos mas cercanos de 0 que de 1 simplemente elevamos al cuadrado todos los nodos
y2 = h(x2);

matriz2 = lagrangeTrozos(x2, y2, m, d);
v2=[0, 0.05, 0.1, 0.2, 0.3, 0.4, 0.5, 1];
%% Mostramos el resultado de la interpolacion a trozos en un vector 
resultado_trozos2 = eval_LagrangeTrozos(x2, matriz2, v2);
printf("h(x) = x^(5/2)\n\n");
display(v2);
printf("Con interpolación a trozos de Lagrange: m=%d, d=%d\n", m, d);
display(resultado_trozos2);
printf("\n");
%% Ahora con el polinomio interpolador de Newton
printf("Con el polinomio interpolador de Newton:\n");
nodosNewton1 = linspace(0, 1, m);
nodosNewton1 = nodosNewton1.^2;
ordenadasNewton1 = h(nodosNewton1);
coefh = interpolNewton(nodosNewton1, ordenadasNewton1);
resultado_newton2 = polyinterpolador_eval(coefh, nodosNewton1, v2);
display(resultado_newton2);


%% Apartado 4
%% Grafica del seno
valores1=linspace(0, pi, 200);
ordenadas_senTrozos = eval_LagrangeTrozos(x, matriz, valores1);
figure(1);
plot(valores1, ordenadas_senTrozos, 'r--;sin(x) a trozos;');
hold on;
plot(valores1, f(valores1), 'y--;sin(x);');
hold on;
nodosNewton2 = linspace(0, pi, m);
nodosNewton2 = nodosNewton2.^2;
ordenadasNewton2 = f(nodosNewton2);
ordenadas_senNewton = polyinterpolador_eval(interpolNewton(nodosNewton2, ordenadasNewton2), nodosNewton2, valores1);
plot(valores1, ordenadas_senNewton, ';sin(x) newton;');
title('Comparación entre sin(x), su polinomio a trozos y su polinomio de Newton');
hold off;

%% Grafica de Runge
valores = linspace(-5, 5, 200);
figure(2); 
plot(valores, eval_LagrangeTrozos(x1, matriz1, valores), ';polinomio a trozos;');
hold on;
plot(valores, polyinterpolador_eval(coefRungeNewton, nodosNewton, valores), 'r--;polinomio;');
hold on;
plot(valores, g(valores), 'y--;1/(1+x^2);');
title('Comparación entre 1/(1+x^2), su polinomio a trozos y su polinomio de Newton');
hold off;

%% Grafica de x^5/2
valores2 = linspace(0, 1, 200);
figure(3); 
plot(valores2, eval_LagrangeTrozos(x2, matriz2, valores2), ';polinomio a trozos;');
hold on;
plot(valores2, polyinterpolador_eval(coefh, nodosNewton1, valores2), 'r--;polinomio;');
hold on;
plot(valores2, h(valores2), 'y--;x^5/2;');
title('Comparación entre x^5/2, su polinomio a trozos y su polinomio de Newton');
hold off; 

%% Ahora vamos a representar la diferencia entre el polinomio interpolador y el interpolador a trozos del seno
figure(4);
plot(valores1, abs(ordenadas_senNewton - ordenadas_senTrozos), ';|p_t(x) - p_n(x)|;');
title('Diferencia entre el polinomio a trozos y el polinomio de Newton de sin(x)');
hold off;

%% Apartado 5
figure(5);
j=1;
k=d+1;
for i=1:m
  coef(i,:) = polyinterpolador(matriz1(i,:), x1(j:k));
  der(i,:) = polyder(coef(i,:));
  j = k;
  k = k + d;
endfor
j=1;
k=d+1;
for i=1:m
  subintervalo = linspace(x1(j), x1(k), 200);
  plot(subintervalo, polyval(der(i,:), subintervalo));
  hold on;
  j = k;
  k = k+d;
endfor
title('Derivada polinomio interpolador a trozos de 1/(1+x^2)');
hold off;

rmpath("./Biblioteca");