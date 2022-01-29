%% ENTREGA 1: EJERCICIO 1

%% Interpolacion a trozos de Lagrange
%% Entrada:
%%      x       =  vector de puntos (incluye nodos y nudos) ordenados de forma creiente
%%      y       =  vector de las ordenadas. 
%%      m       =  nº de trozos del intervalo
%%      d       =  grado de los polinomios
%% Salida:
%%      matriz  =  matriz cuyas filas son los coeficientes de los polinomios

function matriz = lagrangeTrozos(x, y, m, d)
  matriz=zeros(m, d+1);
  desp=0;               %% desplazamiento dentro del vector x e y
  for i=1:m
    k=1;
    for j=1:d+1
      nodos(k)=x(j+desp);       %% vector que incluye los nodos y nudos donde interpolamos
      ordenadas(k)=y(j+desp);   %% vector que incluye las ordenadas donde interpolamos
      k=k+1;
    endfor
    desp = desp + d;  
    matriz(i,:)=interpolNewton(nodos,ordenadas);
  endfor
endfunction