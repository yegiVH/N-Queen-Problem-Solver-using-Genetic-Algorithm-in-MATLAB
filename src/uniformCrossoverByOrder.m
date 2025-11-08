
function [child1, child2] = uniformCrossoverByOrder(parent1, parent2)
% parent1: first parent chromosome
% parent2: second parent chromosome
% mask: binary random array, 1s indicate the positions to exchange

    n = length(parent1); % size of chromosome
    mask = randi([0, 1], 1, n);
    
    % initialize offspring chromosomes
    child1 = zeros(1, n);
    child2 = zeros(1, n);

    % copy masked positions from parent1 to offspring2, and vice versa
    child1(logical(mask)) = parent1(logical(mask));
    child2(logical(mask)) = parent2(logical(mask));

    n1 = parent1(logical(mask));
    n2 = parent2(logical(mask));

    i = 1;
    j = 1;
    while j <= n && i ~= n + 1 && i ~= n
        while i <= n 
            if child1(i) == 0 && i ~= n + 1
                if isempty(n1(n1 == parent2(j)))
                    child1(i) = parent2(j);
                    i = i + 1;
                end
                j = j + 1;
            else
                i = i + 1;
            end
        end
    end
    
    
    i = 1;
    z = 1;
    while z <= n && i ~= n + 1 && i ~= n
        while i <= n
            if child2(i) == 0 && i ~= n + 1
                if isempty(n2(n2 == parent1(z)))
                    child2(i) = parent1(z);
                    i = i + 1;
                end
                z = z + 1;
            else
                i = i + 1;
            end
        end
    end
end



