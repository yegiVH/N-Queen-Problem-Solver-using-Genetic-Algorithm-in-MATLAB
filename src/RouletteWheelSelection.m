function i=RouletteWheelSelection(P)

    r=rand;
    
    c=cumsum(P);
    
    i=find(r<=c,1,'first');% find the first place where r is lower than c

end