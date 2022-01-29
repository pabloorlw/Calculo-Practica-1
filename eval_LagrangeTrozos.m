%% ENTREGA 1: EJERCICIO 1

%% Funcion para evaluar el polinomio de Lagrange o Hermite a trozos
%% Entrada:
%%        matriz    = matriz que contiene los coeficientes de los polinomios de Lagrange
%%        x         = vector que contiene las abscisas de los puntos a interpolar (nodos) ordenados de forma creciente.
%%        t         = valor donde se evalua el polinomio, puede ser un valor o un vector de coordenadas.
%% Salida:
%%        valor  = evaluacion de los polinomios en t

%% Podemos obtener los valores de m y d a partir del tamaño de la matriz
function valor = eval_LagrangeTrozos(x, matriz, t)
  n=length(x)-1;
  long_t=length(t);
  m = length(matriz(:,1));
  d = length(matriz(1,:))-1;
for j=1:long_t
  if (t(j)<x(1) || t(j)>x(n+1)) valor(j)=0;
    break;
  endif
  desp=1;
  for i=1:m
    ind=1;
    if ((t(j)>=x(desp)) && (t(j)<=x(desp + d)))
      for k=desp:(desp+d)
        x_i(ind)=x(k);
        ind = ind+1;
      endfor
      valor(j)=polyinterpolador_eval(matriz(i,:), x_i, t(j));
      break;
    endif;
    desp = desp + d;
  endfor
endfor
endfunction