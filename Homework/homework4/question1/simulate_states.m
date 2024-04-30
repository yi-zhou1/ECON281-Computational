function state = simulate_states(lambda_L, num_steps)
    % Probability of staying in low state
    p_LL = exp(-lambda_L);
    lambda_H=0.9; % turned out that the results is insensitive to this choice, which makes sense
    p_HH = exp(-lambda_H);

    % Initialize states array
    state = zeros(num_steps, 1);
    state(1) = 1;  % Start in low state, 1 stands for low and 0 stands for high

    % Simulate state transitions
    for t = 2:num_steps
        if state(t-1) == 1
            if rand() <= p_LL
                state(t) = state(t-1);  % Stay in the low state
            else
                state(t) = 1 - state(t-1);  % Change state to high
            end
        else
            if rand() <= p_HH
                state(t) = state(t-1);  % Stay in the high state
            else
                state(t) = 1 - state(t-1);  % Change state to low
            end
        end
    end
end