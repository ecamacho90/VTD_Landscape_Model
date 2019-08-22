function [priorOK,critpoints]=VTD_Landscape_Model_v1_CheckCriticalPoints(critpointsx,critpointsy,CaseLandscape)

%We can check the quadrants here too if wanted

priorOK=0;
critpoints=[];
critpointsrewritten = vpa([critpointsx,critpointsy]);
vector = find(sum(abs(imag(critpointsrewritten)),2)==0);
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
        if length(find(critpointsrewritten(vector,1)>=0))==3
        priorOK=1;
        critpoints = critpointsrewritten(vector);
        end
    end
  
elseif CaseLandscape==4

    if nrealcriticpoints == 3
        if sum(find(critpointsrewritten(vector,1).*critpointsrewritten(vector,2)<=0)>=2)
        priorOK=1;
        end
    end

    
end
