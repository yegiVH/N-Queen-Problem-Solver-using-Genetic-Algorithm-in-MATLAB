function mutated_child = Mutate(parent, mutationProbability)


N = length(parent);

% Initialize the offspring as a copy of the parent.
mutated_child = parent;

% Apply mutation with a given probability to each element.
for i = 1: N/2
    if rand < mutationProbability
            values = 1 : N;
            rand_g1 = randsample(values,2, false);
            temp = mutated_child(rand_g1(1));
            mutated_child(rand_g1(1)) = mutated_child(rand_g1(2));
            mutated_child(rand_g1(2)) = temp;
    end

end

