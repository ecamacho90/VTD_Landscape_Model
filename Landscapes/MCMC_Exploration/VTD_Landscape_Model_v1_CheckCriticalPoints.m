function priorOK=VTD_Landscape_Model_v1_CheckCriticalPoints(critpointsx,critpointsy,CaseLandscape)

%We can check the quadrants here too if wanted

priorOK=0;
vector = find(sum(abs(imag(vpa([critpointsx,critpointsy]))),2)==0);
nrealcriticpoints = length(vector);

if CaseLandscape==1
    if nrealcriticpoints == 7
        priorOK=1;
    end

elseif CaseLandscape==2
    if nrealcriticpoints == 5
        priorOK=1;
    end   
    
elseif CaseLandscape==3
    if nrealcriticpoints == 3
        priorOK=1;
    end
  
elseif CaseLandscape==4

    if nrealcriticpoints == 3
        priorOK=1;
    end

    
end
