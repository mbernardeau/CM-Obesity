%intense simulation about human functioning and obesity

%constants
total_var = 5; %5 because mood has been pre-set


%input handling

total_year = input('how long should the simulation last?');
total_agents = input('how many agents are simulated?');

display = fprintf('The simulation will run: %d Agents and take: %d Years', total_agents, total_year);

%matrix data structure for agent simulation
%constants for: mood nrg_in nrg_out BMI and weight
%create vector size of total_agents
agent_days = 1:total_agents;

% Open trace file
trace = fopen('trace.tr', 'w');


%determine mood for each agent for the simulation:
mood_line = zeros(1, total_agents);
for i = 1:total_agents
    mood_line(i) = set_mood();
end
agent_days = [agent_days;mood_line];

%Functional stuff
year_count = 0;
day_count = 0;
%while loop
while (year_count < total_year)
    day_count = day_count + 1;
    %based on n data points that get altered concatenate n spaces on
    %line (each n lines will represent a day that way)
    %based on current variables:
    
    temp = zeros(total_var, total_agents); %creates empty 6 by n agents matrix ready to be filled
    for i = 1:total_agents 
        %2set nrg_in for agent i
        %3set nrg_out for agent i
        %4calc nrg_netto for agent i (energy expenditure)
        %5calc weight
        temp(5, i) = 78;
        %6calc BMI               
    end
    %append the now filled temp matrix to agent_days
    agent_days = [agent_days;temp]; 
    
    %keep track of years:
    if(mod(day_count, 365) == 0)
        year_count = 1 + year_count;
    end
    fprintf('Day: %d, year: %d\n', day_count, year_count);
    
    % Generating traces for the day
    fprintf(trace, 'atom_trace(mood, mood, [range(%d, %d, %s)]).', day_count, day_count+1, mood);
    
end
%end while loop
