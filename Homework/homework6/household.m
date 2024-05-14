function [c,saving,V,A,l_supply, k_supply,g,dV_Upwind,dVf,dVb,If,Ib,I0] = household(param,num,grid,r,w)

% initial guess for the value function
v_old = grid.v0;

% iterate to reach the converged value function
dist = 1 ;
while dist > num.tol 
    [v_new,~,~,~,~,~,~,~,~,~] = vfi_iteration(v_old,param,num,grid,r,w) ;
    dist = max(abs((v_new(:) - v_old(:)))) ;
    v_old = v_new ;
   % disp(dist)
end
[V,c,A,saving,dV_Upwind,dVf,dVb,If,Ib,I0] = vfi_iteration(v_new,param,num,grid,r,w) ;

[gg] = kf_equation(A,grid,num) ;
g = [gg(1:num.a_n),gg(num.a_n+1:2*num.a_n)];

l_supply = sum(sum(param.e.*g*grid.da));

k_supply = sum(sum(grid.a.*g*grid.da));

end