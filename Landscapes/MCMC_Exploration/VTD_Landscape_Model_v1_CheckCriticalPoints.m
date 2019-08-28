
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
        priorOK=1;
    end
  
elseif CaseLandscape==4

    if nrealcriticpoints == 3
        priorOK=1;
        if length(find(critpointsrewritten(vector,1)>=0))==3
        priorOK=1;
        critpoints = critpointsrewritten(vector);
        end
    end
  
elseif CaseLandscape==4
    if nrealcriticpoints == 3
        condition1 = find(critpointsrewritten(vector,1).*critpointsrewritten(vector,2)>=0);
        if sum(condition1>=2)
            condition2 = length(find(critpointsrewritten(condition1,1)>0));
            condition3 = length(find(critpointsrewritten(condition1,1)<0));
            if (condition2>=1)&&(condition3>=1)
            priorOK=1;
            end
        end
    end

    
end
