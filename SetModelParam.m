function SetModelParam

%Sets Common parameters for all experimental conditions: Initial state,
%time, noise...

% for use with MasterFile or simulationEulerVTD_12hourMes_v5

global ModelParam;

fprintf(1, '%s called to define params\n',mfilename);

ModelParam.modelName = 'VTD_landscape_model_v6';

ModelParam.t0 = 0;    % Start of the experiment (time in hours)
ModelParam.tF = 3*24; % End of the experiment (time in hours)
ModelParam.dt = 0.01;  % Time step

%                                WNT  FGF 
ModelParam.InitialParameters = [  0    1 ];
ModelParam.M = (ModelParam.tF-ModelParam.t0)/ModelParam.dt;
ModelParam.nfates = 5;

%% Parameters post-competence (if we decide to do this)
% Run the system without signals for a short period of time

ModelParam.PC = 0; %1 if doing post-competence step, 0 otherwise
ModelParam.MPC = 10; % Number of steps post-competence
ModelParam.dtPC = 0.1; % Time-step post-competence

ModelParam.pPC = ModelParam.InitialParameters; %Parameters post-Competence
ModelParam.pPC(1:2) = [0,0];



%% Parameters for the solver

ModelParam.y0 = [-8 3]'; %Deterministic Initial condition. For example [0,0]
ModelParam.nsimulations = 500; %Number of simulations
ModelParam.DiffusionConstant = 0.2; %Difusion constant for the noise
ModelParam.InitialCondition = repmat(ModelParam.y0,1,ModelParam.nsimulations)+randn(2,ModelParam.nsimulations)*sqrt(ModelParam.DiffusionConstant); %This will be substituted by the solution coming from the LNA
ModelParam.NoiseX = randn(ModelParam.nsimulations,ModelParam.M)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt); 
ModelParam.NoiseY = randn(ModelParam.nsimulations,ModelParam.M)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt); 
if ModelParam.PC
    ModelParam.NoiseXPC = randn(ModelParam.nsimulations,ModelParam.MPC)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt); 
    ModelParam.NoiseYPC = randn(ModelParam.nsimulations,ModelParam.MPC)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt);     
end
end