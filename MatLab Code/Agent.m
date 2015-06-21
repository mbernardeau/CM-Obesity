classdef Agent
    %Agent A result of the simulation for an agent
    %   Detailed explanation goes here
    
    properties
        Mood
        nrg_in
        nrg_out
        nrg_netto
        height
        weight
        bmi
    end
    
    methods
        function obj=Agent(duration)
            obj.Mood=set_mood();
            obj.nrg_in=zeros(duration,1);
            obj.nrg_out=zeros(duration,1);
            obj.nrg_netto=zeros(duration,1);
            obj.height=zeros(duration,1);
            obj.weight=zeros(duration,1);
            obj.bmi=zeros(duration,1);
        end
    end
end

