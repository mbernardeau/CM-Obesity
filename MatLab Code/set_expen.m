function [expen] = set_expen(old_weight, mood, intake)
    %this function returns the net result of intake and activities
    %basal metabolism

    
    lower = 1;
    if(mood == 2)
        upper = 6;
    elseif(mood == 3)
        upper = 3;
    else
        upper = 9;
    end
    
    int_activity = round((lower + (upper-lower*rand(1))));
    if(int_activity < 3) %high intensity
        nrg_out = 3 * old_weight;
    elseif(int_activity < 6 && int_activity > 2) %med intensity
        nrg_out = 2 * old_weight;
    else %low intensity
        nrg_out = 1 *old_weight;
    end
    
    expen = 854+((10.15+nrg_out)*old_weight)+(0.1*intake);
    
    
end
