% ------------------------------------------------------------
% Solver Forward-Backward pour UNLocBoX
% ------------------------------------------------------------

function s = demo_forward_backward_solver()

    % 1) Le nom du solver
    s.name = 'DEMO_FORWARD_BACKWARD';

    % 2) Initialisation du solver
    s.initialize = @(x_0, fg, Fp, param) forward_backward_initialize(x_0, fg, Fp, param);

    % 3) L’algorithme à chaque itération
    s.algorithm = @(x_0, fg, Fp, sol, s, param) forward_backward_algorithm(fg, Fp, sol, s, param);

    % 4) Post-process à la fin
    s.finalize = @(x_0, fg, Fp, sol, s, param) sol;

end

% ------------------------------------------------------------
% Initialisation du solver
% ------------------------------------------------------------
function [sol, s, param] = forward_backward_initialize(x_0, fg, Fp, param)

    % Gestion des paramètres optionnels
    if ~isfield(param, 'lambda'), param.lambda = 1; end
    if ~isfield(param, 'gamma'), param.gamma = 1; end

    % Stockage des variables internes
    s = struct;

    % Initialisation de la solution
    sol = x_0;

    % Vérification du nombre de fonctions non-lisses
    if numel(Fp) > 1
        error(['This solver cannot optimize more than one non-smooth function']);
    end

    % Vérification de la fonction lisse
    if ~fg.beta
        error('Beta = 0! This solver requires a smooth term.');
    end

end

% ------------------------------------------------------------
% Algorithme Forward-Backward
% ------------------------------------------------------------
function [sol, s] = forward_backward_algorithm(fg, Fp, sol, s, param)

    % Étape 1 : proximal
    s.x_n = Fp{1}.prox(sol - param.gamma * fg.grad(sol), param.gamma);

    % Étape 2 : mise à jour
    sol = sol + param.lambda * (s.x_n - sol);

end
