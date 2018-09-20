%Tarea 1. Control Automatico
%II Semestre 2018
%Emmanuel Araya - Nicole Miranda - Jose Joaquin Rodriguez
% PruebaTarea1
% Sistema original
A = [0 0 1 0;0 0 0 1; 0 0 -9.2751 0; 0 0 0 -3.4955];
B = [0 0;0 0;2.3667 0.0790;0.2410 0.7913];
C = [1 0 0 0;0 1 0 0];
D = [0];
plantaMIMO = ss(A,B,C,0);
% Matrices para REI con LQR
Q = diag([200 150 100 200 50 50]);
R = eye(2);
% Llamada a la función creada
[K,Ki] = rei_lqr(A,B,C,D,Q,R);
% Quite el % para activar
% la forma alterna de rei_lqr.m
%[K,Ki] = rei_lqr(plantaMIMO,Q,R)

%------------------Funcion lqr-------------------------

function [K,Ki] = rei_lqr(A,B,C,D,Q,R)

[m_a,n_a] = size(A); %Tamano de matriz A ingresada
[m_c,n_c] = size(C); %Tamano de matriz C ingresada
[m_b,n_b] = size(B); %Tamano de matriz B ingresada
[m_q,n_q] = size(Q); %Tamano de matriz B ingresada

%Comprobando controlabilidad 
%Revisar criterio de controlabilidad de matriz aumentada, me base en lo de
%las presentaciones de Interiano
M = [A B;-C zeros(m_c,m_c)];
controlabilidad = rank(M);
disp(controlabilidad);

%Condicion de controlabilidad evaluada

if controlabilidad == m_a + n_b %%La condicion nombrada menciona que un sistema en completamente
                               % controlable si tiene un rango de n+1, pero
                               % esto porque es SISO, al ser la matriz B
                               % de dos columnas esto agranda la matriz de
                               % controlabilidad. Por ende, creo que la
                               % condicion general esque el sistema es
                               % estable si el rango es n + numero de
                                % inputs
    X = "El sistema es completamene controlable";
    disp(X)
    
    %Calculo de K y Ki

    A_s = [A zeros(m_a,m_c);-C zeros(m_c,m_c)]; %Creacion de matriz A aumentada 
    B_s = [B;zeros(m_c,n_b)]; %Creacion de matriz aumentada B
    K_s = lqr(A_s,B_s,Q,R); % Creacion de matriz K aumentada ------------Ultima columna es k
                      % Columnas de k1 a ki componene matriz K
    Ki = -1*K_s(1:m_c,m_a+1:m_q); %Matriz columna Ki
    K =  K_s(1:m_c,1:m_q-m_c); %Matriz K normal
    disp("Matriz Ki")
    disp(Ki);
    disp("Matriz K")
    disp(K);
else
    X = "El sistema no es controlable";
    Y = "Introduzca valores correctos de nuevo";
    disp(X);
    disp(Y);
    
end

end
