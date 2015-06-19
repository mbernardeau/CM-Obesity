function [state] = set_mood()
    
    lower = 1;
    upper = 2;
    mood = lower+round(rand(1)*upper);
    %mood 1 = 'happy' | mood 2 = 'neutral' | mood 3 = 'depressed'
    state = mood;
end
