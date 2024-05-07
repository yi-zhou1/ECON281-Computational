function [error] = excess_k_supply(param,num,grid,r)

% using market clearing to write w in terms of r

w = (1-param.alpha).*(param.alpha./(r+param.delta)).^(param.alpha/(1-param.alpha));

[c,saving,l_supply,k_supply,g] = household(param,num,grid,r,w);

k_demand = firm(param,r,l_supply);

error = (k_supply-k_demand)^2;
end