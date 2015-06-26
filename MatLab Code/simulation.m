%intense simulation about human functioning and obesity

%constants
total_var = 5; %5 because mood has been pre-set
base_weight = 70; %starting weight of all agents
base_height = 1.75; %starting height of all agents
%test_val = 3180.8; %test value for nrg in and energy out

%input handling

total_year = input('how long should the simulation last?');
total_agents = input('how many agents are simulated?');
%total_agents = 3;

display = fprintf('The simulation will run: %d Agents and take: %d Years\n', total_agents, total_year);

%matrix data structure for agent simulation
%constants for: mood nrg_in nrg_out BMI and weight
%create vector size of total_agents
%agent_days = 1:total_agents;

% Open trace file
trace = fopen('trace.tr', 'w');
% Duration of the simulation
fprintf(trace, 'times(%d, %d, %d).\n', 0, total_year*365, total_year*365);

% Creating agents and set Mood
for i = 1:total_agents
   %base_height = randomize_set(1.4, 2.2);
   %for debugging change set_mood() with i
   agents(i) = Agent(total_year*365, base_height, set_mood());
   fprintf(trace, 'atom_trace(_, mood(%d, %d), [range(0, %d, true)]).\n', i, agents(i).Mood, total_year*365);
end

%determine mood for each agent for the simulation:
% mood_line = zeros(1, total_agents);
% for i = 1:total_agents
%     mood_line(i) = set_mood();
%end
%agent_days = [agent_days;mood_line];


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
            %comment this section out if base_weight should not be
            %randomized
            %base_weight = randomize_set(40, 100);
            agents(i).weight(day_count) = base_weight;
            fprintf(trace, 'atom_trace(_, weight(%d, %f), [range(%d, %d, true)]).\n', i, agents(i).weight(day_count), day_count, day_count+1);
            agents(i).bmi(day_count) = (agents(i).weight(day_count)/(base_height)^2);
            fprintf(trace, 'atom_trace(_, bmi(%d, %f), [range(%d, %d, true)]).\n', i, agents(i).bmi(day_count), day_count, day_count+1);
        else
            old_weight = agents(i).weight(day_count-1);
            
            %2set nrg_in for agent i
            nrg_in = set_intake(old_weight,  agents(i).Mood);
            agents(i).nrg_in(day_count) = nrg_in;
            fprintf(trace, 'atom_trace(_, nrg_in(%d, %f), [range(%d, %d, true)]).\n', i, agents(i).nrg_in(day_count), day_count, day_count+1);
            
            %3set nrg_out for agent i
            %4calc nrg_netto for agent i (energy expenditure)
            nrg_out = set_expen(old_weight,  agents(i).Mood, nrg_in);
            agents(i).nrg_out(day_count) = nrg_out;
            fprintf(trace, 'atom_trace(_, nrg_out(%d, %f), [range(%d, %d, true)]).\n', i, agents(i).nrg_out(day_count), day_count, day_count+1);
            nrg_netto = nrg_in-nrg_out;
            agents(i).nrg_netto(day_count) = nrg_netto;
            fprintf(trace, 'atom_trace(_, nrg_netto(%d, %f), [range(%d, %d, true)]).\n', i, agents(i).nrg_netto(day_count), day_count, day_count+1);
            
            %5calc weight
            agents(i).weight(day_count) = old_weight + (base_height * 0.6)+(nrg_netto/7716);
            fprintf(trace, 'atom_trace(_, weight(%d, %f), [range(%d, %d, true)]).\n', i, agents(i).weight(day_count), day_count, day_count+1);
            %6calc BMI
            agents(i).bmi(day_count) = (agents(i).weight(day_count)/(base_height)^2);
            fprintf(trace, 'atom_trace(_, bmi(%d, %f), [range(%d, %d, true)]).\n\n', i, agents(i).bmi(day_count), day_count, day_count+1);
        end
    end
    
    %keep track of years:
    if(mod(day_count, 365) == 0)
        year_count = 1 + year_count;
    end
    fprintf('Day: %d, year: %d\n', day_count, year_count);
end
%end while loop
fclose(trace);