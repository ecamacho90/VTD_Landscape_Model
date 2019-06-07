function SetModelParam


% for use with SimulationEulerMaruyama_VTD_Competence_v1

global ModelParam;

fprintf(1, '%s called to define params\n',mfilename);

ModelParam.modelName = 'VTD_landscape_model_v1';

ModelParam.t0 = 0;    % Start of the experiment (time in hours)
ModelParam.tF = 4*24; % End of the experiment (time in hours)
ModelParam.dt = 0.1;  % Time step

%                                WNT  FGF  a11  a12  a21  a22  a31  a32  b1  b2  b3  Tau
ModelParam.InitialParameters = [  0    1    1    0    0    1    0    0   0   0   1.5 1  ]; % Parameters
ModelParam.M = (ModelParam.tF-ModelParam.t0)/ModelParam.dt;
ModelParam.nfates = 4;

%% Parameters post-competence (if we decide to do this)
% Run the system without signals for a short period of time

ModelParam.PC = 1; %1 if doing post-competence step, 0 otherwise
ModelParam.MPC = 10; % Number of steps post-competence
ModelParam.dtPC = 0.1; % Time-step post-competence

ModelParam.pPC = ModelParam.InitialParameters; %Parameters post-Competence
ModelParam.pPC(1:2) = [0,0];



%% Parameters for the solver

ModelParam.y0 = [0 0]'; %Deterministing Initial condition. For example [0,0]
ModelParam.nsimulations = 10; %Number of simulations
ModelParam.DiffusionConstant = 0.01; %Difusion constant for the noise
ModelParam.InitialCondition = repmat(ModelParam.y0,1,ModelParam.nsimulations)+randn(2,ModelParam.nsimulations)*sqrt(ModelParam.DiffusionConstant); %This will be substituted by the solution coming fron the LNA
ModelParam.NoiseX = randn(ModelParam.nsimulations,ModelParam.M)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt); 
ModelParam.NoiseY = randn(ModelParam.nsimulations,ModelParam.M)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt); 
if ModelParam.PC
    ModelParam.NoiseXPC = randn(ModelParam.nsimulations,ModelParam.MPC)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt); 
    ModelParam.NoiseYPC = randn(ModelParam.nsimulations,ModelParam.MPC)*sqrt(2*ModelParam.DiffusionConstant*ModelParam.dt);     
end

%% Media changes

ModelParam.tMediaChanges = [ModelParam.t0;48;72;ModelParam.tF]; % Times at which there was a media change (time in hours), and the final time
ModelParam.nMediaChanges = length(ModelParam.tMediaChanges)-1;

%                            WNT  FGF  a11  a12  a21  a22  a31  a32  b1  b2  b3  Tau
ModelParam.pMediaChanges = [  0    1    1    0    0    1    0    0   0   0   1.5 1  ;   % Parameters at the start of the experiment
                              1    1    1    0    0    1    0    0   0   0   1.5 1  ;   % Parameters first media change
                              1    0    1    0    0    1    0    0   0   0   1.5 1  ];  % Parameters second media change

ModelParam.Mmediachanges = [0; cumsum((ModelParam.tMediaChanges(2:end) - ModelParam.tMediaChanges(1:end-1))/ModelParam.dt)];                          

end