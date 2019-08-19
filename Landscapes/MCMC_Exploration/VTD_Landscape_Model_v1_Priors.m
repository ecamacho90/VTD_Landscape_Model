function pvalue=VTD_Landscape_Model_v1_Priors(paramnumber,CaseLandscape)

if paramnumber==1
    %a
    if CaseLandscape == 1
        %pvalue = -random('Gamma',10,0.9);
        pvalue = -random('Gamma',12,1.1);%% 50% with height saddles
    elseif CaseLandscape == 2
        pvalue = -random('Gamma',10,0.9);
    elseif CaseLandscape == 3
        pvalue = -random('Gamma',10,0.9);
    elseif CaseLandscape == 4
        pvalue = -random('Gamma',8,0.5);
    end

    
elseif paramnumber==2
    %b
    if CaseLandscape == 1
        %pvalue = random('Gamma',3.5,1.5);
        pvalue = random('Gamma',3,1);
    elseif CaseLandscape == 2
        pvalue = -random('Gamma',8.1,1.1);
    elseif CaseLandscape == 3
        pvalue = -random('Gamma',3.5,1.5);
    elseif CaseLandscape == 4
        pvalue = -random('Gamma',36,0.35);
    end

elseif paramnumber==3
    %c
    if CaseLandscape == 1
    pvalue = -random('Gamma',2,2);
    elseif CaseLandscape == 2
    pvalue = -random('Gamma',3,1.5);
    elseif CaseLandscape == 3
    pvalue = -random('Gamma',2,2);
    elseif CaseLandscape == 4
    pvalue = random('Normal',0,3);
    end
    
elseif paramnumber==4   
    %u
    if CaseLandscape == 1
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',3.7,6);
    elseif CaseLandscape == 2
        pvalue = -random('Uniform',0,50);
    elseif CaseLandscape == 3
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Uniform',40,80);
        %pvalue = random('Gamma',2,6)-50;
    elseif CaseLandscape == 4
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',2,10);
    end
        
elseif paramnumber==5   
    %v
    if CaseLandscape == 1
       %pvalue = random('Uniform',0,50);%%12%
        pvalue = random('Gamma',3.5,4.5);
    elseif CaseLandscape == 2
        pvalue = random('Uniform',0,50);
    elseif CaseLandscape == 3
        %pvalue = random('Uniform',-30,30);
        pvalue = random('Gamma',2.5,5)-20; %%70%
        %pvalue = random('Normal',0,15);
    elseif CaseLandscape == 4
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',4,5)+15;
    end

end