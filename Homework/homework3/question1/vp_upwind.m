function [Va_Upwind,sf,sb] = vp_upwind(v0,param,num,grid)


% unpack the initial guess for v0 and call it V
V = v0;


%initialize forward and backwards differences with zeros: Vaf Vab

Vaf = zeros(num.a_n,1) ;
Vab = zeros(num.a_n,1) ;


% use V to compute backward and forward differences

Vaf(1:end-1) = (V(2:end) - V(1:end-1)) ./ grid.da ;
Vab(2:end) = (V(2:end) - V(1:end-1)) ./ grid.da ;


% impose the following boundary conditions. We will talk about them.
Vaf(end) = 0; 
Vab(1) = (param.r*grid.a(1) + param.y).^(-1); %state constraint boundary condition that makes things stay in the state space 


%consumption and savings with forward difference
cf = max(Vaf,1e-08).^(-1);   % this is important
sf = param.r .* grid.a + param.y - cf ;


%consumption and savings with backward difference
cb = max(Vab,1e-08).^(-1); % to avoid negative consumption
sb = param.r .* grid.a + param.y - cb ;
%consumption and derivative of value function at steady state
c0 = param.y + param.r .* grid.a ;
Va0 = c0.^(-1);


% compute indicator functions that capture the upwind scheme.
If = sf > 0; % postive drift  --> forward
Ib = sb < 0; % negative drift --> backward
I0 = (1-If-Ib); % steady state



% Compute the upwind scheme
Va_Upwind = Vaf.*If + Vab.*Ib + Va0.*I0; % dont forget the third term



end