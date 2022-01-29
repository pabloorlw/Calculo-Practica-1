%% ENTREGA 1: EJERCICIO 2

%% Función para evaluar el polinomio de Hermite a trozos
%% Entrada:
%%        x            = vector que contiene los nudos donde interpolamos ordenados de forma creciente
%%        matriz       = matriz que contiene los coeficientes de los polinomios de Hermite
%%        t            = valor donde se evalua el polinomio, puede ser un valor o un vector de coordenadas.
%% Salida:
%%        valor  = evaluacion de los polinomios en t

%% Podemos obtener el número de intervalos a partir del tamaño de la matriz
function valor = eval_HermiteTrozos(x, matriz, t)
  n=length(x)-1;
  long_t=length(t);
  m = length(matriz(:,1));
for j=1:long_t
  if (t(j)<x(1) || t(j)>x(n+1)) valor(j)=0;
    break;
  endif
  for i=1:n
    if (t(j)<=x(i+1))
      %% Ahora creamos un vector x_i que contenga los nodos repetidos 2 veces
      x_i(1)=x(i);
      x_i(2)=x(i);
      x_i(3)=x(i+1);
      x_i(4)=x(i+1);
      valor(j)=polyinterpolador_eval(matriz(i,:), x_i, t(j));
      break;
    endif;
  endfor
endfor
endfunction