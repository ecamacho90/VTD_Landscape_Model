%% Master file

%% Add folders to path
addpath(genpath('Model'))
addpath(genpath('solvers'))

%% Load the parameters

%  SetModelParam
%  
global ModelParam

%%If using linear Noise approximation to compute initial condition run this part, otherwise skip

% %Time for initial condition:
% t0lna = 0;
% t1lna = 10;
% dtlna = 0.1;
% tspanlna=t0lna:dtlna:t1lna;
% 
% %Number of subintervals:
% Mlna = length(tspanlna)-1;
% 
% %Initial condition:
% initcond = [-2 -2];
% N01 = randn(2,ModelParam.nsimulations);
% 
% [y0,CovMat0] = lna_v2(initcond,t0lna,t1lna,Mlna,zeros(2),[ModelParam.pPC,ModelParam.DiffusionConstant],2);
% 
% L = chol(CovMat0,'lower'); %It's faster than simply chol, if CovMat is sparse.
% 
% XY0 = repmat(y0,1,ModelParam.nsimulations) + L*N01;  %Z is a matrix with nsimulations columns and each column is a solution

%% Run the Euler-Maruyama algorithm to find the stochastic trajectories

SetModelParam;%Set initial parameters, common to all experiments
solutionorfates = 1; % 1 if the solution is the end point of the trajectories, 0 if the fates (when we know when to compute them)

ExpConditions = {'NoChir','Chir23','Chir25','Chir25FGF23','Chir25FGF25',... %used to choose inital parameters
                'Chir225','Chir235','Chir24','Chir25FGF235','Chir25FGF24','Chir25FGF245'}; %Remaining conditions with data

nsim = ModelParam.nsimulations;

sol = zeros(2,7,nsim*numel(ExpConditions));

for Expidx=1:numel(ExpConditions)
    EC=ExpConditions{Expidx};
    str=['SetModelParam_',EC];%Set condition specific parameters
    h=str2func(str);
    h();
    sol(:,:,1+nsim*(Expidx-1):nsim*Expidx) = simulationEulerVTD_12hourMes_v5(solutionorfates);
end
[fates,Colors] = computefates_GaussMix(sol); %6 fates considered being one cells in transition
for Expidx=1:numel(ExpConditions)
    EC=ExpConditions{Expidx};
    
    figure;%Plot trajectories at fixed time points
    sgtitle(EC)
    for i=1:7
        subplot(3,3,i);
        hold on;
        scatter(squeeze(sol(1,i,1+nsim*(Expidx-1):500*Expidx)), squeeze(sol(2,i,1+nsim*(Expidx-1):nsim*Expidx)),10,squeeze(Colors(1+nsim*(Expidx-1):nsim*Expidx,i,:)));
        title(['t= ', num2str((i-1)*12)]);
        xlim([-12,5]);
        ylim([-6,7]);
    end

    proportions = zeros(7,5);%Compute and plot proportions
    for i=1:6
        proportions(1:7,i) = sum(fates(1+500*(Expidx-1):500*Expidx,:)==i,1)/5;
    end

    figure;
    sgtitle([EC,' Proportions']);
    colorMatWithValsG(proportions);
    set(gca,'yticklabel',[2,2.5,3,3.5,4,4.5,5]);

end

