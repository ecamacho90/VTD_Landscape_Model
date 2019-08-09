function priorOK=VTD_Landscape_Model_v1_Relations_Constraints1(paramaux,CaseLandscape)

priorOK = 0;




%Initial parameters:
if CaseLandscape==1
    if paramaux(3)>2*paramaux(1)
        priorOK=1;
    end

elseif CaseLandscape==2
    if paramaux(3)>2*paramaux(1)
        if paramaux(3)<paramaux(1)
            priorOK=1;
        end
    end   
    
elseif CaseLandscape==3
  
elseif CaseLandscape==4

    if paramaux(2)<(paramaux(1)-8)
        priorOK=1;
    end

    
end