function max_duration = find_longest_low_spell(state)
    % Find the longest continuous period in low state
    durations = diff(find([1; diff(state); 1]));
    if state(1) == 1  % If starts in low state
        low_durations = durations(1:2:end);
    else
        low_durations = durations(2:2:end);
    end
    max_duration = max(low_durations);
end