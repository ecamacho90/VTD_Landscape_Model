%% Master file

%% Add folders to path
addpath(genpath('Model'))
addpath(genpath('solvers'))

%% Load the parameters

SetModelParam

global ModelParam

%% If using linear Noise approximation to compute initial condition run this part, otherwise skip

%Time for initial condition:
t0lna = 0;
t1lna = 10;
dtlna = 0.1;
tspanlna=t0lna:dtlna:t1lna;

%Number of subintervals:
Mlna = length(tspanlna)-1;

%Initial condition:
initcond = [-1 0];
N01 = randn(2,ModelParam.nsimulations);

[y0,CovMat0] = lna_v1(initcond,t0lna,t1lna,Mlna,zeros(2),[ModelParam.pPC,ModelParam.DiffusionConstant],2);


L = chol(CovMat0,'lower'); %It's faster than simply chol, if CovMat is sparse.

ModelParam.InitialCondition = repmat(y0,1,ModelParam.nsimulations) + L*N01;  %Z is a matrix with nsimulations columns and each column is a solution


%% Run the Euler-Maruyama algorithm to find the stochastic trajectories

solutionorfates = 1; % 1 if the solution is the end point of the trajectories, 0 if the fates (when we know when to compute them)

sol = simulationEulerACablation_Competence_v9(solutionorfates);