function cost = nqueen_cost(solution)
    n = length(solution);
    
    conflicts = 0;
    
    for i = 1:n
        for j = i+1:n
            if abs(solution(i) - solution(j)) == j-i || solution(i) == solution(j)
                conflicts = conflicts + 1;
            end
        end
    end
    
    cost = conflicts;
end
