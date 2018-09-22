%------------------Funcion lqr-------------------------

function [K,Ki] = rei_lqr(A,B,C,D,Q,R)
if (nargin<3 || nargin==4 || nargin==5) 
    Y = 'Muy pocos valores introducidos, introduzca valores correctos de nuevo';
    disp(Y);
    K=0; Ki=0;

elseif (nargin>6)
     Y = 'Muchos valores introducidos, introduzca valores correctos de nuevo';
    disp(Y);
    K=0; Ki=0;

else 
    if (nargin==3)
        %Falta revisar este cambio de MIMO ss a matrices A, B, C y D,
        %principalmente el B
        plantaMIMO=A;
        Q=B;
        R=C;
        A=plantaMIMO(1, 1).a;
        B=[plantaMIMO(1, 1).b plantaMIMO(1, 2).b];
        C=plantaMIMO(1, 1).c;
        D=plantaMIMO(1, 1).d;
        
    end
    [m_a,n_a] = size(A); %Tamano de matriz A ingresada
    [m_c,n_c] = size(C); %Tamano de matriz C ingresada
    [m_b,n_b] = size(B); %Tamano de matriz B ingresada
    [m_q,n_q] = size(Q); %Tamano de matriz B ingresada
    M=zeros(m_a+1,n_a+1);

    %Comprobando controlabilidad 
     A_s = [A zeros(m_a,m_c);-C zeros(m_c,m_c)]; %Creacion de matriz A aumentada 
     B_s = [B;zeros(m_c,n_b)]; %Creacion de matriz aumentada B
     M = ctrb(A_s,B_s);
     [m_m,n_m] = size(M);
     unco = length(A_s) - rank(M);
     if m_m~=n_m  %Si la matriz de controlabilidad no es cuadrada
         M=M*M.'; %Segun ppt del profe
     end
     controlabilidad = det(M);
     if controlabilidad ~= 0
            X = 'El sistema es completamene controlable';
            disp(X)

            %Calculo de K y Ki
            K_s = lqr(A_s,B_s,Q,R); % Creacion de matriz K aumentada ------------Ultima columna es k
            % Columnas de k1 a ki componene matriz K
            Ki = -1*K_s(1:m_c,m_a+1:m_q); %Matriz columna Ki
            K =  K_s(1:m_c,1:m_q-m_c); %Matriz K normal
            disp('Matriz Ki')
            disp(Ki);
            disp('Matriz K')
            disp(K);

    else
        X = 'El sistema no es controlable';
        Y = 'Introduzca valores correctos de nuevo';
        disp(X);
        disp(Y);

    end 


end