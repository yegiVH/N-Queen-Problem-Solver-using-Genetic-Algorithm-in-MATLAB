clc;
clear;
close all;

%% Problem Definition
%n-Q

CostFunction=@(x) nqueen_cost(x);     % Cost Function


nVar = int32(input('What is "n" in n-queen?'));      % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin= 1;         % Lower Bound of Variables
VarMax= nVar;         % Upper Bound of Variables


%% GA Parameters

MaxIt = 50;      % Maximum Number of Iterations

nPop = 70;        % Population Size

pc = 0.8;                 % Crossover Percentage
nc = 2*round(pc*nPop/2);  % Number of Offsprings (Parnets)

pm = 0.3;                 % Mutation Percentage
nm = round(pm*nPop);      % Number of Mutants


mu = 0.3;         % Mutation Rate

ANSWER = questdlg('Choose selection method:','Genetic Algorith',...
    'Roulette Wheel','Tournament','Random','Roulette Wheel');

UseRouletteWheelSelection = strcmp(ANSWER,'Roulette Wheel');
UseTournamentSelection = strcmp(ANSWER,'Tournament');
UseRandomSelection = strcmp(ANSWER,'Random');

if UseRouletteWheelSelection
    beta = 8;         % Selection Pressure
end

if UseTournamentSelection
    TournamentSize=3;   % Tournamnet Size
end

pause(0.1);

%% Initialization

empty_individual.Position = [];
empty_individual.Cost = [];
 
pop=repmat(empty_individual,nPop,1);


% generate random population
for i=1:nPop

    % Initialize Position
    pop(i).Position = randperm(VarMax);
    
 
    % Evaluation
    pop(i).Cost = CostFunction(pop(i).Position);
    
end 


% Sort Population
Costs = [pop.Cost];
[Costs, SortOrder] = sort(Costs);
pop = pop(SortOrder);

% Store Best Solution
BestSol = pop(1);

% Array to Hold Best Cost Values
BestCost = zeros(MaxIt,1);

% Store Cost
WorstCost = pop(end).Cost;



%% Main Loop


for it=1:MaxIt
     
    % Crossover
    popc = repmat(empty_individual,nc/2,2);
    

    for k=1:nc/2
        
        
        % Select Parents Indices
        if UseRouletteWheelSelection
            % Calculate Selection Probabilities
            P = exp(-beta*Costs/WorstCost);
            P = P/sum(P);
            i1 = RouletteWheelSelection(P);
            i2 = RouletteWheelSelection(P); 
        end
        if UseTournamentSelection
            i1 = TournamentSelection(pop,TournamentSize);

            i2 = TournamentSelection(pop,TournamentSize);
        end
        
        if UseRandomSelection
            i1 = randi([1 nPop]);
            i2 = randi([1 nPop]);
        end

        % Select Parents
        p1 = pop(i1);
        p2 = pop(i2);
        
        % Apply Crossover
        [popc(k,1).Position, popc(k,2).Position]=...
            uniformCrossoverByOrder(p1.Position,p2.Position);
       
        
        % Evaluate Offsprings
        popc(k,1).Cost = CostFunction(popc(k,1).Position);
        popc(k,2).Cost = CostFunction(popc(k,2).Position);
        
        
    end
    
    popc=popc(:);
    
    
    % Mutation
    popm=repmat(empty_individual,nm,1);
    for k=1:nm
        
        
        % Select Parent
        i=randi([1 nPop]);
        p=pop(i);
        
        % Apply Mutation
        popm(k).Position=Mutate(p.Position,mu);
        
        % Evaluate Mutant
        popm(k).Cost=CostFunction(popm(k).Position);
        
    end
    
    % Create Merged Populationدغام
    pop=[pop
         popc
         popm];
     
    % Sort Population
    Costs = [pop.Cost];
    [Costs, SortOrder] = sort(Costs);
    pop = pop(SortOrder);
    
    % Update Worst Cost
    WorstCost=max(WorstCost,pop(end).Cost);
    
    % Truncation
    pop = pop(1:nPop);
    Costs = Costs(1:nPop);
    
    % Store Best Solution Ever Found
    BestSol=pop(1);
    
    % Store Best Cost Ever Found
    BestCost(it) = BestSol.Cost;
    
    
    % Show Iteration Information
    disp(['Iteration ' num2str(it) ', Best Cost = ' num2str(BestCost(it))]);
    
end



% Result

% Create a chess board matrix with zeros and ones
% Create a chess board matrix with zeros and ones
chessBoard = zeros(nVar);
chessBoard(1:2:end, 1:2:end) = 1;
chessBoard(2:2:end, 2:2:end) = 1;

% Generate a random 8-queens position
queens = BestSol.Position;

% Plot the chess board with queens
colormap(gray);
imagesc(chessBoard);
hold on;
for i = 1:nVar
    plot(queens(i), i, 'rx', 'MarkerSize', 20);
end

axis square;





