function [r,w,K,A,u,c,V,g,dV_Upwind,dVf,dVb,If,Ib,I0,l_supply] = aiyagri_steady_state()
% This file reproduces the same outputs as the "compute_steady_state" in class using
% my earlier code of Aiyagari model


% Outputs:  (1) r: steady state interest rate
%           (2) w: steady state wage
%           (3) K: capital stock
%           (4) A: matrix for computing value function
%           (5) u: utility over grid
%           (5) c: consumption over grid
%           (6) V: value function over grid
%			(7) g: distribution
%           (8) dV_Upwind: derivative of value function by upwind scheme
%           (9) dVf: derivative of value function by forward difference
%           (10) dVb: derivative of value function by backward difference
%           (11) If: indicator for forward drift in savings
%           (12) Ib: indicator for backward drift in savings
%           (13) I0: indicator for no drift in savings


% calling globals
global ggamma rrho ddelta aalpha ssigmaTFP rrhoTFP z lla mmu ttau I amin amax a da aa ...
	zz Aswitch rmin rmax r0 maxit crit Delta Ir crit_S zAvg A

% create structure with structural parameters
% set_parameters;
call_parameters;
% create structure with numerical parameters
numerical_parameters;
% create structure with grids and initial guesses for v
grid = create_grid(param,num);

% define error funciton of excess_k_supply
error = @(r) excess_k_supply(param,num,grid,r);

% initial guess
initial_guess = r0;

% find the optimal r minimizing the excess k supply
options = optimset('Display', 'iter');
r = fminsearch(error,initial_guess,options);
w = (1-param.alpha)*(param.alpha/(r+param.delta))^(param.alpha/(1-param.alpha));

[c,saving,V,A,l_supply,k_supply_eqm,g,dV_Upwind,dVf,dVb,If,Ib,I0] = household(param,num,grid,r,w);
K = (param.alpha/(r+param.delta))^(1/(1-param.alpha)) * l_supply;

u = utility(c);

end