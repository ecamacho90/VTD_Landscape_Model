function simulations = VTD_Landscape_Model_Pred_v1_AbsDistance_Gauss_Fates_EachMut(t0,dt,t1,InitialCondition,nsimulations,paramsimulations,NoiseX,NoiseY,mutantnumber)



%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
if mutantnumber == 1        %NoC_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0      1   paramsimulations(3:end); ...
                       0    0.9   paramsimulations(3:end)]; %Replace first two elements of vector

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];                          

    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

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

    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%--------------------------------------------------------------------------------------------- 

elseif mutantnumber == 3    %C23_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;
    
%                     WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       0    0.9   paramsimulations(3:end)];
                 
    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];                          

    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
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

    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

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
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------

elseif mutantnumber == 6    %C25_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1    0.9   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
        
elseif mutantnumber == 7    %C25_F23_180814
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
        
elseif mutantnumber == 8    %C25_F235_180814
    
    tMediaChanges = [t0;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
    
elseif mutantnumber == 9    %C25_F24_180814
    
    tMediaChanges = [t0;48;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------
        
elseif mutantnumber == 10    %C25_F245_180814
    
    tMediaChanges = [t0;60;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------   

elseif mutantnumber == 11    %C25_F25_180814
    
    tMediaChanges = [t0;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------    

elseif mutantnumber == 12 %Pulsing
    tMediaChanges = [t0;12;24;36;48;60;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------    

elseif mutantnumber == 13 %Pulsing
    tMediaChanges = [t0;24;48;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

%---------------------------------------------------------------------------------------------
%---------------------------------------------------------------------------------------------    
    
elseif mutantnumber == 14 %Pulsing
    tMediaChanges = [t0;36;48;60;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 15 %Pulsing
    tMediaChanges = [t0;48;60;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 16 %Pulsing
    tMediaChanges = [t0;24;36;48;60;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 17 %Pulsing
    tMediaChanges = [t0;12;18;24;30;36;42;48;54;60;66;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 18 %Pulsing
    tMediaChanges = [t0;18;24;30;36;42;48;54;60;66;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);


elseif mutantnumber == 19 %Pulsing
    tMediaChanges = [t0;24;30;36;42;48;54;60;66;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 20 %Pulsing
    tMediaChanges = [t0;12;15;18;21;24;27;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 21 %Pulsing
    tMediaChanges = [t0;18;21;24;27;30;33;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
    
elseif mutantnumber == 22 %Pulsing
    tMediaChanges = [t0;24;27;30;33;36;39;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 23 %Pulsing
    tMediaChanges = [t0;30;33;36;39;42;45;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 24 %Pulsing
    tMediaChanges = [t0;36;39;42;45;48;51;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 25 %Reduced CHIR concentration from Day 3
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.1     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 26 %Reduced CHIR concentration from Day 3
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.3     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 27 %Reduced CHIR concentration from Day 3
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.5     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 28 %Reduced CHIR concentration from Day 3 
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.7     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 29 %Reduced CHIR concentration from day 3.5
    tMediaChanges = [t0;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.1     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 30 %Reduced CHIR concentration from day 3.5
    tMediaChanges = [t0;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.3     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 31 %Reduced CHIR concentration from day 3.5
    tMediaChanges = [t0;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.5     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 32 %Reduced CHIR concentration from day 3.5
    tMediaChanges = [t0;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                      0.7     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%
elseif mutantnumber == 33 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.1      1   paramsimulations(3:end);
                      0.1     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 34 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.2      1   paramsimulations(3:end);
                      0.2     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 35 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.3      1   paramsimulations(3:end);
                      0.3     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 36 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.5      1   paramsimulations(3:end);
                      0.5     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 37 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.7      1   paramsimulations(3:end);
                      0.7     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 38 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.9      1   paramsimulations(3:end);
                      0.9     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%
elseif mutantnumber == 39 %One pulse of CHIR at day 3
    tMediaChanges = [t0;24;27;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        1     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 40 %One pulse of CHIR at day 3
    tMediaChanges = [t0;24;30;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        1     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 41 %One pulse of CHIR at day 3
    tMediaChanges = [t0;24;33;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        1     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 42 %One pulse of CHIR at day 2.75
    tMediaChanges = [t0;18;21;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        1     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 43 %One pulse of CHIR at day 2.75
    tMediaChanges = [t0;18;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        1     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 44 %One pulse of CHIR at day 2.75
    tMediaChanges = [t0;18;27;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        1     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
 elseif mutantnumber == 45 %One pulse of 0.5 CHIR at day 3
    tMediaChanges = [t0;24;30;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        0.5     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 46 %One pulse of 0.5 CHIR at day 3
    tMediaChanges = [t0;24;36;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        0.5     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 47 %One pulse of 0.5 CHIR at day 3
    tMediaChanges = [t0;24;48;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   0      1   paramsimulations(3:end);
                        0.5     0.9   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 48 %One pulse of CHIR at day 2
    tMediaChanges = [t0;3;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   1      1   paramsimulations(3:end);
                        0      1   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
   
elseif mutantnumber == 49 %One pulse of CHIR at day 2
    tMediaChanges = [t0;6;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   1      1   paramsimulations(3:end);
                        0      1   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 50 %One pulse of CHIR at day 2
    tMediaChanges = [t0;9;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [   1      1   paramsimulations(3:end);
                        0      1   paramsimulations(3:end);
                        0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%---------------
%----------------
elseif mutantnumber == 51 %Pulsing
    tMediaChanges = [t0;12;15;18;21;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 52 %Pulsing
    tMediaChanges = [t0;18;21;24;27;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       1      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 53    %CHIR 2-5. Reduced FGF cocentration
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0.1   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 54    %CHIR 2-5. Reduced FGF cocentration
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0.3   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 55    %CHIR 2-5. Reduced FGF cocentration
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0.5   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 56    %CHIR 2-5. Reduced FGF cocentration
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end); ...
                       1      0.7   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%-------------------------------------
elseif mutantnumber ==57 %CHIR introduced at Day 2.5
    
    tMediaChanges = [t0;12;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0      1   paramsimulations(3:end); ...
                       1      1   paramsimulations(3:end); ...
                       1    0.9   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);


elseif mutantnumber ==58 %CHIR introduced at Day 3
    
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0      1   paramsimulations(3:end); ...
                       1      0.9   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber ==59 %CHIR pulse at day 2.5
    
    tMediaChanges = [t0;12;15;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0      1   paramsimulations(3:end); ...
                       1      1   paramsimulations(3:end); ...
                       0      1   paramsimulations(3:end); ...
                       0      0.9   paramsimulations(3:end)];

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% After new data
elseif mutantnumber == 60 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.65      1   paramsimulations(3:end);
                      0.65     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

    
elseif mutantnumber == 61 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.65      1   paramsimulations(3:end);
                      0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 62 %Reduced CHIR concentration from day 2
    tMediaChanges = [t0;12;24;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [ 0.65      1   paramsimulations(3:end);
                      0      1   paramsimulations(3:end);
                      0     0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
elseif mutantnumber == 63 %Pulsing
    tMediaChanges = [t0;12;15;18;21;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0.75      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       0.85      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       0.85      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);

elseif mutantnumber == 64 %Pulsing
    tMediaChanges = [t0;12;15;18;21;24;27;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  0.75      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       0.85      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       0.85      1   paramsimulations(3:end);
                       0      1   paramsimulations(3:end);
                       0.85      1   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);
%%
elseif mutantnumber == 65 %More Stable Epi
    tMediaChanges = [t0;48;t1]; % Times at which there was a media change (time in hours), and the final time
    nMediaChanges = length(tMediaChanges)-1;

    %                 WNT    FGF  
    pMediaChanges = [  1      1   paramsimulations(3:end);
                       1      0.9   paramsimulations(3:end)];
           

    Mmediachanges = [0; cumsum((tMediaChanges(2:end) - tMediaChanges(1:end-1))/dt)];       
    
    simulations = simulationEulerVTD_vectorised_Pred_exp(t0,dt,t1,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY);


    
end
