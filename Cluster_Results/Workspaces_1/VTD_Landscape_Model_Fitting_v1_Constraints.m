function parameterOK=VTD_Landscape_Model_Fitting_v1_Constraints(paramvalue,paramnumber)


%This function is to check that the parameters take the allowed values.

parameterOK=1;


if paramnumber==1
    %WNT
        if paramvalue<0
            parameterOK=0;
        end
elseif paramnumber == 2
    %FGF
        if paramvalue<0
            parameterOK=0;
        end
elseif paramnumber == 3
    %a0
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 4
    %b0
        if paramvalue<=0
            parameterOK=0;
        end
        
elseif paramnumber == 5
    %c0
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 6
    %u0
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 7
    %v0
        if paramvalue<=0
            parameterOK=0;
        end
elseif paramnumber == 8
    %a1
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 9
    %b1
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 10
    %c1
       
elseif paramnumber == 11
    %u1
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 12
    %v1
        if paramvalue<=0
            parameterOK=0;
        end
elseif paramnumber == 13
    %a2
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 14
    %b2
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 15
    %c2
        
elseif paramnumber == 16
    %u2
        if paramvalue>=0 %Meri: This condition was missing. Needed to get the two attractors we want
            parameterOK=0;
        end
elseif paramnumber == 17
    %v2
    
elseif paramnumber == 18
    %a3
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 19
    %b3        
        if paramvalue>=0
            parameterOK=0;
        end

elseif paramnumber == 20
    %c3
elseif paramnumber == 21
    %u3
        if paramvalue>=0
            parameterOK=0;
        end
elseif paramnumber == 22
    %v3

end

