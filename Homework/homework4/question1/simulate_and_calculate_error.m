function error = simulate_and_calculate_error(lambda_L, target_duration)
    num_simulations = 2000;
    num_steps = 1000;

    % Initialize variable to store maximum durations
    max_durations = zeros(num_simulations, 1);

    for i = 1:num_simulations
        % Generate the state transitions
        state = simulate_states(lambda_L, num_steps);

        % Find the longest spell in the low state
        max_durations(i) = find_longest_low_spell(state);
    end

    % Calculate the average of the longest spells
    average_duration = mean(max_durations);

    % Calculate the squared error between simulated and target duration
    error = (average_duration - target_duration)^2;
end