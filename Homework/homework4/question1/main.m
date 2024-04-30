% This file solves question 1 of homework 2. It simulates the model in week
% 4 lecture and chooses lambda_L such that the unemployment span is 3
% months
% Author: Yi Zhou
% Date: April 29, 2024

% Note (I could be wrong): contradicting to my first thought, I think this
% unemployment process is not related to the household problem since the
% states depend on exogenous Poisson process but not on household choice of
% consumption and saving. Then my understanding to this question is that we
% observe unemployment span from the data, and we can use that to directly
% calibrate lambda_L under the assumption that the income y follows a
% Poisson process. 

% Here dt = 1 meaning one day, then three months is 90 days. I simulate for
% 1000 days and caculate the longest unemployment span, then I repeat the
% process for 2000 times, deriving average span, then I use fminsearch to
% find lambda_L that minimizes error


clear all ; close all ; clc ;
tic ;

% Objective function to minimize
target_duration = 90;  % Target average unemployment duration in days
error_function = @(lambda_L) simulate_and_calculate_error(lambda_L, target_duration);

% Initial guess for lambda_L
initial_guess = 1/10;

% Use fminsearch to find the optimal lambda_L
options = optimset('Display', 'iter');
lambda_L_opt = fminsearch(error_function, initial_guess, options);

toc;



