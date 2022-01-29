%% ENTREGA 1: EJERCICIO 2
%% Interpolación a trozos de Hermite
%% Entrada:
%%      x           =  vector de puntos (nudos) ordenados de forma creciente que usamos para interpolar directamente
%%      f           =  vector de las ordenadas.
%%      df          =  vector con los valores de la primera derivada en cada nudo 
%% Salida:
%%      matriz  =  matriz cuyas filas son los coeficientes de los polinomios

function matriz = hermiteTrozos(x, f, df)
  for i=1:(length(x)-1)
    nodos(1) = x(i);
    nodos(2) = x(i+1);
    celda{1} = [f(i), df(i)];
    celda{2} = [f(i+1), df(i+1)];
    [matriz(i,:),a]=interpolHermite(nodos, celda);
  endfor
endfunction