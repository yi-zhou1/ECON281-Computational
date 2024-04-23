function [v_new,c] = vfi_iteration_implicit(v0,param,num,grid)
% implement the algorithm in the slides.

v_old = v0;

% Perform the upwind scheme.
[Vp_upwind,sf,sb] = vp_upwind(v_old,param,num,grid);


% Infer consumption from Va_Upwind
c = Vp_upwind.^(-1);
u = utility(c);

%% Derive the transition matrix (borrowed from Ben Moll's codes)

% define 
X = - min(sb,0)/grid.da;
Y = - max(sf,0)/grid.da + min(sb,0)/grid.da;
Z = max(sf,0)/grid.da;

% create sparse transition matrix A
A = spdiags(Y,0,num.a_n,num.a_n)+spdiags(X(2:num.a_n),-1,num.a_n,num.a_n)+spdiags([0;Z(1:num.a_n-1)],1,num.a_n,num.a_n);

% solve for the new value function
B = (param.rho + num.Delta)*speye(num.a_n) - A;

b = u + num.Delta*v_old;
v_new = B\b;

end