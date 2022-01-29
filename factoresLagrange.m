%% ENTREGA 1: EJERCICIO 3

%% Cálculo de los factores de Lagrange
%% Entrada:
%%      x       =  vector de nodos ordenados de forma creciente
%% Salida:
%%      matriz  =  matriz cuyas filas son los factores de Lagrange

function matriz = factoresLagrange(x)
  n = length(x);
  for i=1:n
    aux = 1;
    for j=1:n
      if (j != i)
        pols(1) = 1/(x(i) - x(j));
        pols(2) = -x(j)/(x(i) - x(j));
        aux = conv(aux, pols); 
      endif
    endfor
    matriz(i,:) = aux;
  endfor
endfunction