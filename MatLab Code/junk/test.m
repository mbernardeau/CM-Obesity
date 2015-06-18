function [state] = test()
    
    upper = 3;
    mood = round(rand(1)*upper);

    if(mood == 1)
        x = 'happy';
    elseif(mood == 2)
        x = 'neutral';
    else
        x = 'depressed';
    end
    state = x;
end
