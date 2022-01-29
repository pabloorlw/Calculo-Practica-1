%% ENTREGA 1: EJERCICIO 3

%% Cálculo de los coeficientes del polinomio en la forma de Lagrange
%% Entrada:
%%      x       =  vector de nodos ordenados de forma creciente
%%      f       =  vector que contiene las ordenadas de los nodos
%%      matriz  =  matriz con los factores de Langrange
%% Salida:
%%      coef    =  matriz cuyas filas son los coeficientes del polinomio de Lagrange

function coef = coefLagrange(x, f, matriz)
  coef = 0;
  n = length(x);
  if (length(f) != n)
    error('Las dimensiones de x y f no coinciden');
  end
  for i=1:n
    coef = coef + f(i).* matriz(i,:);
  endfor
endfunction
