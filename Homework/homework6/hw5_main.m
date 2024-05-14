% ECON281 Comp 2024 Spring Week 5 Homework Question 1
% Solve Aiyagari model with income shock
% Author: Yi Zhou

clear all ; close all ; clc ;
% create structure with structural parameters
call_parameters;
% create structure with numerical parameters
numerical_parameters;
% create structure with grids and initial guesses for v
grid = create_grid(param,num);

%% solve equilibrium interest rate and wage
tic ;
% define error funciton of excess_k_supply
error = @(r) excess_k_supply(param,num,grid,r);

% initial guess
initial_guess = 0.01;

% find the optimal r minimizing the excess k supply
options = optimset('Display', 'iter');
r_eqm = fminsearch(error,initial_guess,options);
w_eqm = (1-param.alpha)*(param.alpha/(r_eqm+param.delta))^(param.alpha/(1-param.alpha));

[c,saving,l_supply_eqm,k_supply_eqm,g] = household(param,num,grid,r_eqm,w_eqm);
k_demand_eqm = (param.alpha/(r_eqm+param.delta)^(1/(1-param.alpha))) * l_supply_eqm;

toc;
%% draw capital supply and demand curves by simulation
tic;
% simulate over interest rate to draw capital demand and supply
r_range = 0.01:0.001:0.05; 

% initialize array to store savings values
k_demand = zeros(size(r_range)); 
k_supply = zeros(size(r_range));

% calculate savings for each interest rate
for i = 1:length(r_range)
    r = r_range(i);
    w = (1-param.alpha)*(param.alpha/(r+param.delta))^(param.alpha/(1-param.alpha));
    [~,~,l_supply_1,k_supply_1,~] = household(param,num,grid,r,w);
    k_supply(i) = k_supply_1;
    k_demand(i) = (param.alpha/(r+param.delta)^(1/(1-param.alpha))) * l_supply_1;
end

toc;

%% graphing
figure();  % Create a new figure
hold on;   % Hold on to plot multiple lines
plot(k_demand, r_range, '-b');  
plot(k_supply, r_range, '-r');  
hold off; 
xlabel('Values');
ylabel('R Range');  
legend('Demand', 'Supply'); 
title('Aiyagari-Capital Demand and Supply'); 