function pvalue=VTD_Landscape_Model_v1_Priors(paramnumber,CaseLandscape)

if paramnumber==1
    %a
    if CaseLandscape == 1
        %pvalue = -random('Gamma',10,0.9);
        pvalue = -random('Gamma',21,0.6);%% 80% -> 40% with height saddles
    elseif CaseLandscape == 2
        pvalue = -random('Gamma',10,0.9);
    elseif CaseLandscape == 3
        pvalue = -random('Gamma',13,0.6);
    elseif CaseLandscape == 4
        pvalue = -random('Gamma',8,0.5);
    end

    
elseif paramnumber==2
    %b
    if CaseLandscape == 1
        %pvalue = random('Gamma',3.5,1.5);
        pvalue = random('Gamma',3.5,0.8);
    elseif CaseLandscape == 2
        pvalue = -random('Gamma',9.2,1);
    elseif CaseLandscape == 3
        pvalue = -random('Gamma',5,0.6);
    elseif CaseLandscape == 4
        pvalue = -random('Gamma',40,0.3);
    end

% elseif paramnumber==3
%     %c
%     if CaseLandscape == 1
%     pvalue = -random('Gamma',2,2);
%     elseif CaseLandscape == 2
%     pvalue = -random('Gamma',3,1.5);
%     elseif CaseLandscape == 3
%     pvalue = -random('Gamma',2,2);
%     elseif CaseLandscape == 4
%     pvalue = random('Normal',0,3);
%     end
    
elseif paramnumber==4   
    %u
    if CaseLandscape == 1
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',5.4,4);
    elseif CaseLandscape == 2
        pvalue = -random('Uniform',0,50);
    elseif CaseLandscape == 3
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Uniform',40,80);
        %pvalue = random('Gamma',2,6)-50;
    elseif CaseLandscape == 4
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',2,9);
    end
        
elseif paramnumber==5   
    %v
    if CaseLandscape == 1
       %pvalue = random('Uniform',0,50);%%12%
        pvalue = random('Gamma',5.2,3);
    elseif CaseLandscape == 2
        pvalue = random('Uniform',0,50);
    elseif CaseLandscape == 3
        %pvalue = random('Uniform',-30,30);
        pvalue = random('Gamma',2.7,8.4)-30; %%70%
        %pvalue = random('Normal',0,15);
    elseif CaseLandscape == 4
        %pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',5,4)+15;
    end

end