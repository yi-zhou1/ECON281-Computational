function [saving] = saving(r)

% create structure with structural parameters
call_parameters;
% create structure with numerical parameters
numerical_parameters ;
% create structure with grids and initial guesses for v
grid = create_grid(param,num) ;

% set the discount factor
param.r = r;

% guess a initial value function
v_old = grid.v0;

% iterate to reach the converged value function
dist = 1 ;
while dist > num.tol 
    [v_new,~,~] = vfi_iteration(v_old,param,num,grid) ;
    dist = max(abs((v_new(:) - v_old(:)))) ;
    v_old = v_new ;
   % disp(dist)
end
[v_new,c,A] = vfi_iteration(v_new,param,num,grid) ;

[gg] = kf_equation(A,grid,num) ;
g = [gg(1:num.a_n),gg(num.a_n+1:2*num.a_n)];

% aggregate saving in the economy
saving = sum(sum(((1+r)*grid.a + param.y - c).*g.*grid.da));

end