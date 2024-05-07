function [k_demand] = firm(param,r,l_supply)

% apply firm foc and labor market clearing and derive captial demand
k_demand = sum((param.alpha./(r+param.delta)).^(1/(1-param.alpha)) .* l_supply);

end