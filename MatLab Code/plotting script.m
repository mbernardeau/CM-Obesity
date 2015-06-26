for i = 1:total_agents
    if i == 1
        A = [agents(i).weight];
    else
        A = [A agents(i).weight];
    end
end

figure
plot(A);
