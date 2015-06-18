%intense simulation about human functioning and obesity

%input handling

total_year = input('how long should the simulation last?');
total_agents = input('how many agents are simulated?');

display = fprintf('The simulation will run: %d Agents and take: %d Years', total_agents, total_year);

%matrix data structure for agent simulation
%constants for: mood nrg_in nrg_out BMI and weight
%create vector size of total_agents
agent_days = 1:total_agents;
%save data in this big matrix that updates yearly (x2 because BMI and mood
agent_year = [(total_year*2), total_agents];

% Open trace file
trace = fopen('trace.tr', 'w');

%Functional stuff
year_count = 0;
day_count = 0;
%while loop
while (year_count < total_year)
    day_count = day_count + 1;
    %based on n data points that get altered concatenate n spaces on
    %line (each n lines will represent a day that way)
    %based on current variables:
    temp = zeros(6, total_agents); %creates empty 6 by n agents matrix ready to be filled
    for i = 1:length(agent_year) 
        %1set mood for agent i
        %2set nrg_in for agent i
        %3set nrg_out for agent i
        %4calc nrg_netto for agent i (energy expenditure)
        %5calc weight
        %6calc BMI
        %append the now filled temp matrix to agent_days
        agent_days = [agent_days;temp];        
    end
    if(mod(day_count, 365) == 0)
        year_count = 1 + year_count;
    end
    fprintf('Day: %d, year: %d\n', day_count, year_count);
    
    % Generating traces for the day
    fprint(trace, 'atom_trace(mood, mood, [range(%d, %d, %s)]).', day_count, day_count+1, mood);
    
end
%end while loop
