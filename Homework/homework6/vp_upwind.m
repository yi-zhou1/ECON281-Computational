function [dV_Upwind,dVf,dVb,If,Ib,I0,sb,sf] = vp_upwind(v0,param,num,grid,r,w)

% calling globals
global ggamma 

I = num.a_n;
V = v0 ;

%initialize forward and backwards differences with zeros: Vaf Vab

dVf = zeros(I,2) ;
dVb = zeros(I,2) ;


% use v0 to compute backward and forward differences
dVf(1:end-1,:) = (V(2:end,:) - V(1:end-1,:))/grid.da ;
dVf(end,:) = 0; 

dVb(2:end,:) = (V(2:end,:)-V(1:end-1,:))./grid.da;
dVb(1,:) = (r*grid.a(1,:) + w*param.e).^(-1); %state constraint boundary condition    
% dVb(1,:) = (r*grid.a(1,:) + w*param.e).^(-ggamma);


%consumption and savings with forward difference
% cf = dVf.^(-1/ggamma);
cf = dVf.^(-1);
sf = w*param.e + r.*grid.a - cf ;
%consumption and savings with backward difference
% cb = dVb.^(-1/ggamma);
cb = dVb.^(-1);
sb = w*param.e + r.*grid.a - cb ;
%consumption and derivative of value function at steady state
c0 = w*param.e + r.*grid.a ;
dV0 = c0.^(-1);
%Va0 = c0.^(-ggamma);

If = sf > 0; %positive drift --> forward difference
Ib = sb < 0; %negative drift --> backward difference
I0 = (1-If-Ib); %at steady state
dV_Upwind = dVf.*If + dVb.*Ib + dV0.*I0; %important to include third term


end