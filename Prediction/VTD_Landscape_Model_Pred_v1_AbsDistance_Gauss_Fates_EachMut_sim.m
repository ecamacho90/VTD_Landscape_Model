function simulations = VTD_Landscape_Model_Pred_v1_AbsDistance_Gauss_Fates_EachMut_sim(t0,dt,t1,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantnumber)



%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
if mutantnumber == 1        %NoC_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0      1   paramsimulations(3:end); ...
                       0    0.9   paramsimulations(3:end)]; %Replace first two elements of vector

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];                          

    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    %---------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------- 

elseif mutantnumber == 2    %C225_180814
    
    tMediaChanges = [t0;12;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;
    
%                     WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       0      1   paramsimulations(3:end); ...
                       0    0.9   paramsimulations(3:end)];
                 
    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];                          

    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------- 

elseif mutantnumber == 3    %C23_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;
    
%                     WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       0    0.9   paramsimulations(3:end)];
                 
    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];                          

    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
    %---------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------- 

elseif mutantnumber == 4    %C235_180814
    
    tMediaChanges = [t0;24;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;
    
%                     WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1    0.9   paramsimulations(3:end);...
                       0    0.9   paramsimulations(3:end)];
                 
    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];                          

    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------- 

elseif mutantnumber == 5    %C24_180814
    
    tMediaChanges = [t0;24;48;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1    0.9   paramsimulations(3:end); ...
                       0    0.9   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------

elseif mutantnumber == 6    %C25_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1    0.9   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
        
elseif mutantnumber == 7    %C25_F23_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
        
elseif mutantnumber == 8    %C25_F235_180814
    
    tMediaChanges = [t0;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
    
elseif mutantnumber == 9    %C25_F24_180814
    
    tMediaChanges = [t0;48;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
        
elseif mutantnumber == 10    %C25_F245_180814
    
    tMediaChanges = [t0;60;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------   

elseif mutantnumber == 11    %C25_F25_180814
    
    tMediaChanges = [t0;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_sim(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------    

end
end