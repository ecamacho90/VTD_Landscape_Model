function sol=simulationEulerVTD_vectorised_Pred(t0,dt,tF,nsimulations,InitialCondition,nMediaChanges,Mmediachanges,pMediaChanges,NoiseX,NoiseY)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                        %
%          v1 Vertebrate Trunk Development Euler-Maruyama                %
%                                                                        %
%  By using the Euler Scheme:                                            %
%  This programme compute nsimulations simulations, and for each         %
%  simulation we discretise the time interval into subintervals,         %
%  saving 12 hour mesurement points of the simulation.                   %                                           
%                                                                        %
%  sol is a matrix: can be a matrix of solutions for each simulation or  %
%  a vector giving the proportion of times that the cells fell in each   %
%  basin of attraction.                                                  %
%                                                                        %                                              
%                                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%modeleq=str2func('VTD_Landscape_Model_Fitting_v1');
modeleq=str2func('VTD_Landscape_Model_Pred_v2');


simulateddata = zeros(2,tF/12+1, nsimulations);

                            
% tic    
%Simulations:
%------------

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   With Post-Competence period
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
    
ChirTime = 0;

Xprev=InitialCondition;    %Set the initial point for each cell at the new simulation
simulateddata(:,1,:)=InitialCondition;%[Xprev'], computefates_signs(Xprev)];
measurement =1;
             
%%%%%%%%%%%%%%%%%%%%%
% COMPETENCE:
%%%%%%%%%%%%%%%%%%%%%
%tic

% hold on
%Colors = {'b','r','n','g','y','m','k','w'};
for mediachange = 1:nMediaChanges

   for timestep=(Mmediachanges(mediachange)+1):Mmediachanges(mediachange+1)

       [dtfprev,ChirTime]=modeleq(t0+(timestep-1)*dt,Xprev,...
           pMediaChanges(mediachange,:),dt, ChirTime );       %Evaluate f at the previous state
        Xprev=Xprev+dt*dtfprev+[NoiseX(timestep,:);NoiseY(timestep,:)];  %Renew the state taking an Euler Step
        
        
    if t0+timestep*dt==measurement*12
%       disp(['measurement ', num2str(measurement+1)]);
       simulateddata(:,measurement+1,:)=Xprev;
       measurement =measurement+1; 
%        scatter(Xprev(1,:),Xprev(2,:),'filled','MarkerFaceAlpha',0.2,'MarkerFaceColor',Colors{measurement})
%        title(num2str(t0+timestep*dt))
%        pause()
    end

   end

end

sol=simulateddata;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Elena 06/06/19  First version of the Euler Maruyama scheme for solving
%                 the equation of the landscape in a stochastic manner.
%                 Remember to change the division by the nsimulations after
%                 the for loop of the simulations so that it's faster.

% Elena 12/09/19  Second version of the Euler Maruyama scheme for solving
%                 the equation of the landscape in a stochastic manner.
%                 Vectorized computation to make it faster

%%

%simulationEulerVTD_vectorised.m (c) by Elena Camacho Aguilar

%simulationEulerVTD_vectorised.m is licensed under a 
%Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0) Unported License.

%You should have received a copy of the license along with this
%work.  If not, see <https://creativecommons.org/licenses/by-nc-sa/4.0/>.