function parameterOK=VTD_Landscape_Model_v1_Constraints(paramvalue,paramnumber,CaseLandscape)


%This function is to check that the parameters take the allowed values.

parameterOK=1;


if paramnumber==1
    %a
    if CaseLandscape == 1
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 2
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 3
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 4
        if paramvalue>=0
            parameterOK=0;
        end
    end

    
elseif paramnumber==2
    %b
    if CaseLandscape == 1
        if paramvalue<=0
            parameterOK=0;
        end
    elseif CaseLandscape == 2
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 3
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 4
        if paramvalue>=0
            parameterOK=0;
        end
    end

elseif paramnumber==3
    %c
    if CaseLandscape == 1
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 2
        
    elseif CaseLandscape == 3
        
    elseif CaseLandscape == 4
        
    end
    
elseif paramnumber==4   
    %u
    if CaseLandscape == 1
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 2
        if paramvalue>=0
            parameterOK=0;
        end
    elseif CaseLandscape == 3
        if paramvalue>=0 %Meri: This condition was missing. Needed to get the two attractors we want
            parameterOK=0;
        end
        
    elseif CaseLandscape == 4
        if paramvalue>=0
            parameterOK=0;
        end
    end
        
elseif paramnumber==5   
    %v
    if CaseLandscape == 1
        if paramvalue<=0
            parameterOK=0;
        end
    elseif CaseLandscape == 2
        if paramvalue<=0
            parameterOK=0;
        end
    elseif CaseLandscape == 3
       
    elseif CaseLandscape == 4
%         if paramvalue>=0
%             parameterOK=0;%Meri: Not necessarily true. Some positive values work fine
%         end
    end

end

