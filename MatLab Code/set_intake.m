function [intake] = set_intake(old_weight, mood)
    %this function returns the caloric intake of our agents
    %decided to just take the minimal caloric intake for boys
    minimal_cal_in = (879+11.6*old_weight) * (1.71*1.1);
    
    lower = .95;
    upper = 1.2;
    if(mood == 1)
        upper = 1.2;
        lower = .97;
    elseif(mood == 2)
        upper = 1.1;
        lower = .96;
    else
        upper = 1;
        lower = .90;
    end
    
    intake = minimal_cal_in * (lower + (upper-lower*rand(1)));
    
    
end