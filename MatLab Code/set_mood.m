function [state] = set_mood()
    
    upper = 3;
    mood = round(rand(1)*upper);
    %mood 1 = 'happy' | mood 2 = 'neutral' | mood 3 = 'depressed'
    state = mood;
end
