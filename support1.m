%% Initialisation
clear;
close all;

% Loading toolbox
init_unlocbox;

verbose = 2; % verbosity level

%% Load an image

% Original image
im_original = cameraman;

% Displaying original image
imagesc_gray(im_original, 1, 'Original image');

%% Creation of the problem

sigma_noise = 10/255;
im_noisy = im_original + sigma_noise * randn(size(im_original));

% Create a matrix with randomly 50 % of zeros entry
p = 0.5;
matA = rand(size(im_original));
matA = (matA > (1-p));
% Define the operator
A = @(x) matA .* x;

% Masked image
y = A(im_noisy);

% Displaying the noisy image
imagesc_gray(im_noisy, 2, 'Noisy image');

% Displaying masked image
imagesc_gray(y, 3, 'Measurements');

%% Setting the proximity operator

lambda = 1;
% setting the function f1 (norm TV)
param_tv.verbose = verbose - 1;
param_tv.maxit = 100;
f1.prox = @(x, T) prox_tv(x, lambda*T, param_tv);
f1.eval = @(x) lambda * norm_tv(x);

% setting the function f2
param_proj.epsilon = sqrt(sigma_noise^2 * numel(im_original) * p);
param_proj.A = A;
param_proj.At = A;
param_proj.y = y;

param_proj.verbose = verbose - 1;
f2.prox = @(x, T) proj_b2(x, T, param_proj);
f2.eval = @(x) eps;

%% Solving problem I

% setting different parameters for the simulation
param_dg.verbose = verbose;
% display parameter
param_dg.maxit = 100;
% maximum number of iterations
param_dg.tol = 1e-5;
% tolerance to stop iterating
param_dg.gamma = 0.1 ;
% Convergence parameter
fig = figure(100);
param_dg.do_sol = @(x) plot_image(x, fig); % plotting plugin

% solving the problem with Douglas Rachord
param_dg.method = 'douglas_rachford';
sol = solvep(y, {f1, f2}, param_dg);

%% Displaying the result
imagesc_gray(sol, 4, 'Problem I - Douglas Rachford');

%% Defining the function for problem II

lambda = 0.05;
% setting the function f1 (norm TV)
param_tv.verbose = verbose-1;
param_tv.maxit = 50;
f1.prox = @(x, T) prox_tv(x, lambda * T, param_tv);
f1.eval = @(x) lambda * norm_tv(x);

% setting the function f3
f3.grad = @(x) 2 * A(A(x) - y);
f3.eval = @(x) norm(A(x) - y, 'fro')^2;
f3.beta = 2;

% To be able to use also Douglas Rachford
param_l2.A = A;
param_l2.At = A;
param_l2.y = y;
param_l2.verbose = verbose - 1;
param_l2.tightT = 1;
param_l2.pcg = 0;
param_l2.nu = 1;
f3.prox = @(x,T) prox_l2(x, T, param_l2);

%% Solving problem II (forward backward)
param_fw.verbose = verbose;
% display parameter
param_fw.maxit = 100;
% maximum number of iterations
param_fw.tol = 1e-5;
% tolerance to stop iterating
fig = figure(100);
param_fw.do_sol = @(x) plot_image(x, fig); % plotting plugin
param_fw.method = 'forward_backward';
sol21 = solvep(y, {f1, f3}, param_fw);
close(fig);

%% Displaying the result
imagesc_gray(sol21, 5, 'Problem II - Forward Backward' );

%% Solving problem II (Douglas Rachford)
param_dg.method = 'douglas_rachford';
param_dg.gamma = 0.5 ;
% Convergence parameter
fig = figure(100);
param_dg.do_sol = @(x) plot_image(x, fig); % plotting plugin
sol22 = douglas_rachford(y, f3, f1, param_dg);
close(fig);

%% Displaying the result
imagesc_gray(sol22, 6, 'Problem II - Douglas Rachford');

%% Close the UNLcoBoX
close_unlocbox;