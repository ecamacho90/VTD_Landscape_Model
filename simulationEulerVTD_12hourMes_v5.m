function sol=simulationEulerVTD_12hourMes_v5(solutionorfates)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%          v5 Vertebrate Trunk Development Euler-Maruyama                %
%                                                                        %
%  By using the Euler Scheme:                                            %
%  This programme compute nsimulations simulations, and for each         %
%  simulation we discretise the time interval into subintervals,         %
%  saving 12 hour mesurement points of the simulation.                   %                                             %
%                                                                        %
%  sol is a matrix: can be a matrix of solutions for each simulation or   %
%  a vector giving the proportion of times that the cells fell in each   %
%  basin of attraction.                                                  %
%                                                                        %                                                       %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global ModelParam

modeleq=str2func(ModelParam.modelName);

if solutionorfates
    simulateddata=zeros(2,ModelParam.tF/12+1, ModelParam.nsimulations);
else
    simulateddata = zeros(1,ModelParam.tF/12+1, ModelParam.nfates+1);
end
                            
tic    
%Simulations:
%------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   With Post-Competence period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ModelParam.PC  
    
      for simulation=1:ModelParam.nsimulations
        
          ChirTime = 0;

      Xprev=ModelParam.InitialCondition(:,simulation);    %Set the initial point for each cell at the new simulation
      simulateddata(:,1,simulation)=Xprev';%[Xprev'], computefates_signs(Xprev)];
      mesurement =1;
             
      %%%%%%%%%%%%%%%%%%%%%
      % COMPETENCE:
      %%%%%%%%%%%%%%%%%%%%%

        for mediachange = 1:ModelParam.nMediaChanges

           for timestep=(ModelParam.Mmediachanges(mediachange)+1):ModelParam.Mmediachanges(mediachange+1)

               dtfprev=ModelParam.dt*modeleq(ModelParam.t0+(timestep-1)*ModelParam.dt,Xprev,...
                   ModelParam.pMediaChanges(mediachange,:),ModelParam.pMediaChanges(mediachange,:), ModelParam.dt, ChirTime );       %Evaluate f at the previous state
                Xprev=Xprev+dtfprev+[ModelParam.NoiseX(simulation,timestep);ModelParam.NoiseY(simulation,timestep)];  %Renew the state taking an Euler Step
                
            if ModelParam.t0+timestep*ModelParam.dt>mesurement*12
               simulateddata(:,mesurement+1,simulation)=Xprev';
               mesurement =mesurement+1; 
            end

           end

        end
        
      %%%%%%%%%%%%%%%%%%%%%
      % POST - COMPETENCE:
      %%%%%%%%%%%%%%%%%%%%%
    
        for timestep = 1:ModelParam.MPC

            dtfprev=ModelParam.dtPC*modeleq(ModelParam.tF+(timestep-1)*ModelParam.dtPC,Xprev,ModelParam.pPC,...
                ModelParam.pMediaChanges(end,:), ModelParam.dtPC, ChirTime);       %Evaluate f at the previous state

            Xprev=Xprev+dtfprev+[ModelParam.NoiseXPC(simulation,timestep);ModelParam.NoiseYPC(simulation,timestep)];  %Renew the state taking an Euler Step
        
%             tspan = [ModelParam.tF+(timestep-1)*ModelParam.dt,ModelParam.tF+(timestep-0.5)*ModelParam.dt,ModelParam.tF+(timestep)*ModelParam.dt];   
%             [~, auxy]=ode45(@(t,y) modeleq(t,y,ModelParam.pPC),tspan, Xprev);            
%             Xprev = auxy(end,:)+ [ModelParam.NoiseX(simulation,timestep);ModelParam.NoiseY(simulation,timestep)]';
%            if rem(timestep,5)==0
%                 scatter(Xprev(1), Xprev(2),2,'m');
%            end
            if ModelParam.t0+timestep*ModelParam.dt>mesurement*12
                simulateddata(:,mesurement+1,simulation)=Xprev';%[Xprev', computefates_signs(Xprev)];
                mesurement =mesurement+1; 
            end
        end
        
      %%%%%%%%%%%%%%%%%%%%%
      % SOLUTION
      %%%%%%%%%%%%%%%%%%%%%
        if solutionorfates
            
            simulateddata(:,end,simulation)=Xprev';%[Xprev', computefates_signs(Xprev)];
         %   simulateddata(:,simulation)=[Xprev', computefates_saddles(Xprev)];
            
        else
          %%%%%%%%%%%%%%%%%%%%%
          % FATES:
          %%%%%%%%%%%%%%%%%%%%%    

            if norm(Xprev)<10^2
                fatessimulated = computefates_signs(Xprev);  %Compute the fates corresponding to the end point of the simulated trajectory after competence
            else
                fatessimulated = [zeros(1,ModelParam.nfatesnfates) 1];   
            end

                simulateddata=simulateddata+fatessimulated/nsimulations;   %Save the simulated fates.

        end
        
      end
      
%           sol=simulateddata/nsimulations;
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Without Post-Competence period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
else 
    
    
    for simulation=1:ModelParam.nsimulations
        ChirTime = 0;

        Xprev=ModelParam.InitialCondition(:,simulation);    %Set the initial point for each cell at the new simulation
        simulateddata(:,1,simulation)=Xprev';%[Xprev', computefates_signs(Xprev)];
        mesurement =1;

          %%%%%%%%%%%%%%%%%%%%%
          % COMPETENCE:
          %%%%%%%%%%%%%%%%%%%%%

            for mediachange = 1:ModelParam.nMediaChanges

               for timestep=(ModelParam.Mmediachanges(mediachange)+1):ModelParam.Mmediachanges(mediachange+1)

                   [dtfprev,ChirTime]=modeleq(ModelParam.t0+(timestep-1)*ModelParam.dt,Xprev,...
                   ModelParam.pMediaChanges(mediachange,:), ModelParam.dt, ChirTime);       %Evaluate f at the previous state
                    dtfprev = ModelParam.dt*dtfprev;
               
                    Xprev=Xprev+dtfprev+[ModelParam.NoiseX(simulation,timestep);ModelParam.NoiseY(simulation,timestep)];  %Renew the state taking an Euler Step
                    if ModelParam.t0+timestep*ModelParam.dt>mesurement*12
                        simulateddata(:,mesurement+1,simulation)=Xprev';%[Xprev', computefates_signs(Xprev)];
                        mesurement =mesurement+1; 
                    end
               end

            end


          %%%%%%%%%%%%%%%%%%%%%
          % SOLUTION
          %%%%%%%%%%%%%%%%%%%%%
            if solutionorfates
            
                simulateddata(:,end,simulation)=Xprev';%[Xprev', computefates_signs(Xprev)];

                %simulateddata(:,simulation)=Xprev;

            else
              %%%%%%%%%%%%%%%%%%%%%
              % FATES:
              %%%%%%%%%%%%%%%%%%%%%    

                if norm(Xprev)<10^2
                    fatessimulated = computefates(Xprev, ModelParam.pPC);  %Compute the fates corresponding to the end point of the simulated trajectory after competence
                else
                    fatessimulated = [zeros(1,ModelParam.nfatesnfates) 1];   
                end

                    simulateddata=simulateddata+fatessimulated/nsimulations;   %Save the simulated fates.

            end

    end
 
%           sol=simulateddata/nsimulations;   %Average the fates for the simulations




    

end
toc
sol=simulateddata;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Elena 06/06/19  First version of the Euler Maruyama scheme for solving
%                 the equation of the landscape in a stochastic manner.
%                 Remember to change the division by the nsimulations after
%                 the for loop of the simulations so that it's faster.