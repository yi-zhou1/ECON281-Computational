%% This code solves for question 4 of the problem set 3 of ECON281-Comp in 2024 Spring
% Question 4 asks to add a technology layer to question 3
% The vfi_iteration_implicit file is from Ben Moll's website with adjustments
% Yi Zhou April 22, 2024

clear all ; close all ; clc ;
tic ;
% create structure with structural parameters
call_parameters ;
% create structure with numerical parameters
numerical_parameters ;
% create structure with grids and initial guesses for v
grid = create_grid(param,num) ;

% initial guess of the value function
v_old = grid.v0 ;

% iterate the value function using the upwind scheme and the implicit method
dist = 1 ;
while dist > num.tol 
    [v_new,~] = vfi_iteration_implicit(v_old,param,num,grid) ;
    dist = max(abs((v_new - v_old))) ;
    v_old = v_new ;
end

[v_new,c] = vfi_iteration_implicit(v_old,param,num,grid) ;
toc ;

%[sim] = simulate(c,param,num,grid) ;

% graphing
% I solved for kappa = 0.1, can do the same for kappa = 0 and 0.4
figure();
plot(c,'o');
xlabel('Assets');
ylabel('Consumption'); 
legend('Consumption Policy Function', 'True Consumption Function');


%figure()
%plot(sim.a)
%figure()
%plot(sim.beta_1)