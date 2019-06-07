function sol=simulationEulerACablation_Competence_v9(solutionorfates)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%          v1 Vertebrate Trunk Development Euler-Maruyama                %
%                                                                        %
%  By using the Euler Scheme:                                            %
%  This programme compute nsimulations simulations, and for each         %
%  simulation we discretise the time interval into subintervals,         %
%  only saving the last time point of the simulation.                    %                                             %
%                                                                        %
%  sol is a matrix can be a matrix of solutions for each simulation or   %
%  a vector giving the proportion of times that the cells fell in each   %
%  basin of attraction.                                                  %
%                                                                        %                                                       %
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SetModelParam
global ModelParam

modeleq=str2func(ModelParam.modelName);


if solutionorfates
simulateddata=zeros(2,ModelParam.nsimulations);

else
    
    simulateddata = zeros(1,ModelParam.nfates+1);
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

      Xprev=ModelParam.InitialCondition(:,simulation);    %Set the initial point for each cell at the new simulation
    
       
      %%%%%%%%%%%%%%%%%%%%%
      % COMPETENCE:
      %%%%%%%%%%%%%%%%%%%%%
      
        for mediachange = 1:ModelParam.nMediaChanges

           for timestep=(ModelParam.Mmediachanges(mediachange)+1):ModelParam.Mmediachanges(mediachange+1)

                dtfprev=ModelParam.dt*modeleq(ModelParam.t0+(timestep-1)*ModelParam.dt,Xprev,ModelParam.pMediaChanges(mediachange,:));       %Evaluate f at the previous state

                Xprev=Xprev+dtfprev+[ModelParam.NoiseX(simulation,timestep);ModelParam.NoiseY(simulation,timestep)];  %Renew the state taking an Euler Step

           end

        end
        
      %%%%%%%%%%%%%%%%%%%%%
      % POST - COMPETENCE:
      %%%%%%%%%%%%%%%%%%%%%
    
        for timestep = 1:ModelParam.MPC

            dtfprev=ModelParam.dtPC*modeleq(ModelParam.tF+(timestep-1)*ModelParam.dtPC,Xprev,ModelParam.pPC);       %Evaluate f at the previous state

            Xprev=Xprev+dtfprev+[ModelParam.NoiseXPC(simulation,timestep);ModelParam.NoiseYPC(simulation,timestep)];  %Renew the state taking an Euler Step


        end
        
      %%%%%%%%%%%%%%%%%%%%%
      % SOLUTION
      %%%%%%%%%%%%%%%%%%%%%
        if solutionorfates
            
            simulateddata(:,simulation)=Xprev;
            
        else
          %%%%%%%%%%%%%%%%%%%%%
          % FATES:
          %%%%%%%%%%%%%%%%%%%%%    

            if norm(Xprev)<10^10
                fatessimulated = computefates(Xprev);  %Compute the fates corresponding to the end point of the simulated trajectory after competence
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
    
else  %Otherwise there is AC ablation and we compute the fates with respect to the parameters where EGF is set to 0.
    
    for simulation=1:ModelParam.nsimulations

          Xprev=ModelParam.InitialCondition(:,simulation);    %Set the initial point for each cell at the new simulation


          %%%%%%%%%%%%%%%%%%%%%
          % COMPETENCE:
          %%%%%%%%%%%%%%%%%%%%%

            for mediachange = 1:ModelParam.nMediaChanges

               for timestep=(ModelParam.Mmediachanges(mediachange)+1):ModelParam.Mmediachanges(mediachange+1)

                    dtfprev=ModelParam.dt*modeleq(ModelParam.t0+(timestep-1)*ModelParam.dt,Xprev,ModelParam.pMediaChanges(mediachange,:));       %Evaluate f at the previous state

                    Xprev=Xprev+dtfprev+[ModelParam.NoiseX(simulation,timestep);ModelParam.NoiseY(simulation,timestep)];  %Renew the state taking an Euler Step

               end

            end


          %%%%%%%%%%%%%%%%%%%%%
          % SOLUTION
          %%%%%%%%%%%%%%%%%%%%%
            if solutionorfates

            simulateddata(:,simulation)=Xprev;

            else
              %%%%%%%%%%%%%%%%%%%%%
              % FATES:
              %%%%%%%%%%%%%%%%%%%%%    

                if norm(Xprev)<10^10
                    fatessimulated = computefates(Xprev);  %Compute the fates corresponding to the end point of the simulated trajectory after competence
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