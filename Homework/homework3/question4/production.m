function pi = production(param,num,grid)
% entrepreneur chooses production technology and how much to produce

% solve the problem by hand and plug in the closed-form results
k_b = min(grid.a, 1/(16*param.r^2));
k_g = min(grid.a, param.kappa + 4/(25*param.r^2));

% compute profit
pi_b = 0.5*k_b.^2 - param.r * k_b;
pi_g = 0.8*(max(k_g-param.kappa,0)).^0.5 - param.r * k_g;

% choose higher-profit technology
pi = max(pi_b, pi_g);



end