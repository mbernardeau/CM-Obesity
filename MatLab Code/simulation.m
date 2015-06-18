%intense simulation about human functioning and obesity

%constants
total_var = 5; %5 because mood has been pre-set
base_weight = 70; %starting weight of all agents
base_height = 1.75; %starting height of all agents
%test_val = 3180.8; %test value for nrg in and energy out

%input handling

total_year = input('how long should the simulation last?');
total_agents = input('how many agents are simulated?');

display = fprintf('The simulation will run: %d Agents and take: %d Years\n', total_agents, total_year);

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
        if(day_count == 1)
            temp(4,i) = base_weight;
            temp(5,i) = (temp(4, i)/(base_height)^2);
        else
            if(day_count == 2)
                old_weight = agent_days(6);
            else
                old_weight = agent_days(6+total_var);
            end
            %2set nrg_in for agent i
            nrg_in = set_intake(old_weight, agent_days(2,i));
            temp(1,i) = nrg_in;
            %3set nrg_out for agent i
            %4calc nrg_netto for agent i (energy expenditure)
            nrg_out = set_expen(old_weight, agent_days(2,i), nrg_in);
            temp(2,i) = nrg_out;
            nrg_netto = nrg_in-nrg_out;
            temp(3,i) = nrg_netto;
            %5calc weight
            temp(4,i) = old_weight + (base_height * 0.6)+(nrg_netto/7716);
            %6calc BMI
            temp(5,i) = (temp(4,i)/(base_height)^2);
        end
    end
    %append the now filled temp matrix to agent_days
    agent_days = [agent_days;temp]; 
    
    %keep track of years:
    if(mod(day_count, 365) == 0)
        year_count = 1 + year_count;
    end
    fprintf('Day: %d, year: %d\n', day_count, year_count);
    
    % Generating traces for the day
    %TODO: fprintf(trace, 'atom_trace(mood, mood, [range(%d, %d, %s)]).', day_count, day_count+1, mood);
    
end
%end while loop
