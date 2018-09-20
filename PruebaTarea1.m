% PruebaTarea1
% Sistema original
A = [0 0 1 0;0 0 0 1; 0 0 -9.2751 0; 0 0 0 -3.4955]; B = [0 0;0 0;2.3667 0.0790;0.2410 0.7913];
C = [1 0 0 0;0 1 0 0];
plantaMIMO = ss(A,B,C,0);
% Matrices para REI con LQR
Q = diag([200 150 100 200 50 50]);
R = eye(2);
% Llamada a la funcio?n creada
[K,Ki] = rei_lqr(A,B,C,D,Q,R)
% Quite el % para activar
% la forma alterna de rei_lqr.m
%[K,Ki] = rei_lqr(plantaMIMO,Q,R)