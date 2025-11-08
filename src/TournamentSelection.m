function i=TournamentSelection(pop,m)

    nPop=numel(pop); % number of elements in pop will be in nPop

    S=randsample(nPop,m); % choose m answers randomly from nPop
    
    spop=pop(S);
    
    scosts=[spop.Cost];
    
    [~, j]=min(scosts);
    
    i=S(j);

end