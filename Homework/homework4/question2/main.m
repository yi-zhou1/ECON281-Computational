% This file solves question 2 of homework 4. It creates a aggregate saving
% demand function of interest rate, and plots the saving for r in a certain
% range
% Author: Yi Zhou
% Date: April 29, 2024


clear all ; close all ; clc ;
tic ;
% create structure with structural parameters
call_parameters;
% create structure with numerical parameters
numerical_parameters ;
% create structure with grids and initial guesses for v
grid = create_grid(param,num) ;

% interest rates from 0 to 0.04 in increments of 0.001
r_range = 0:0.001:0.04; 

% initialize array to store savings values
savings_output = zeros(size(r_range)); 

% calculate savings for each interest rate
for i = 1:length(r_range)
    r = r_range(i);
    savings_output(i) = saving(r); % Assuming saving(r) is your function
end

% Plot the results
plot(r_range, savings_output);
xlabel('Interest Rate');
ylabel('Aggregate Savings');
title('Aggregate Demand for Savings as a Function of Interest Rate');
toc ;
