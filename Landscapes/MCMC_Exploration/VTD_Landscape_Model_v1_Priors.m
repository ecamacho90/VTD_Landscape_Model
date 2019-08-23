function pvalue=VTD_Landscape_Model_v1_Priors(paramnumber,CaseLandscape)

if paramnumber==1
    %a
    if CaseLandscape == 1
        %pvalue = -random('Gamma',10,0.9);
        pvalue = -random('Gamma',12,1.1);%% 50% with height saddles
    elseif CaseLandscape == 2
        pvalue = -random('Gamma',10,0.9);
    elseif CaseLandscape == 3
%         pvalue = -random('Gamma',10,0.9);
          pvalue = -random('Gamma',11.6,0.6); %From fitting Case 3
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
%         pvalue = -random('Gamma',3.5,1.5);
        pvalue = -random('Gamma',4.8,0.7); %From fitting Case 3
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
%     pvalue = -random('Gamma',2,2);
        pvalue = -random('Gamma',2.4,1.2); %From fitting Case 3
    elseif CaseLandscape == 4
%     pvalue = random('Normal',0,3);
        pvalue = random('Normal',-1,2.8);
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
%         pvalue = -random('Uniform',40,80);
        %pvalue = random('Gamma',2,6)-50;
        pvalue = random('Gamma',1.22,6.7); %From fitting Case 3
    elseif CaseLandscape == 4
%         pvalue = -random('Uniform',0,50);
        pvalue = -random('Gamma',1.5,12.9);
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
%         pvalue = random('Gamma',2.5,5)-20; %%70%
        %pvalue = random('Normal',0,15);
        pvalue = random('Gamma',2.4,9.7)-30; %From fitting Case 3
    elseif CaseLandscape == 4
%         pvalue = -random('Uniform',0,50);
%         pvalue = -random('Gamma',4,5)+15;
        pvalue = -random('Gamma',1.55,11.9);
    end

end