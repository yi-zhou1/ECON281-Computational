%% This code solves for question 3 of the problem set 3 of ECON281-Comp in 2024 Spring
% Question 3 asks to add a production layer to question 1
% I solved the profit maximization and plug in k^star = 1/(16r^2) and y^star
% = 1/(8r) to replace y = 1
% The vfi_iteration_implicit file is from Ben Moll's website with adjustments
% Yi Zhou April 22, 2024

clear all ; close all ; clc ;
tic ;
% create structure with structural parameters
call_parameters;
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
figure();
plot(c,'o');
hold;
plot(param.y + param.r*grid.a,'r');
xlabel('Assets');
ylabel('Consumption'); 
legend('Consumption Policy Function', 'True Consumption Function');
hold off;

%figure()
%plot(sim.a)
%figure()
%plot(sim.beta_1)