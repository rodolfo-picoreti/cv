%% 
%% @dossier: Comparison between dlt and pinv in homography estimation
%%
addpath('./lib')
addpath('./data')
clear all; close all;

H = [
  2  4  6;
  1  3  5;
  0.5  0.1  1;
];   

u1 = [
  0 1 1 0;
  0 0 1 1;
  1 1 1 1;
];

N = 100;
u1 = [u1 [10*rand(2,N); ones(1,N)] [100*rand(2,N); ones(1,N)]]; 
u2 = normscale(H*u1);

% Add noise to measurements
u1([1;2],:) = u1([1;2],:) + 2*rand(2, size(u1,2));

% Pseudo-inverse estimation (100x faster then dlt)
Hpinv = u2*pinv(u1);

% DLT estimation
Hdlt = dlt(u1,u2);

% Error before optimization
Epinv = mean(reprojerror(u1, u2, Hpinv));
Edlt = mean(reprojerror(u1, u2, Hdlt));

% Minimize reprojection error
Hpinv_opt = optimize(u1, u2, Hpinv);
Hdlt_opt = optimize(u1, u2, Hdlt);

% Error after optimization
Epinv_opt = mean(reprojerror(u1, u2, Hpinv_opt));
Edlt_opt = mean(reprojerror(u1, u2, Hdlt_opt));

disp(sprintf('Dlt error: %.2f -> %.2f', Edlt, Edlt_opt));
disp(sprintf('Pseudo-inverse error: %.2f -> %.2f', Epinv, Epinv_opt));
