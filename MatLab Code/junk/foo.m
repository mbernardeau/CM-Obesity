%test function to test plotting

x = zeros(365 * total_year, total_agents);

i = 6; % var of interest this is set to weight
%i = 7; %set to BMI

while(i < ((365*total_year) * total_var)+2)
    for j = 1:total_agents
        if(i~= 1)
            x(round(i/total_var),j) = agent_days(i,j);
        else
            x(i,j) = agent_days(i,j);
        end
    end
    i = i + total_var;
end

plot(x);