%% ENTREGA 1: EJERCICIO 2
clc;
clear all;
addpath("./Biblioteca");


%% Apartado 3
g=@(x) 1./(1+x.^2);

m = 20;                             %% número de nodos

x = linspace(-5, 5, m);
y = g(x);
dg=@(x) -2.*x./((x.^2+1).*(x.^2+1));
derivada = dg(x);

matrizHermite = hermiteTrozos(x, y, derivada);
v=[-4.9, -4.8, -4.7, -1, -0.5, 0, 0.5, 1, 4.7, 4.8, 4.9];
%% Mostramos el resultado de la interpolación a trozos en un vector 
resultado_trozos = eval_HermiteTrozos(x, matrizHermite, v);  
printf("g(x) = 1/(1+x^2)\n\n");
display(v);
printf("Con el polinomio de Hermite a trozos: nº nodoss=%d\n", m);
display(resultado_trozos);
printf("\n");


%% Ahora con el polinomio interpolador de Hermite
printf("Con el polinomio interpolador de Hermite:\n");
for i=1:length(x)
  celda{i}=[y(i), derivada(i)]; 
endfor
[coef_hermite, nodos_repetidos] = interpolHermite(x, celda);
resultado_hermite = polyinterpolador_eval(coef_hermite, nodos_repetidos, v);
display(resultado_hermite);

%% Apartado 3
%% Vamos a representar gráficamente los polinomios a trozos, la función y el error
figure(1);
valores=linspace(-5, 5, 200);
plot(valores, g(valores), ';g(x);');
hold on;
plot(valores, eval_HermiteTrozos(x, matrizHermite, valores), 'r--;p_t(x);');
title('Comparación función original y polinomio de Hermite a trozos');
hold off;
figure(2);
error = abs(g(valores) - eval_HermiteTrozos(x, matrizHermite, valores));
plot(valores, error,';|g(x) - p_t(x)|;');
title('Diferencia entre función original y polinomio a trozos');
hold off;

%% Apartado 4 
[b,c,d] = splineSujeto(x, g(x), derivada(1), derivada(length(derivada)));
eval_spline = splineEval(x, g(x), b, c, d, v);
printf("\nDiferencia en v entre el polinomio interpolador a trozos y el spline\n");
display(abs(eval_spline - resultado_trozos));

ordenadasTrozos = eval_HermiteTrozos(x, matrizHermite, valores);
ordenadasSpline = splineEval(x, g(x), b, c, d, valores);
figure(3);
plot(valores, ordenadasTrozos, ';p_t(x);');
hold on;
plot(valores, ordenadasSpline, 'r--;S(x);');
title('Comparación gráfica entre spline y polinomio de Hermite a trozos');
hold off;

error = abs(ordenadasSpline - ordenadasTrozos);
figure(4);
plot(valores, error, ';|S(x) - p_t(x)|;');
title('Diferencia entre spline y polinomio a trozos');
hold off

%%Apartado 5 

%% Primero creamos un vector de nodos repetidos (que ya sabemos de antemano cuáles son)
for i=1:(length(x)-1)
  nodos_rep(1) = x(i);
  nodos_rep(2) = x(i);
  nodos_rep(3) = x(i+1);
  nodos_rep(4) = x(i+1);
  coefEstandar = polyinterpolador(matrizHermite(i,:), nodos_rep);
  segundaDer(i,:) = polyder(polyder(coefEstandar));
endfor

figure(5);
for i=1:(length(x)-1)
  subintervalo = linspace(x(i), x(i+1), 30);
  ordenadasSegDer = polyval(segundaDer(i,:), subintervalo);  
  plot(subintervalo, ordenadasSegDer);
  hold on;
endfor
title('Gráfica de la segunda derivada del polinomio interpolador a trozos');
hold off;

rmpath("./Biblioteca");